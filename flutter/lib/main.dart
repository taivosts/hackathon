import 'package:ai_dreamer/features/app/app.dart';
import 'package:ai_dreamer/features/app/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
  Bloc.observer = AppBlocObserver();
}
