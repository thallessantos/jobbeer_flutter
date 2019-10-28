import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Text(
                      "Sobre o app",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil.getInstance().setSp(30),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                    Text(
                      "O Jobbeer foi criado para que desenvolvedores de software possam encontrar mais facilmente as melhores vagas de emprego em um único lugar.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil.getInstance().setSp(18),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                    Text(
                      "Desenvolvido por:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil.getInstance().setSp(22),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(20)),
                    Text(
                      "Rafael Bertelli",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil.getInstance().setSp(18),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        launch("https://github.com/zfael");
                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "lib/assets/images/github_logo.png",
                            width: ScreenUtil.getInstance().setWidth(24),
                            height: ScreenUtil.getInstance().setHeight(24),
                          ),
                          SizedBox(width: ScreenUtil.getInstance().setWidth(10)),
                          Text(
                            "https://github.com/zfael",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              decoration: TextDecoration.underline,
                              fontSize: ScreenUtil.getInstance().setSp(18),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        launch("mailto://rafael.p.bertelli@gmail.com");
                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "lib/assets/images/gmail_logo.png",
                            width: ScreenUtil.getInstance().setWidth(24),
                            height: ScreenUtil.getInstance().setHeight(24),
                          ),
                          SizedBox(width: ScreenUtil.getInstance().setWidth(10)),
                          Text(
                            "rafael.p.bertelli@gmail.com",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              decoration: TextDecoration.underline,
                              fontSize: ScreenUtil.getInstance().setSp(18),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(20)),
                    Text(
                      "Thalles Santos",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil.getInstance().setSp(18),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        launch("https://github.com/thallessantos");
                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "lib/assets/images/github_logo.png",
                            width: ScreenUtil.getInstance().setWidth(24),
                            height: ScreenUtil.getInstance().setHeight(24),
                          ),
                          SizedBox(width: ScreenUtil.getInstance().setWidth(10)),
                          Text(
                            "https://github.com/thallessantos",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              decoration: TextDecoration.underline,
                              fontSize: ScreenUtil.getInstance().setSp(18),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        launch("mailto://thalles.rss@gmail.com");
                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "lib/assets/images/gmail_logo.png",
                            width: ScreenUtil.getInstance().setWidth(24),
                            height: ScreenUtil.getInstance().setHeight(24),
                          ),
                          SizedBox(width: ScreenUtil.getInstance().setWidth(10)),
                          Text(
                            "thalles.rss@gmail.com",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              decoration: TextDecoration.underline,
                              fontSize: ScreenUtil.getInstance().setSp(18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              OutlineButton(onPressed: () => Navigator.of(context).pop(), child: Text("Voltar")),
            ],
          ),
        ),
      ),
    );
  }
}
