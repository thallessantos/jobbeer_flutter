import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:jobbeer_flutter/app/app_module.dart';
import 'package:jobbeer_flutter/app/shared/configuration.dart';
import 'package:jobbeer_flutter/app/shared/models/job_model.dart';

class JobTile extends StatelessWidget {
  final analytics = AppModule.to.getDependency<FirebaseAnalytics>();
  final JobModel job;

  JobTile(this.job);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildItemTile(
              icon: Icon(Icons.business_center, color: Colors.green, size: ScreenUtil.getInstance().setWidth(24)),
              text: Text(
                job.title,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.getInstance().setSp(20),
                ),
              ),
            ),
            _buildItemTile(
              icon: Icon(Icons.info_outline, color: Colors.amber, size: ScreenUtil.getInstance().setWidth(24)),
              text: Text(
                job.snippet,
                maxLines: 5,
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(16),
                ),
              ),
            ),
            _buildItemTile(
              icon: Icon(Icons.access_time, color: Colors.blueAccent, size: ScreenUtil.getInstance().setWidth(24)),
              text: Text(
                DateFormat('dd/MM/yyyy').format(job.createdAt),
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: ScreenUtil.getInstance().setSp(14),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            _buildItemTile(
              icon: Icon(Icons.link, color: Colors.grey),
              text: InkWell(
                onTap: () async {
                  await analytics.logEvent(
                    name: Configuration.EVENT_OPEN_JOB_LINK,
                    parameters: {
                      "title": job.title,
                      "site": job.url.split("/")[2], //Get the site address in the URL
                    },
                  );
                  await launch(job.url);
                },
                child: Text(
                  job.url,
                  maxLines: 2,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.lightBlueAccent,
                    fontSize: ScreenUtil.getInstance().setSp(14),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              paddingBottom: 10,
            ),
            InkWell(
              onTap: () => Share.text("", job.shareLink, "text/plain"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.share,
                    color: Colors.black87,
                    size: ScreenUtil.getInstance().setSp(15),
                  ),
                  SizedBox(width: ScreenUtil.getInstance().setWidth(10)),
                  Text(
                    "Compartilhar",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: ScreenUtil.getInstance().setSp(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTile({Icon icon, Widget text, double paddingBottom = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10, bottom: paddingBottom),
      child: Row(
        children: <Widget>[
          icon,
          SizedBox(width: ScreenUtil.getInstance().setWidth(20)),
          Expanded(child: text),
        ],
      ),
    );
  }
}
