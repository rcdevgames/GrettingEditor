// To parse this JSON data, do
//
//     final item = itemFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Item itemFromMap(String str) => Item.fromMap(json.decode(str));

String itemToMap(Item data) => json.encode(data.toMap());

class Item {
    Item({
        @required this.text,
        @required this.itemType,
        @required this.maxLines,
        @required this.format,
        @required this.offset,
        @required this.size,
        @required this.color,
        @required this.outlineColor,
        @required this.logoUrl,
        @required this.font,
        @required this.mode,
    });

    String text;
    String itemType;
    int maxLines;
    List<bool> format;
    List<double> offset;
    List<double> size;
    List<int> color;
    List<int> outlineColor;
    String logoUrl;
    String font;
    int mode;

    factory Item.fromMap(Map<String, dynamic> json) => Item(
        text: json["text"] == null ? null : json["text"],
        itemType: json["itemType"] == null ? null : json["itemType"],
        maxLines: json["maxLines"] == null ? null : json["maxLines"],
        format: json["format"] == null ? null : List<bool>.from(json["format"].map((x) => x)),
        offset: json["offset"] == null ? null : List<double>.from(json["offset"].map((x) => x.toDouble())),
        size: json["size"] == null ? null : List<double>.from(json["size"].map((x) => x.toDouble())),
        color: json["color"] == null ? null : List<int>.from(json["color"].map((x) => x)),
        outlineColor: json["outlineColor"] == null ? null : List<int>.from(json["outlineColor"].map((x) => x)),
        logoUrl: json["logoUrl"] == null ? null : json["logoUrl"],
        font: json["font"] == null ? null : json["font"],
        mode: json["mode"] == null ? null : json["mode"],
    );

    Map<String, dynamic> toMap() => {
        "text": text == null ? null : text,
        "itemType": itemType == null ? null : itemType,
        "maxLines": maxLines == null ? null : maxLines,
        "format": format == null ? null : List<dynamic>.from(format.map((x) => x)),
        "offset": offset == null ? null : List<dynamic>.from(offset.map((x) => x)),
        "size": size == null ? null : List<dynamic>.from(size.map((x) => x)),
        "color": color == null ? null : List<dynamic>.from(color.map((x) => x)),
        "outlineColor": outlineColor == null ? null : List<dynamic>.from(outlineColor.map((x) => x)),
        "logoUrl": logoUrl == null ? null : logoUrl,
        "font": font == null ? null : font,
        "mode": mode == null ? null : mode,
    };
}
