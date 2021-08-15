import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:greeting_editor/Editor/EditorPanel.dart';
import 'package:greeting_editor/Editor/TemplatePreview.dart';
import 'package:greeting_editor/Models/Template.dart';
import 'package:greeting_editor/Models/item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:greeting_editor/Utils/WidgetToImage.dart';
import 'package:path_provider/path_provider.dart';

class TemplateEditor extends StatefulWidget {
  TemplateEditor({@required this.template, this.onSave});
  final Template template;
  final void Function(List<Item>, String imagePath) onSave;
  @override
  _TemplateEditorState createState() =>
      _TemplateEditorState(template, template.itemData);
}

class _TemplateEditorState extends State<TemplateEditor> {
  _TemplateEditorState(this.template, this.items);
  final repaintKey = GlobalKey();
  Template template;
  List<Item> items;
  final CarouselController carouselController = CarouselController();
  void _getTemplateData(List<Item> _items, {bool toGetData = false}) {
    // widget.onSave(items);
    // items.forEach((item) => print(Item.toMap(item)));
  }

  Future<void> _showPreview() async {
    final Uint8List imageData = await createImageFromWidget(TemplatePreview(
        size: MediaQuery.of(context).size,
        items: items,
        isLoading: true,
        templateUrl: template.templateUrl));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Image.memory(imageData);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final AppBar appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      actions: [
        IconButton(
          icon: Icon(Icons.save, color: Colors.black),
          onPressed: () {
            _getTemplateData(items, toGetData: true);
          },
        ),
        IconButton(
          icon: Icon(Icons.preview, color: Colors.black),
          onPressed: () {
            _showPreview();
          },
        )
      ],
    );
    final Size editorPanelSize = Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height -
            MediaQuery.of(context).size.width -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // appBar: appBar,
      body: Column(children: [
        RepaintBoundary(
          key: repaintKey,
          child: TemplatePreview(
            // getDetails: (List<Item> _items) {
            //   _getTemplateData(
            //     _items,
            //   );
            // },
            items: items,
            size: MediaQuery.of(context).size,
            getId: (int id) {
              if (id == null) return;
              carouselController.animateToPage(id);
            },
            templateUrl: widget.template.templateUrl,
          ),
        ),
        Divider(height: 0),
        Flexible(
          child: SizedBox(
            width: double.infinity,
            child: CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              // height: editorPanelSize.height,
              viewportFraction: 1,
              initialPage: 3,
              scrollPhysics: NeverScrollableScrollPhysics(),
              aspectRatio: 1
            ),
            items: [
              for (var i = 0; i < items.length + 1; i++)
                i != 3
                    ? EditorPanel(
                        item: items[i],
                        size: editorPanelSize,
                        onItemChanged: (Item item) {
                          items[i] = item;
                          setState(() {
                            items = items;
                          });
                        },
                      )
                    : Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  Icons.warning_rounded,
                                  size: 80,
                                ),
                              ),
                              SizedBox(
                                width: editorPanelSize.width / 1.4,
                                child: AutoSizeText(
                                  'Silahkan pilih tulisan yang ingin diubah pada gambar di atas',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ]),
                      )
            ]),
          ),
        ),
        // FittedBox(
        //   child: Container(
        //   // height: editorPanelSize.height,
        //   width: editorPanelSize.width,
        //   child: ,
        // ),
        // ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
          width: double.infinity,
          child: RaisedButton(
            color: Colors.green[500],
            child: Text("Simpan", style: TextStyle(color: Colors.white)),
            onPressed: () async {
              final directory = await getExternalStorageDirectories(type: StorageDirectory.pictures);
              RenderRepaintBoundary boundary = repaintKey.currentContext.findRenderObject();
              final image = await boundary.toImage();
              ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
              Uint8List pngBytes = byteData.buffer.asUint8List();
              File("${directory.first.path}/${template.name}.png").writeAsBytes(pngBytes);
              final path = "${directory.first.path}/${template.name}.png";
              widget.onSave(items, path);
            },
          ),
        )
      ]),
    );
  }
}
