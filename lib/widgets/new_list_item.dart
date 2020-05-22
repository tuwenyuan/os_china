import 'package:flutter/material.dart';

class NewListItem extends StatelessWidget {
  final Map<String,dynamic> newsList;
  NewListItem({this.newsList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO
      },
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xffff0000),
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Text('@${newsList['title']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    '@${newsList['author']} ${newsList['pubDate'].toString().split(' ')[0]}'),
                Row(
                  children: <Widget>[
                    Icon(Icons.message),
                    Text('${newsList['commentCount']}'),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
