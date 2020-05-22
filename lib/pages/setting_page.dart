import 'package:flutter/material.dart';
import 'package:oschina/common/event_bus.dart';
import 'package:oschina/utils/data_utils.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Center(
        child: FlatButton(onPressed: (){
          DataUtils.clearLoginInfo().then((_){
            eventBus.fire(LogoutEvent());
            Navigator.of(context).pop();
          });
        }, child: Text('退出登录',style: TextStyle(fontSize: 25.0),)),
      ),
    );
  }
}
