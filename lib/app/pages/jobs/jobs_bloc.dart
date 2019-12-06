import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:jobbeer_flutter/app/pages/jobs/jobs_repository.dart';
import 'package:jobbeer_flutter/app/shared/models/job_model.dart';
import 'package:jobbeer_flutter/app/shared/models/jobs_list_model.dart';

class JobsBlocData {
  List<JobModel> jobs;
  JobModel job;
  bool isEnd;
  bool loading;

  JobsBlocData({this.jobs, this.job, this.isEnd = false, this.loading});

  factory JobsBlocData.loading() => JobsBlocData(loading: true);
}

class JobsBloc extends BlocBase {
  final JobsRepository _jobsRepository;

  JobsBloc(this._jobsRepository);

  List<JobModel> _jobs = [];
  final StreamController<JobsBlocData> _jobsController = StreamController<JobsBlocData>();
  Stream get outData => _jobsController.stream;

  void getJobs() async {
    if (_jobs.length == 0)
      _jobsController.sink.add(JobsBlocData.loading());

    JobsListModel response = await _jobsRepository.getJobsList();
    if (response.jobs.length > 0)
      _jobs += response.jobs;

    _jobsController.sink.add(JobsBlocData(jobs: _jobs, isEnd: response.pagination.cursor == ""));
  }

  void getJob(String jobId) async {
    _jobsController.sink.add(JobsBlocData.loading());
    _jobs = [];

    JobModel response = await _jobsRepository.getJob(jobId);

    _jobsController.sink.add(JobsBlocData(job: response));
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _jobsController.close();
    super.dispose();
  }
}
