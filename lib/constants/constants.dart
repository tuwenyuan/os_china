abstract class AppColors{
  static const APP_THEME = 0xff63ca6c;
  static const APPBAR = 0xffffffff;
}

abstract class AppInfos{
  static const String CLIENTID = 'KZYLfrftwhqAHMi0ofEZ';
  static const String CLIENT_SECRET = 'hCYBpyiVOJZzRMMZLk3NTpgTH4aInH7O';
  static const String REDIRECT_URI = 'https://www.baidu.com';
}

abstract class AppUrls{
  static const String HOST = "https://www.oschina.net";
  static const String OAUTH2_AUTHORIZE = '$HOST/action/oauth2/authorize';
  static const String OAUTH2_TOKEN = '$HOST/action/openapi/token';
  static const String USER = '$HOST/action/openapi/user';
  static const String MY_INFORMATION = '$HOST/action/openapi/my_information';
  static const String MESSAGE_LIST = HOST + '/action/openapi/message_list';
  static const String NEWS_LIST = HOST + '/action/openapi/news_list';
}