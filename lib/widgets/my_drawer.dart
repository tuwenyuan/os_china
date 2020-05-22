import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oschina/pages/about_page.dart';
import 'package:oschina/pages/publish_tweet_page.dart';
import 'package:oschina/pages/setting_page.dart';
import 'package:oschina/pages/tweet_back_house_page.dart';

class MyDrawer extends StatelessWidget {
  final String headImgPath;
  final List menuTitles;
  final List menuIcons;

  MyDrawer(
      {Key key,
      @required this.headImgPath,
      @required this.menuTitles,
      @required this.menuIcons})
      : assert(headImgPath != null),
        assert(menuTitles != null),
        assert(menuIcons != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: ListView.separated(
          padding: const EdgeInsets.all(0.0), //解决状态栏问题
          itemBuilder: (context, index) {
            if (index == 0) {
              return Image.asset(
                headImgPath,
                fit: BoxFit.cover,
              );
            }
            index -= 1;
            return ListTile(
              leading: Icon(menuIcons[index]),
              title: Text(menuTitles[index],style: TextStyle(fontSize: 15.0,color: Colors.blue),),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                switch (index) {
                  case 0:
                    _navPush(context, PublishTweetPage());
                    break;
                  case 1:
                    _navPush(context, TweetBlackHousePage());
                    break;
                  case 2:
                    _navPush(context, AboutPage());
                    break;
                  case 3:
                    _navPush(context, SettingPage());
                    break;

                }
              },
            );
          },
          separatorBuilder: (context, index) {
            if (index == 0) {
              return Divider(
                height: 0.0,
              );
            } else {
              return Divider(
                height: 0.5,
                color: Colors.red,
              );
            }
          },
          itemCount: menuTitles.length + 1),
    );
  }

  _navPush(BuildContext context, Widget page) {
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
