import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:greeting_editor/Models/item.dart';
import 'package:o_color_picker/o_color_picker.dart';

class ColorChanger extends StatelessWidget {
  ColorChanger(this.item,
      {this.onColorChange, @required this.isOutline, this.label});
  final Item item;
  final String label;
  final bool isOutline;
  final void Function(Color) onColorChange;
  @override
  Widget build(BuildContext context) => ListTile(
        tileColor: item.boxColor,
        title: label != null ? AutoSizeText(label) : Container(),
        trailing: TextButton(
          onPressed: () => showDialog<void>(
            context: context,
            builder: (_) => Dialog(
              elevation: 0.0,
              backgroundColor: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OColorPicker(
                    selectedColor: isOutline ? item.outlineColor : item.color,
                    colors: primaryColorsPalette,
                    onColorChange: onColorChange),
              ),
            ),
          ),
          child: Container(
            height: 30,
            width: 30,
            color: isOutline ? item.outlineColor : item.color,
          ),
        ),
      );
}
