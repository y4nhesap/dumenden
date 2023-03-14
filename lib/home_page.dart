import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ana Sayfa"),
          bottom: TabBar(
              onTap: (tabIndex) {
                setState(() {
                  _tabController.index = tabIndex;
                });
              },
              indicatorColor: Colors.transparent,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              padding: const EdgeInsets.all(4),
              controller: _tabController,
              tabs: const [
                Icon(
                  Icons.home,
                  size: 32,
                ),
                Icon(
                  Icons.leaderboard,
                  size: 32,
                ),
                Icon(
                  Icons.person,
                  size: 32,
                ),
              ]),
        ),
        body: TabBarView(controller: _tabController, children: [
          Center(
            child: Text(
              "Ana Sayfam",
              style: _style,
            ),
          ),
          Center(
            child: Text(
              "Eğitim sayfası",
              style: _style,
            ),
          ),
          Center(
            child: Text(
              "Profil Sayfam",
              style: _style,
            ),
          ),
        ]),
      ),
    );
  }

  final TextStyle _style = TextStyle(
      color: Colors.grey.shade900, fontWeight: FontWeight.w600, fontSize: 20);
}
