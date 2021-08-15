import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greeting_editor/Editor/Items/TextItem.dart';
import 'package:greeting_editor/Editor/Panels/ColorChanger.dart';
import 'package:greeting_editor/Editor/Panels/FontChanger.dart';
import 'package:greeting_editor/Editor/Panels/FormatChanger.dart';
import 'package:greeting_editor/Editor/Panels/MaxLinesChanger.dart';
import 'package:greeting_editor/Editor/Panels/ModeChanger.dart';
import 'package:greeting_editor/Editor/Panels/TextChanger.dart';
import 'package:greeting_editor/Models/item.dart';
import 'package:image_picker/image_picker.dart';

class EditorPanel extends StatelessWidget {
  EditorPanel(
      {@required this.item, @required this.size, @required this.onItemChanged});
  final Item item;
  final Size size;
  final void Function(Item item) onItemChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      TextChanger(
        item,
        label: 'Ubah Tulisan',
        onTextChanged: (String newText) {
          item.text = newText;
          onItemChanged(item);
        },
      ),
      FormatChanger(
          item: item,
          onTextFormatChanged: (int index) {
            item.setFormat(index);
            onItemChanged(item);
          }),
      if (item.mode != 2)
        FontChanger(item, size.height, label: 'Geser ke kanan untuk ganti font',
            onPageChanged: (int index) {
          item.setFont(index);
          onItemChanged(item);
        }),
      if (item.mode != 0)
        ListTile(
          onTap: () async {
            final picker = ImagePicker();
            final pickedFile = await picker.getImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              item.logoUrl = await pickedFile.readAsBytes();
              onItemChanged(item);
            }
          },
          tileColor: item.boxColor,
          title: Text('Logo Perusahaan'),
          trailing: LogoItem(item),
        ),
      ColorChanger(
        item,
        isOutline: false,
        label: 'Warna tulisan',
        onColorChange: (Color color) {
          item.color = color;
          onItemChanged(item);
          Navigator.of(context).pop();
        },
      ),
      if (item.outlineColor != null)
        ColorChanger(
          item,
          isOutline: true,
          label: 'Warna garis luar tulisan',
          onColorChange: (Color color) {
            item.outlineColor = color;
            onItemChanged(item);
            Navigator.of(context).pop();
          },
        ),
      if (item.maxlines != null)
        MaxLinesChanger(item, onMaxlinesChanged: (int index) {
          item.maxlines = index + 1;
          onItemChanged(item);
        }),
      if (item.itemType == 'dari')
        ModeChanger(item, size, (int index) {
          item.mode = index;
          onItemChanged(item);
        })
    ]);
  }
}
