import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:jobbeer_flutter/app/app_module.dart';
import 'package:jobbeer_flutter/app/shared/configuration.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize(Configuration.getAdmobAppId());
  runApp(AppModule());
}
