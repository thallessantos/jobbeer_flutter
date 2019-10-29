import 'package:flutter/material.dart';

import 'package:jobbeer_flutter/app/pages/jobs/jobs_module.dart';
import 'package:jobbeer_flutter/app/shared/configuration.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Configuration.APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JobsModule(),
      debugShowCheckedModeBanner: false,
    );
  }
}
