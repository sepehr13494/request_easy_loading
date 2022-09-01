import 'dart:async';

import 'package:flutter/material.dart';
import 'package:request_easy_loading/request_easy_loading.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  RequestEasyLoading().setNavigatorKey(navigatorKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Timer? timer;
  int sent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Easy Loading"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: (){
                RequestEasyLoading().showEasyLoading();
                Future.delayed(Duration(seconds: 2),(){
                  RequestEasyLoading().cancelEasyLoading();
                });
              },
              child: Text("Show Loading"),
            ),
            ElevatedButton(
              onPressed: (){
                Timer.periodic(Duration(seconds: 10), (timer) {
                  RequestEasyLoading().showProgressDialog(sent, 100);
                  if(sent == 100){
                    timer.cancel();
                    sent = 0;
                  }else{
                    sent +=20;
                  }
                });
              },
              child: Text("Show Progress Loading"),
            ),
          ].map((e) => Padding(padding: EdgeInsets.symmetric(vertical: 16),child: e,)).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if(timer != null){
      timer!.cancel();
    }
    super.dispose();
  }
}

