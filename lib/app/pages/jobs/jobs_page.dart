import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobbeer_flutter/app/app_bloc.dart';
import 'package:jobbeer_flutter/app/app_module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:jobbeer_flutter/app/pages/jobs/widgets/menu_drawer.dart';
import 'package:jobbeer_flutter/app/pages/jobs/jobs_bloc.dart';
import 'package:jobbeer_flutter/app/pages/jobs/jobs_module.dart';
import 'package:jobbeer_flutter/app/pages/jobs/widgets/job_tile.dart';
import 'package:jobbeer_flutter/app/shared/configuration.dart';
import 'package:jobbeer_flutter/app/shared/models/job_model.dart';

class JobsPage extends StatefulWidget {
  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  final appBloc = AppModule.to.getBloc<AppBloc>();
  final bloc = JobsModule.to.getBloc<JobsBloc>();
  final analytics = AppModule.to.getDependency<FirebaseAnalytics>();

  bool _isBuildDoneOnce = false;

  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();

    analytics.setCurrentScreen(screenName: widget.runtimeType.toString());
  }

  void getAllJobs() {
    SharedPreferences.getInstance().then((prefs) {
      //Clear the cursor value
      prefs.setString(Configuration.CURSOR_SHARED_PREF, "");
      bloc.getJobs();
    });
  }

  void getJobByDeepLink(Uri deepLink) {
    String jobId;
    Map queryParams = deepLink.queryParameters;
    if (queryParams.containsKey(Configuration.JOB_QUERY_PARAM))
      jobId = queryParams[Configuration.JOB_QUERY_PARAM];

    if (jobId != null) {

      bloc.getJob(jobId);
    }
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    if (deepLink != null)
      getJobByDeepLink(deepLink);
    else
      getAllJobs();

    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLink) async {
        final Uri deepLink = dynamicLink?.link;
        if (deepLink != null)
          getJobByDeepLink(deepLink);
      },
      onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isBuildDoneOnce) {
      ScreenUtil.instance = ScreenUtil(
          width: Configuration.DESIGN_BASED_WIDTH,
          height: Configuration.DESIGN_BASED_HEIGHT,
          allowFontScaling: true)
        ..init(context);
      _isBuildDoneOnce = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
          "Jobbeer",
          style: TextStyle(
            color: Colors.amber,
            fontSize: ScreenUtil.getInstance().setSp(24),
            fontFamily: "Pacifico",
          ),
        ),
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.amber),
      ),
      drawer: MenuDrawer(),
      body: SafeArea(
        child: Container(
          color: Colors.black.withAlpha(0),
          child: StreamBuilder(
            stream: bloc.outData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.job != null)
                  return _buildLinkedJob(snapshot.data.job);
                else if (snapshot.data.jobs != null || snapshot.data.isEnd)
                  return _buildJobList(snapshot.data.jobs, snapshot.data.isEnd);
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Column _buildLinkedJob(JobModel job) {
    return Column(
      children: <Widget>[
        MaterialButton(
          color: Colors.amberAccent,
          child: Text(
            "Mostrar mais vagas",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () => this.getAllJobs(),
        ),
        JobTile(job),
        AdmobBanner(
          adUnitId: Configuration.getAdmobBannerId(),
          adSize: AdmobBannerSize.LARGE_BANNER,
        ),
      ],
    );
  }

  ListView _buildJobList(List<JobModel> jobs, bool isEnd) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < jobs.length) {

          //We want to show an ad after the second item
          if (index == 2) {
            return Column(
              children: <Widget>[
                AdmobBanner(
                  adUnitId: Configuration.getAdmobBannerId(),
                  adSize: AdmobBannerSize.LARGE_BANNER,
                ),
                JobTile(jobs[index]),
              ],
            );
          }

          if (index > 0 && index % 10 == 0) {
            return Column(
              children: <Widget>[
                AdmobBanner(
                  adUnitId: Configuration.getAdmobBannerId(),
                  adSize: AdmobBannerSize.LARGE_BANNER,
                ),
                JobTile(jobs[index]),
              ],
            );
          }
          return JobTile(jobs[index]);
        }
        else if (index > 1 && !isEnd) {
          bloc.getJobs();
          return Container(
            height: ScreenUtil.getInstance().setHeight(40),
            width: ScreenUtil.getInstance().setWidth(40),
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
            ),
          );
        } else if (isEnd) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Text(
              "FIM",
              style: TextStyle(
                color: Colors.grey[300],
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return Container();
      },
      itemCount: jobs.length + 1,
    );
  }
}
