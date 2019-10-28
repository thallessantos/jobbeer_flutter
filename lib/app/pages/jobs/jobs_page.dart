import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final bloc = JobsModule.to.getBloc<JobsBloc>();
  bool _isBuildDoneOnce = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      //Clear the cursor value
      prefs.setString(Configuration.CURSOR_SHARED_PREF, "");
      bloc.getJobs();
    });
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
                List<JobModel> jobs = snapshot.data.jobs;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    if (index < jobs.length) {
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
                    else if (index > 1 && !snapshot.data.isEnd) {
                      bloc.getJobs();
                      return Container(
                        height: ScreenUtil.getInstance().setHeight(40),
                        width: ScreenUtil.getInstance().setWidth(40),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                        ),
                      );
                    } else if(snapshot.data.isEnd) {
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

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
