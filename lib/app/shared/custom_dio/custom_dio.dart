import 'package:dio/dio.dart';

import 'package:jobbeer_flutter/app/shared/configuration.dart';
import 'package:jobbeer_flutter/app/shared/custom_dio/custom_interceptors.dart';

class CustomDio {
  final Dio instance;

  CustomDio(this.instance) {
    instance.options.baseUrl = Configuration.DIO_BASE_URL;
    instance.interceptors.add(CustomInterceptors());
    instance.options.connectTimeout = Configuration.DIO_CONNECTION_TIMEOUT;

    if(instance.options.contentType == null)
      instance.options.contentType = Headers.jsonContentType;

    if(instance.options.responseType == ResponseType.json)
      instance.options.responseType = ResponseType.plain;
  }
}