import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:jobbeer_flutter/app/app_module.dart';
import 'package:jobbeer_flutter/app/pages/jobs/jobs_bloc.dart';
import 'package:jobbeer_flutter/app/pages/jobs/jobs_page.dart';
import 'package:jobbeer_flutter/app/pages/jobs/jobs_repository.dart';
import 'package:jobbeer_flutter/app/shared/custom_dio/custom_dio.dart';

class JobsModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => JobsBloc(JobsModule.to.getDependency<JobsRepository>())),
  ];

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => JobsRepository(AppModule.to.getDependency<CustomDio>()))
  ];

  @override
  Widget get view => JobsPage();

  static Inject get to => Inject<JobsModule>.of();
}
