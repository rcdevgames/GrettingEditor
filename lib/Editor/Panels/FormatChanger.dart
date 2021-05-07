import 'package:flutter/material.dart';
import 'package:greeting_editor/Models/item.dart';

class FormatChanger extends StatelessWidget {
  FormatChanger({@required this.item, @required this.onTextFormatChanged});
  final void Function(int index) onTextFormatChanged;
  final Item item;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: item.boxColor.withOpacity(0.5),
      title: ToggleButtons(
        isSelected: item.format,
        children: [
          Icon(Icons.format_bold),
          Icon(Icons.text_fields),
        ],
        onPressed: onTextFormatChanged,
        color: Colors.white,
        borderColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        selectedColor: Colors.black,
        fillColor: item.boxColor,
      ),
    );
  }
}
