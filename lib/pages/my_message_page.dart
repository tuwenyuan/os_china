import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oschina/constants/constants.dart';
import 'package:oschina/utils/data_utils.dart';
import 'package:oschina/utils/net_utils.dart';

class MyMessagePage extends StatefulWidget {
  @override
  _MyMessagePageState createState() => _MyMessagePageState();
}

class _MyMessagePageState extends State<MyMessagePage> {
  List<String> _tabTitles = ['@我', '评论', '私信'];
  int curPage = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
          length: _tabTitles.length,
          child: Scaffold(
            appBar: AppBar(
                elevation: 0.0,
                title: Text(
                  '消息中心',
                  style: TextStyle(color: Color(AppColors.APPBAR)),
                ),
                iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
                bottom: PreferredSize(
                  child: Material(
                    color: Colors.blue,
                    child: TabBar(
                        indicatorColor: Colors.red,
                        labelColor: Colors.red,
                        unselectedLabelColor: Colors.yellow,
                        tabs: _tabTitles
                            .map((title) => Tab(
                                  text: title,
                                  /*child: Text(
                                    title,
                                    style: TextStyle(
                                        color: Color(AppColors.APPBAR)),
                                  ),*/
                                ))
                            .toList()),
                  ),
                  preferredSize: Size.fromHeight(48),
                )),
            body: TabBarView(children: [
              Center(
                child: Text('暂无内容'),
              ),
              Center(
                child: Text('暂无内容'),
              ),
              _buildMessageList(),
            ]),
          )),
    );
  }

  List _messageList;

  Widget _buildMessageList() {
    if (_messageList == null) {
      _getMessageList();
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[CupertinoActivityIndicator(), Text('努力加载中...')],
        ),
      );
    }

    return RefreshIndicator(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Image.network(_messageList[index]['portrait']),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                _messageList[index]['sendername'],
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _messageList[index]['pubDate'],
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xffaaaaaa),
                                ),
                              )
                            ],
                          ),
                          Text(
                            _messageList[index]['content'],
                            style: TextStyle(fontSize: 12.0),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.red,
              );
            },
            itemCount: _messageList.length),
        onRefresh: _pullToRefresh);
  }

  int _curPage = 1;

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    _getMessageList();
    return null;
  }

  _getMessageList() {
    DataUtils.getAccessToken().then((token) {
      var params = Map<String, dynamic>();
      params['page'] = _curPage;
      params['pageSize'] = 10;
      params['access_token'] = token;
      params['dataType'] = 'json';
      NetUtils.get(AppUrls.MESSAGE_LIST, params).then((data) {
        print(data);
        if (data != null && data.isNotEmpty) {
          var map = json.decode(data);
          setState(() {
            _messageList = map['messageList'];
          });
        }
      });
    });
  }
}
