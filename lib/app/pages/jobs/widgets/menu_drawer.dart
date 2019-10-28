import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jobbeer_flutter/app/pages/jobs/widgets/custom_about_dialog.dart';
import 'package:jobbeer_flutter/app/shared/configuration.dart';

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
            title: Text('Avaliar o Jobeer'),
            onTap: () {},
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
            onTap: () {},
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
