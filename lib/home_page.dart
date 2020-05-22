import 'package:flutter/material.dart';
import 'package:oschina/constants/constants.dart';
import 'package:oschina/pages/news_list_page.dart';
import 'package:oschina/pages/profile_page.dart';
import 'package:oschina/widgets/my_drawer.dart';
import 'package:oschina/widgets/navigation_cion_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final _appBarTitle = ['咨询', '动弹', '发现', '我的'];
  List<Widget> _pages;
  List<NavigationIconView> _navigationIconViews;
  var _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _navigationIconViews = [
      NavigationIconView(
        title: _appBarTitle[0],
        iconPath:'assets/images/ic_nav_news_normal.png',
        activeIconPath: 'assets/images/ic_nav_news_actived.png'
      ),
      NavigationIconView(
        title: _appBarTitle[1],
        iconPath:'assets/images/ic_nav_tweet_normal.png',
        activeIconPath: 'assets/images/ic_nav_tweet_actived.png'
      ),
      NavigationIconView(
        title: _appBarTitle[2],
        iconPath:'assets/images/ic_nav_discover_normal.png',
        activeIconPath: 'assets/images/ic_nav_discover_actived.png'
      ),
      NavigationIconView(
        title: _appBarTitle[3],
        iconPath:'assets/images/ic_nav_my_normal.png',
        activeIconPath: 'assets/images/ic_nav_my_pressed.png'
      ),
    ];
    _pages = [
      NewListPage(),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.blue,
      ),
      ProfilePage(),
    ];
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0, //去除阴影
        title: Text(
          _appBarTitle[_currentIndex],
          style: TextStyle(color: Color(AppColors.APPBAR)),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        itemCount: _pages.length,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _navigationIconViews.map((view) => view.item).toList(),
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(index, duration: Duration(microseconds: 100), curve: Curves.ease);
        },
      ),
      drawer: MyDrawer(
          headImgPath:'assets/images/cover_img.jpg',
          menuTitles:['发布动弹', '动弹小黑屋', '关于', '设置'],
          menuIcons:[Icons.send,Icons.home,Icons.error,Icons.settings]
      ),
    );
  }
}
