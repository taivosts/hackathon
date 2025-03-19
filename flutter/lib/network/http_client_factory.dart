import 'package:ai_dreamer/domain_models/credentials.dart';
import 'package:ai_dreamer/features/app/app_session.dart';
import 'package:ai_dreamer/features/common/dialogs/logout_dialog.dart';
import 'package:ai_dreamer/resource/app_constants.dart';
import 'package:ai_dreamer/utils/network_utils.dart';
import 'package:dio/dio.dart';

class HttpClientFactory {
  static Dio createDio() {
    final dio = Dio();
    dio.options.baseUrl = AppConstants.baseURL;
    final tokenDio = Dio();
    tokenDio.options = dio.options;
    dio.interceptors.add(_makeTokenInterceptor(dio, tokenDio));
    return dio;
  }

  static QueuedInterceptorsWrapper _makeTokenInterceptor(
      Dio dio, Dio tokenDio) {
    return QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        final credentials = await AppSession.shared.getCredentials();

        if (credentials == null) {
          return handler.next(options);
        }

        options.headers['Authorization'] = "Bearer ${credentials.accessToken}";
        return handler.next(options);
      },
      onError: (error, handler) async {
        /// Assume 401 stands for token expired
        if (error.response?.statusCode == 401) {
          final oldCredentials = await AppSession.shared.getCredentials();
          final options = error.response!.requestOptions;

          /// assume receiving the token has no errors
          /// to check `null-safety` and error handling
          /// please check inside the [onRequest] closure
          try {
            final tokenResult = await tokenDio.post(
              '/api/auth/refresh-token',
              data: oldCredentials?.toMap(),
            );

            /// update [Authorization]
            /// assume `token` is in response body
            final result = BaseResponse<Credentials>.fromMap(
              tokenResult.data,
              (data) => Credentials.fromMap(data),
            );
            if (result.data == null) {
              return handler.reject(
                DioException(requestOptions: options),
              );
            }

            await AppSession.shared.setCredentials(result.data);
            options.headers['Authorization'] =
                "Bearer ${result.data?.accessToken}";
            if (options.headers['Authorization'] != null) {
              final originResult = await dio.fetch(options..path);
              if (originResult.statusCode != null &&
                  originResult.statusCode! ~/ 100 == 2) {
                return handler.resolve(originResult);
              }
            }
            return handler.reject(
              DioException(requestOptions: options),
            );
          } catch (error) {
            LogoutDialog.show();
            return handler.reject(error as DioException);
          }
        }
        return handler.next(error);
      },
    );
  }
}
