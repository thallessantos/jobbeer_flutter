import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jobbeer_flutter/app/shared/configuration.dart';
import 'package:jobbeer_flutter/app/shared/models/jobs_list_model.dart';
import 'package:jobbeer_flutter/app/shared/custom_dio/custom_dio.dart';

class JobsRepository {
  final CustomDio _dio;

  JobsRepository(this._dio);
  
  Future<JobsListModel> getJobsList() async {
    try {
      //Get the actual cursor on shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String cursor = prefs.get(Configuration.CURSOR_SHARED_PREF);
      String cursorParam = "";
      if (cursor != null)
        cursorParam = "&cursor=$cursor";

      //Do the GET request /jobs?limit=123&cursor=abc
      var response = await _dio.instance.get("/jobs?limit=${Configuration.JOBS_LIST_LIMIT}$cursorParam");

      JobsListModel jobsListModel = jobsListModelFromJson(response.data);
      prefs.setString(Configuration.CURSOR_SHARED_PREF, jobsListModel.pagination.cursor);
      return jobsListModel;
    } on DioError catch (err) {
      throw (err.message);
    }
  }
}