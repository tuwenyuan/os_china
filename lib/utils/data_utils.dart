import 'package:oschina/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataUtils {
  static const String ACCESS_TOKEN = 'access_token';
  static const String REFRESH_TOKEN = 'refresh_token';
  static const String UID = 'uid';
  static const String TOKEN_TYPE = 'token_type';
  static const String EXPIRES_IN = 'expires_in';
  static const String IS_LOGIN = 'is_login';

  //用户信息字段
  static const String SP_USER_GENDER = 'gender';
  static const String SP_USER_NAME = 'name';
  static const String SP_USER_LOCATION = 'location';
  static const String SP_USER_ID = 'id';
  static const String SP_USER_AVATAR = 'avatar';
  static const String SP_USER_EMAIL = 'email';
  static const String SP_USER_URL = 'url';

  /*{
	"access_token": "c6d3d677-c7c0-40e2-8412-429f5ba91c97",
	"refresh_token": "25e64c5d-ae64-4626-bb21-475bd2c65d16",
	"uid": 4536483,
	"token_type": "bearer",
	"expires_in": 604799
}*/
  static Future<void> saveLoginInfo(Map<String, dynamic> map) async {
    if (map != null && map.isNotEmpty) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp
        ..setString(ACCESS_TOKEN, map[ACCESS_TOKEN])
        ..setString(REFRESH_TOKEN, map[REFRESH_TOKEN])
        ..setInt(UID, map[UID])
        ..setString(TOKEN_TYPE, map[TOKEN_TYPE])
        ..setInt(EXPIRES_IN, map[EXPIRES_IN])
        ..setBool(IS_LOGIN, true);
    }
  }

  static Future<void> clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp
      ..setString(ACCESS_TOKEN, '')
      ..setString(REFRESH_TOKEN, '')
      ..setInt(UID, -1)
      ..setString(TOKEN_TYPE, '')
      ..setString(EXPIRES_IN, '')
      ..setBool(IS_LOGIN, false);
  }

  //是否登录
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool(IS_LOGIN);
    return isLogin != null && isLogin;
  }

  //获取token
  static Future<String> getAccessToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(ACCESS_TOKEN);
  }

  static saveUserInfo(Map<String, dynamic> map) async {
    if (map != null && map.isNotEmpty) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String gender = map[SP_USER_GENDER];
      String name = map[SP_USER_NAME];
      String location = map[SP_USER_LOCATION];
      int id = map[SP_USER_ID];
      String avatar = map[SP_USER_AVATAR];
      String email = map[SP_USER_EMAIL];
      String url = map[SP_USER_URL];

      sp
        ..setString(SP_USER_GENDER, gender)
        ..setString(SP_USER_NAME, name)
        ..setString(SP_USER_LOCATION, location)
        ..setInt(SP_USER_ID, id)
        ..setString(SP_USER_AVATAR, avatar)
        ..setString(SP_USER_EMAIL, email)
        ..setString(SP_USER_URL, url);

      /*User user = new User(
          id: id,
          name: name,
          gender: gender,
          avatar: avatar,
          email: email,
          location: location,
          url: url);
      return user;*/
    }
    //return null;
  }

  static Future<User> getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(sp.getBool(IS_LOGIN)) {
      String gender = sp.getString(SP_USER_GENDER);
      String name = sp.getString(SP_USER_NAME);
      String location = sp.getString(SP_USER_LOCATION);
      int id = sp.getInt(SP_USER_ID);
      String avatar = sp.getString(SP_USER_AVATAR);
      String email = sp.getString(SP_USER_EMAIL);
      String url = sp.getString(SP_USER_URL);
      User user = new User(
          id: id,
          name: name,
          gender: gender,
          avatar: avatar,
          email: email,
          location: location,
          url: url);
      return user;
    }
    return null;
  }

}
