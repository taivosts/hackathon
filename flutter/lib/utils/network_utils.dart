import 'dart:convert';
import 'dart:io';
import 'package:ai_dreamer/features/common/dialogs/loading_overlay.dart';
import 'package:ai_dreamer/features/common/dialogs/primary_alert_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Future<T> callWithIndicator<T>(Future<T> Function() function) async {
  LoadingOverlay.shared.show();

  try {
    final result = await function();
    LoadingOverlay.shared.hide();
    return result;
  } catch (e) {
    LoadingOverlay.shared.hide();
    rethrow;
  }
}

Future<T> callWithIndicatorAndPopupError<T>(
    Future<T> Function() function) async {
  LoadingOverlay.shared.show();

  try {
    final result = await function();
    LoadingOverlay.shared.hide();
    return result;
  } catch (e) {
    String message = '';
    if (e is Exception) {
      message = (e).text;
    } else {
      message = e.toString();
    }

    LoadingOverlay.shared.hide();
    PrimaryAlertDialog(
      confirmButtonTitle: "OK",
      title: "Error",
      description: message,
    ).show();
    rethrow;
  }
}

extension ExceptionExt on Exception {
  String get text {
    if (this is HttpException) {
      return (this as HttpException).message;
    } else if (this is DioException) {
      if (kDebugMode) {
        return (this as DioException).message ?? 'Something went wrong';
      } else {
        return 'Something went wrong';
      }
    } else {
      return toString();
    }
  }
}

Future<T> handleRequest<T>(
  Future<Response<dynamic>> Function() request,
  T? Function(dynamic data)? parser,
) async {
  final response = await request();

  if (response.statusCode != null && response.statusCode! ~/ 100 == 2) {
    final result = BaseResponse<T>.fromMap(response.data, parser);
    if (result.succeeded == true) {
      return result.data as T;
    } else {
      throw Exception(result.messages?.firstOrNull ?? '');
    }
  } else {
    throw Exception('Something went wrong');
  }
}

Future<T> handleRequestWithoutBase<T>(
  Future<Response<dynamic>> Function() request,
  T? Function(dynamic data)? parser,
) async {
  final response = await request();

  if (response.statusCode != null && response.statusCode! ~/ 100 == 2) {
    final result = parser?.call(response.data);
    if (result != null) {
      return result;
    } else {
      throw Exception('Wrong data format');
    }
  } else {
    throw Exception('Something went wrong');
  }
}

class BaseResponse<T> {
  final T? data;
  final List<String>? messages;
  final bool? succeeded;

  BaseResponse({
    this.data,
    this.messages,
    this.succeeded,
  });

  Map<String, dynamic> toMap() {
    return {
      'messages': messages,
      'data': data,
      'succeeded': succeeded,
    };
  }

  factory BaseResponse.fromMap(
    Map<String, dynamic> map,
    T? Function(dynamic data)? parser,
  ) {
    return BaseResponse(
      data: parser?.call(map['data']),
      succeeded: map['succeeded'],
      messages: List<String>.from(map['messages']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BaseResponse.fromJson(
          String source, T? Function(dynamic data) parser) =>
      BaseResponse.fromMap(json.decode(source), parser);
}

Future<T> handleAIRequest<T>(
  Future<Response<dynamic>> Function() request,
  T? Function(dynamic data)? parser,
) async {
  final response = await request();

  if (response.statusCode != null && response.statusCode! ~/ 100 == 2) {
    final result = BaseAIResponse<T>.fromMap(response.data, parser);
    if (result.message == null) {
      return result.data as T;
    } else {
      throw Exception(result.message ?? '');
    }
  } else {
    throw Exception('Something went wrong');
  }
}

class BaseAIResponse<T> {
  final T? data;
  final String? message;

  BaseAIResponse({
    this.data,
    this.message,
  });

  factory BaseAIResponse.fromMap(
    Map<String, dynamic> map,
    T? Function(dynamic data)? parser,
  ) {
    return BaseAIResponse(
      data: parser?.call(map['data']),
      message: map['messages'],
    );
  }

  factory BaseAIResponse.fromJson(
          String source, T? Function(dynamic data) parser) =>
      BaseAIResponse.fromMap(json.decode(source), parser);
}
