import 'package:flutter/material.dart';
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

class Home extends StatelessWidget {
  final _key = new GlobalKey<ScaffoldState>();
  final name = "testing";
  // final url = "https://firebasestorage.googleapis.com/v0/b/rota-app-767c2.appspot.com/o/template1.png?alt=media&token=e8825f7c-53a8-4473-8460-1ccebbcc224c";
  final url = "https://sographql.enfyx.com/static/item/Ph5j1uu0oj.jpg";
  // final url = "https://sographql.enfyx.com/static/item/Ph5j1uu0oj.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Example"),
      ),
      body: TemplateEditor(
        template: Template(name, url, null),
        onSave: (val, v) {
          print(val.map((e) => Item.toMap(e)).toList());
          print(v);
        },
      ),
      // body: TemplateShow(
      //   template: Template(name, url, null),
      //   width: MediaQuery.of(context).size.width,
      //   height: MediaQuery.of(context).size.height,
      // ),
    );
  }
}
