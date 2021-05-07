import 'package:flutter/material.dart';
import 'package:greeting_editor/Models/item.dart';

class TextChanger extends StatefulWidget {
  TextChanger(this.item, {@required this.onTextChanged, this.label});
  final Item item;
  final String label;
  final void Function(String) onTextChanged;
  @override
  _TextChangerState createState() => _TextChangerState();
}

class _TextChangerState extends State<TextChanger> {
  TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.item.text);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(_) => ListTile(
        tileColor: widget.item.boxColor.withOpacity(0.8),
        title: TextField(
          controller: textEditingController,
          maxLines: 2,
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.text,
          onSubmitted: widget.onTextChanged,
          decoration: InputDecoration(
            labelText: widget.label == null ? '' : widget.label,
            labelStyle: TextStyle(color: Colors.black38),
            border: InputBorder.none,
          ),
        ),
      );
}
