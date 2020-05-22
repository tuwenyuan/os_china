import 'package:flutter/material.dart';

import 'home_page.dart';
import 'constants/constants.dart' show AppColors;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,//去除右上角debug标签
      title: '开源中国',
      theme: ThemeData(
        primaryColor: Color(AppColors.APP_THEME)
      ),
      home: HomePage()
    );
  }
}



