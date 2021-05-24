// To parse this JSON data, do
//
//     final template = templateFromMap(jsonString);

import 'dart:convert';

import 'item.dart';

Template templateFromMap(String str) => Template.fromMap(json.decode(str));

String templateToMap(Template data) => json.encode(data.toMap());

class Template {
    Template({
        this.templateUrl,
        this.logoUrl,
        this.items,
    });

    final String templateUrl;
    final String logoUrl;
    final List<Item> items;

    factory Template.fromMap(Map<String, dynamic> json) => Template(
        templateUrl: json["templateUrl"] == null ? null : json["templateUrl"],
        logoUrl: json["logoUrl"] == null ? null : json["logoUrl"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "templateUrl": templateUrl == null ? null : templateUrl,
        "logoUrl": logoUrl == null ? null : logoUrl,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => Item.toMap(x))),
    };
}