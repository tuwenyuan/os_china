import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oschina/constants/constants.dart';
import 'package:oschina/models/user_info.dart';
import 'package:oschina/utils/data_utils.dart';
import 'package:oschina/utils/net_utils.dart';

class ProfileDetailPage extends StatefulWidget {
  @override
  _ProfileDetailPageState createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  UserInfo _userInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDetailInfo();
  }

  _getDetailInfo(){

    DataUtils.getAccessToken().then((token){
      var params = new Map<String,dynamic>();
      params['access_token'] = token;
      params['dataType'] = 'json';
      NetUtils.get(AppUrls.MY_INFORMATION, params).then((data){
        if (data != null && data.isNotEmpty) {
          print(data);
          Map<String, dynamic> map = json.decode(data);
          UserInfo userInfo = UserInfo();
          userInfo.uid = map['uid'];
          userInfo.name = map['name'];
          userInfo.gender = map['gender'];
          userInfo.province = map['province'];
          userInfo.city = map['city'];
          userInfo.platforms = map['platforms'];
          userInfo.expertise = map['expertise'];
          userInfo.joinTime = map['joinTime'];
          userInfo.lastLoginTime = map['lastLoginTime'];
          userInfo.portrait = map['portrait'];
          userInfo.fansCount = map['fansCount'];
          userInfo.favoriteCount = map['favoriteCount'];
          userInfo.followersCount = map['followersCount'];
          userInfo.notice = map['notice'];
          setState(() {
            _userInfo = userInfo;
          });
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的资料',style: TextStyle(color: Color(AppColors.APPBAR)),),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      body: _buildSingleChildScrollView(),
    );
  }
//child: CupertinoActivityIndicator(),
  Widget _buildSingleChildScrollView() {
    return _userInfo == null ?
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CupertinoActivityIndicator(),
          Text('努力加载中...')
        ],
      ) ,
    ):
    SingleChildScrollView(
      child: Column(
        children: <Widget>[
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(left: 20.0),
              padding: const EdgeInsets.only(top: 10.0,bottom: 10.0 ,right: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('头像',style: TextStyle(fontSize: 20.0),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            image: DecorationImage(image: NetworkImage(_userInfo.portrait),fit: BoxFit.cover,)
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 0.5,
            color: Colors.red,
          ),
          InkWell(
            onTap: (){
              //todo
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0),
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                right: 20.0
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('昵称',style: TextStyle(fontSize: 20.0),),
                  Text(_userInfo.name,style: TextStyle(fontSize: 20.0,color: Color(AppColors.APP_THEME)),)
                ],
              ),
            ),
          ),
          Divider(
            height: 0.5,
            color: Colors.red,
          ),
          InkWell(
            onTap: (){
              //todo
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0),
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                right: 20.0
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('所在地区',style: TextStyle(fontSize: 20.0),),
                  Text(_userInfo.province+_userInfo.city,style: TextStyle(fontSize: 20.0),)
                ],
              ),
            ),
          ),
          Divider(
            height: 0.5,
            color: Colors.red,
          ),
          InkWell(
            onTap: (){
              //todo
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0),
              padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  right: 20.0
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('加入时间',style: TextStyle(fontSize: 20.0),),
                  Text(_userInfo.joinTime,style: TextStyle(fontSize: 20.0),)
                ],
              ),
            ),
          ),
          Divider(
            height: 0.5,
            color: Colors.red,
          ),
          InkWell(
            onTap: (){
              //todo
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0),
              padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  right: 20.0
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('最后登录时间',style: TextStyle(fontSize: 20.0),),
                  Text(_userInfo.lastLoginTime,style: TextStyle(fontSize: 20.0),)
                ],
              ),
            ),
          ),
          Divider(
            height: 0.5,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
