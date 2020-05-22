import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:oschina/constants/constants.dart' show AppColors, AppInfos, AppUrls;
import 'package:oschina/utils/data_utils.dart';
import 'package:oschina/utils/net_utils.dart';

class LoginWebPage extends StatefulWidget {
  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  bool _isLoading = true;
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _flutterWebviewPlugin.onUrlChanged.listen((url){
      //https://www.baidu.com/?code=u8epSG&state=
      print(url);
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
      //登录成功 提取授权码code
      if(url!=null && url.length>0 && url.contains('code=')){
        String code = url.split('?')[1].split('=')[1];
        Map<String,dynamic> params = Map<String,dynamic>();
        params['client_id'] = AppInfos.CLIENTID;
        params['client_secret'] = AppInfos.CLIENT_SECRET;
        params['grant_type'] = 'authorization_code';
        params['code'] = code;
        params['callback'] = 'json';
        params['redirect_uri'] = AppInfos.REDIRECT_URI;
        NetUtils.get(AppUrls.OAUTH2_TOKEN, params)
        .then((data){
          print(data);
          if(data!=null){
            Map<String,dynamic> map = json.decode(data);
            if(map!=null && map.isNotEmpty){
              DataUtils.saveLoginInfo(map);
              //弹出当前路由，并返回refresh通知我们界面刷新数据
              Navigator.pop(context,'refresh');
            }
          }
        });
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    List<Widget> _appBarTitle = [
      Text('登录开源中国', style: TextStyle(color: Color(AppColors.APPBAR)),),
    ];
    if(_isLoading){
      _appBarTitle.add(SizedBox(width: 10.0,));
      _appBarTitle.add(CupertinoActivityIndicator());
    }
    return WebviewScaffold(
      url: '${AppUrls.OAUTH2_AUTHORIZE}?response_type=code&client_id=${AppInfos.CLIENTID}&redirect_uri=${AppInfos.REDIRECT_URI}',
      appBar: AppBar(
        title: Row(
          children: _appBarTitle,
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      withJavascript: true,
      withLocalStorage: true,
    );
  }
}
