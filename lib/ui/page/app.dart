import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0, // 最初に表示するタブ
      length: 3, // タブの数
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ホーム'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: '野球'),
              Tab(text: 'サッカー'),
              Tab(text: 'テニス'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text('野球', style: TextStyle(fontSize: 32.0)),
            ),
            Center(
              child: Text('サッカー', style: TextStyle(fontSize: 32.0)),
            ),
            Center(
              child: Text('テニス', style: TextStyle(fontSize: 32.0)),
            ),
          ],
        ),
      ),
    );
  }
}
