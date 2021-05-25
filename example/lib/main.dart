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
  final name = "";
  final url = "https://firebasestorage.googleapis.com/v0/b/rota-app-767c2.appspot.com/o/template1.png?alt=media&token=e8825f7c-53a8-4473-8460-1ccebbcc224c";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Example"),
      ),
      body: TemplateEditor(
        template: Template(name, url, null
          // [
          //   Item.fromMap({
          //     "text": "Congratulations",
          //     "itemType": "ucapan",
          //     "maxLines": 1,
          //     "format": [false, false],
          //     "offset": [0.16, 0.12434579439252336],
          //     "size": [0.7, 0.2],
          //     "color": [255, 255, 255],
          //     "outlineColor": [0, 0, 0],
          //     "logoUrl": null,
          //     "font": "Kaushan Script",
          //     "mode": 0
          //   }),
          //   Item.fromMap({
          //     "text": "For your first project",
          //     "itemType": "untuk",
          //     "maxLines": 2,
          //     "format": [false, false],
          //     "offset": [0.15844235571745402, 0.3423675893623139],
          //     "size": [0.7, 0.2],
          //     "color": [255, 255, 255],
          //     "outlineColor": [0, 0, 0],
          //     "logoUrl": null,
          //     "font": "Oswald",
          //     "mode": 0
          //   }),
          //   Item.fromMap({
          //     "text": "Rizky Andhika Putra",
          //     "itemType": "dari",
          //     "maxLines": 2,
          //     "format": [false, false],
          //     "offset": [0.16, 0.6550778697361457],
          //     "size": [0.7, 0.2],
          //     "color": [255, 255, 255],
          //     "outlineColor": [0, 0, 0],
          //     "logoUrl": "https://firebasestorage.googleapis.com/v0/b/rota-app-767c2.appspot.com/o/logo%20test.png?alt=media&token=4109106b-edeb-4607-95a8-fd62b3f96178",
          //     "font": "Oswald",
          //     "mode": 0
          //   })  
          // ]
        ),
        onSave: (val) => print(val.map((e) => Item.toMap(e)).toList()),
      ),
    );
  }
}
