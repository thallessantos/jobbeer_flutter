import 'dart:convert';

import 'package:jobbeer_flutter/app/shared/models/job_model.dart';

JobsListModel jobsListModelFromJson(String str) => JobsListModel.fromJson(json.decode(str));

String jobsListModelToJson(JobsListModel data) => json.encode(data.toJson());

JobModel jobModelFromJson(String str) => JobModel.fromJson(json.decode(str));

String jobModelToJson(JobModel data) => json.encode(data.toJson());

class JobsListModel {
  List<JobModel> jobs;
  Pagination pagination;

  JobsListModel({
    this.jobs,
    this.pagination,
  });

  factory JobsListModel.fromJson(Map<String, dynamic> json) => JobsListModel(
    jobs: json["jobs"] == null ? null : List<JobModel>.from(json["jobs"].map((x) => JobModel.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "jobs": jobs == null ? null : List<dynamic>.from(jobs.map((x) => x.toJson())),
    "pagination": pagination == null ? null : pagination.toJson(),
  };
}

class Pagination {
  String cursor;

  Pagination({
    this.cursor,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    cursor: json["cursor"] == null ? null : json["cursor"],
  );

  Map<String, dynamic> toJson() => {
    "cursor": cursor == null ? null : cursor,
  };
}