import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:jobbeer_flutter/app/app_module.dart';
import 'package:jobbeer_flutter/app/pages/jobs/jobs_module.dart';
import 'package:jobbeer_flutter/app/shared/configuration.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final analytics = AppModule.to.getDependency<FirebaseAnalytics>();

  @override
  void initState() {
    super.initState();
    analytics.logAppOpen();
  }

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
