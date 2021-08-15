import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greeting_editor/greeting_editor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _key = new GlobalKey<ScaffoldState>();
  final name = "testing";
  final url = "https://sographql.enfyx.com/static/item/Ph5j1uu0oj.jpg";
  final urlLogo = "https://firebasestorage.googleapis.com/v0/b/rota-app-767c2.appspot.com/o/logo%20test.png?alt=media&token=4109106b-edeb-4607-95a8-fd62b3f96178";
  Uint8List logoImage;
  bool loading = true;

  @override
  void initState() {
    getLogo();
    super.initState();
  }

  Future getLogo() async {
    final urls = (await NetworkAssetBundle(Uri.parse(urlLogo)).load(urlLogo))
      .buffer
      .asUint8List();
    setState(() {
      logoImage = urls;
      loading = false;
    });
    print(urls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Example"),
      ),
      body: Builder(builder: (context) {
        if (loading)  return Center(child: CircularProgressIndicator());
        return TemplateEditor(
          template: Template(name, url, null, logoImage),
          onSave: (val, v) {
            print(val.map((e) => Item.toMap(e)).toList());
            print(v);
          },
        );
      }),
    );
  }
}
