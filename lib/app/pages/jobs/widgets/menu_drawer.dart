import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jobbeer_flutter/app/pages/jobs/widgets/custom_about_dialog.dart';
import 'package:jobbeer_flutter/app/shared/configuration.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuDrawer extends StatelessWidget {
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
              showDialog(context: context, builder: (_) => CustomAboutDialog());
            },
          ),
          ListTile(
            leading: Icon(Icons.tag_faces),
            title: Text('Buy us a beer'),
            onTap: () {
              launch(Configuration.DONATION_PAYPAL_LINK);
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
