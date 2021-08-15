import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeting_editor/Models/item.dart';
import 'package:greeting_editor/Utils/capitalize.dart';

class TextItem extends StatelessWidget {
  final Item item;
  final String font;
  TextItem(this.item, {this.font});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (item.outlineColor != null && item.mode != 2)
          Row(
            children: [
              if (item.mode == 1)
                Container(
                  height: (item.size.height * MediaQuery.of(context).size.width) - 10,
                  width: (item.size.height * MediaQuery.of(context).size.width) - 10,
                ),
              Flexible(
                flex: 3,
                child: Center(
                  child: AutoSizeText(
                    item.format[1]
                        ? item.text.toUpperCase()
                        : item.text.capitalize(),
                    maxLines: item.maxlines,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(font != null ? font : item.font,
                            fontSize: 2000,
                            fontWeight: item.format[0]
                                ? FontWeight.bold
                                : FontWeight.normal)
                        .merge(TextStyle(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = item.outlineColor,
                    )),
                  ),
                ),
              ),
            ],
          ),
        Row(
          children: [
            if (item.itemType == 'dari' && item.size != null && item.logoUrl != null)
              if (item.mode != 0)
                Flexible(flex: 1, child: Center(child: LogoItem(item))),
            if (item.mode != 2)
              Flexible(
                flex: 3,
                child: Center(
                  child: AutoSizeText(
                      item.format[1]
                          ? item.text.toUpperCase()
                          : item.text.capitalize(),
                      maxLines: item.maxlines,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                          font != null ? font : item.font,
                          fontSize: 2000,
                          color: item.color,
                          fontWeight: item.format[0]
                              ? FontWeight.bold
                              : FontWeight.normal)),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class LogoItem extends StatelessWidget {
  LogoItem(this.item);
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: item.size.height * MediaQuery.of(context).size.width,
        width: item.size.height * MediaQuery.of(context).size.width,
        child: Center(
          child: Image.memory(item.logoUrl),
        ));
  }
}
