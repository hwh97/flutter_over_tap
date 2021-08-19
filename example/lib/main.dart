import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_over_tap/flutter_over_tap.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Widget text = const Text(
    '这是测试的文字，请勿删掉',
    maxLines: 1,
  );
  final StreamController _dispatcherStreamCtrl =
  StreamController<dynamic>.broadcast();

  Stream get dispatcherStream => _dispatcherStreamCtrl.stream;
  StreamSink get dispatcherSink => _dispatcherStreamCtrl.sink;

  @override
  Widget build(BuildContext context) {
    return OverTapDispatcher(
      sink: dispatcherSink,
      child: Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemBuilder: (BuildContext c, int index) {
            return Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[text, text],
                      ),
                      decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            getButton('A', index),
                            Expanded(
                              child: Container(
                                color: Colors.lightGreen,
                                child: text,
                              ),
                            ),
                            getButton('B', index),
                          ],
                        ),
                        text,
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[text, text],
                      ),
                      decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                    ),
                  ),
                ],
              ),
            );
          },
          itemExtent: 70,
        ),
      ),
    );
  }

  Widget getButton(String text, int index) {
    return OverTapListener(
      onTap: () {
        showToast("$text: $index", duration: Duration(milliseconds: 500));
      },
      stream: dispatcherStream,
      detectorSize: Size(56, 56),
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(color: Colors.red),
        child: Text(text),
      ),
    );
  }

  @override
  void dispose() {
    _dispatcherStreamCtrl.close();
    super.dispose();
  }
}
