import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:jobbeer_flutter/app/app_widget.dart';
import 'package:jobbeer_flutter/app/app_bloc.dart';
import 'package:jobbeer_flutter/app/shared/custom_dio/custom_dio.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => AppBloc()),
  ];

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => Dio()),
    Dependency((i) => CustomDio(i.getDependency<Dio>())),
    Dependency((i) => FirebaseAnalytics()),
  ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
