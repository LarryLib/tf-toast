import 'package:flutter/material.dart';
import 'package:tf_toast_example/TestToastPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: Center(
        child: FlatButton(
          child: Text('TestToastPage'),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => TestToastPage()));
          },
        ),
      ),
    );
  }
}
