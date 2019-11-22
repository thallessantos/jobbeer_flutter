import 'dart:io';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:jobbeer_flutter/app/app_module.dart';
import 'package:jobbeer_flutter/app/pages/jobs/widgets/custom_about_dialog.dart';
import 'package:jobbeer_flutter/app/shared/configuration.dart';

class MenuDrawer extends StatelessWidget {
  final analytics = AppModule.to.getDependency<FirebaseAnalytics>();
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(),
          ListTile(
            leading: Icon(Icons.star_border),
            title: Text('Avaliar o ${Configuration.APP_NAME}'),
            onTap: () {
              analytics.logEvent(name: Configuration.EVENT_RATING_APP);
              if (Platform.isAndroid) {
                launch("market://details?id=${Configuration.APP_PACKAGE_NAME}");
              } else if (Platform.isIOS) {
                launch("https://itunes.apple.com/app/id${Configuration.APP_IOS_ID}?action=write-review");
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Sobre o app'),
            onTap: () {
              analytics.logEvent(name: Configuration.EVENT_SHOW_ABOUT_DIALOG);
              showDialog(context: context, builder: (_) => CustomAboutDialog());
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Compartilhar'),
            onTap: () {
              analytics.logEvent(name: Configuration.EVENT_SHARING_APP);
              String storeLink;
              if (Platform.isAndroid)
                storeLink = "https://play.google.com/store/apps/details?id=${Configuration.APP_PACKAGE_NAME}";
              else if (Platform.isIOS)
                storeLink = "https://itunes.apple.com/app/id${Configuration.APP_IOS_ID}?action=write-review";

              Share.text(
                "Jobbeer - Vagas para Programadores",
                "Jobbeer - As melhores vagas para programadores reúnidas em um único app! 💼🍺\n"
                    + storeLink,
                "text/plain",
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.amber,
              alignment: Alignment.centerRight,
              child: TyperAnimatedTextKit(
                text: ["Find you a\b\nJob"],
                alignment: Alignment.topRight,
                isRepeatingAnimation: false,
                textAlign: TextAlign.right,
                textStyle: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(30),
                  fontFamily: Configuration.APP_FONT_FAMILY,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black87,
              alignment: Alignment.centerLeft,
              child: TyperAnimatedTextKit(
                text: ["\bBuy us a\b\b\nbeer"],
                isRepeatingAnimation: false,
                alignment: Alignment.topLeft,
                textAlign: TextAlign.left,
                textStyle: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(30),
                  fontFamily: Configuration.APP_FONT_FAMILY,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
