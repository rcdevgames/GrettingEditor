import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:greeting_editor/Models/item.dart';

class ModeChanger extends StatelessWidget {
  ModeChanger(this.item, this.size, this.onChanged);
  final Size size;
  final Item item;
  final Function(int index) onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: item.boxColor,
      title: Container(
        width: size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (int i = 0; i < 3; i++)
              Flexible(
                child: ModeButton(
                  mode: item.mode,
                  size: size,
                  buttonMode: i,
                  onChanged: () => onChanged(i),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ModeButton extends StatelessWidget {
  ModeButton(
      {@required this.size,
      @required this.buttonMode,
      @required this.mode,
      @required this.onChanged});
  final Size size;
  final int buttonMode;
  final int mode;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.transparent)),
      onPressed: onChanged,
      child: Container(
        height: size.height / 10,
        // width: size.width / 4,
        color: buttonMode == mode ? Colors.white : Colors.white30,
        child: Center(
            child: Row(
          children: [
            if (buttonMode != 0)
              Flexible(
                flex: 1,
                child: Center(
                  child: SizedBox(
                    height: size.height / 15,
                    width: size.height / 15,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: AutoSizeText(
                        "Logo",
                        textAlign: TextAlign.center,
                        minFontSize: 5,
                        maxLines: 1,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            if (buttonMode != 2)
              Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: AutoSizeText("Nama Perusahaan",
                          minFontSize: 5,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(color: Colors.black)),
                    ),
                  )),
          ],
        )),
      ),
    );
  }
}
