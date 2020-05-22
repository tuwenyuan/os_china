import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oschina/common/event_bus.dart';
import 'package:oschina/constants/constants.dart';
import 'package:oschina/utils/data_utils.dart';
import 'package:oschina/utils/net_utils.dart';
import 'package:oschina/widgets/new_list_item.dart';

import 'login_web_page.dart';

class NewListPage extends StatefulWidget {
  @override
  _NewListPageState createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> with AutomaticKeepAliveClientMixin {
  var _isLogin = false;
  var _hasMore = true;
  int curPage = 1;
  List _newsList;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
    ..addListener((){
      ////判断是否滑到底
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent && _hasMore){
        curPage++;
        _getNewsList(true);
      }
    });
    super.initState();
    DataUtils.isLogin().then((isLogin) {
      if (mounted) {
        setState(() {
          _isLogin = isLogin;
        });
      }
    });

    eventBus.on<LoginEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        _isLogin = true;
      });
      //获取新闻列表
      _getNewsList(false);
    });
    eventBus.on<LogoutEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        _isLogin = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLogin) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('由于开源中国限制，必须登录后才能获取资讯！'),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(
                        MaterialPageRoute(builder: (context) => LoginWebPage()))
                    .then((value) => {
                          if (value == 'refresh') {eventBus.fire(LoginEvent())}
                        });
              },
              child: Text(
                '去登录',
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _pullToRefresh,
      child: _buildListView(),
    );
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    _hasMore = true;
    _getNewsList(false);
    return null;
  }

  _getNewsList(bool isLoadMore) {
    DataUtils.getAccessToken().then((token) {
      var params = new Map<String, dynamic>();
      params['access_token'] = token;
      params['catalog'] = 1;
      params['page'] = curPage;
      params['pageSize'] = 10;
      params['dataType'] = 'json';
      NetUtils.get(AppUrls.NEWS_LIST, params).then((data) {
        var list = json.decode(data)['newslist'];
        if (mounted) {
          setState(() {
            if(curPage == 5){
              _hasMore = false;
            }
            if (isLoadMore) {
              _newsList.addAll(list);
            } else {
              _newsList = list;
            }
          });
        }
      });
    });
  }

  _buildListView() {
    if (_newsList == null) {
      _getNewsList(false);
      return CupertinoActivityIndicator();
    }
    return ListView.builder(
        itemBuilder: (context, index) {
          if(index ==  _newsList.length){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          return NewListItem(newsList: _newsList[index]);
        },
      itemCount: _hasMore?_newsList.length+1:_newsList.length,
      controller: _scrollController,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
