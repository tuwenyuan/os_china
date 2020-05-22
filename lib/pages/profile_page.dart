import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oschina/common/event_bus.dart';
import 'package:oschina/constants/constants.dart';
import 'package:oschina/pages/login_web_page.dart';
import 'package:oschina/pages/my_message_page.dart';
import 'package:oschina/utils/data_utils.dart';
import 'package:oschina/utils/net_utils.dart';

import 'Profile_detail_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List menuTitles = ['我的消息', '阅读记录', '我的博客', '我的问答', '我的活动', '我的团队', '邀请好友'];
  List menuIcons = [
    Icons.message,
    Icons.print,
    Icons.error,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.person
  ];

  String userAvatar;
  String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //尝试显示用户信息
    _showUserInfo();
    eventBus.on<LoginEvent>().listen((event) {
      _getUserInfo();
    });
    eventBus.on<LogoutEvent>().listen((event) {
      _getUserInfo();
    });
  }

  _showUserInfo() {
    DataUtils.getUserInfo().then((user){
      if(mounted){
        setState(() {
          if(user == null){
            userAvatar = null;
            name = null;
          }else{
            userAvatar = user.avatar;
            name = user.name;
          }
        });
      }
    });
  }

  _getUserInfo() {
    DataUtils.getAccessToken().then((token) {
      if (token == null || token.length <= 0) {
        if (mounted) {
          //UI是否挂载
          setState(() {
            userAvatar = null;
            name = null;
          });
        }
        return;
      }
      var params = Map<String, dynamic>();
      params['access_token'] = token;
      params['dataType'] = 'json';
      NetUtils.get(AppUrls.USER, params).then((value) {
        var map = json.decode(value);
        if (mounted) {
          //UI是否挂载
          setState(() {
            userAvatar = map['avatar'];
            name = map['name'];
          });
        }
        DataUtils.saveUserInfo(map);
      });
    });
  }

  _login() async {
    /*final result = Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()));
    result.then((value) => {
          if (value != null && value == 'refresh') {print('登录成功')}
        });*/
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()))
        .then((value) => {
              if (value == 'refresh') {eventBus.fire(LoginEvent())}
            });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader();
          }
          index -= 1;
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              DataUtils.isLogin().then((isLogin){
                if(isLogin){
                  switch(index){
                    case 0:
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyMessagePage()));
                      break;
                  }
                }else{
                  _login();
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 0.5,
            //color: Colors.red,
          );
        },
        itemCount: menuTitles.length + 1);
  }

  Widget _buildHeader() {
    return Container(
      height: 200.0,
      color: Color(AppColors.APP_THEME),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: userAvatar != null
                  ? Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xffffffff), width: 2.0),
                          image: DecorationImage(
                            image: NetworkImage(
                                userAvatar
                            ),
                          )),
                    )
                  : Image.asset(
                      'assets/images/ic_avatar_default.png',
                      width: 60.0,
                      height: 60.0,
                    ),
              onTap: () {
                DataUtils.isLogin().then((isLogin){
                  if(isLogin){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileDetailPage()));
                  }else{
                    _login();
                  }
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              name ??= '点击头像登录',
              style: TextStyle(color: Color(0xffffffff)),
            )
          ],
        ),
      ),
    );
  }
}
