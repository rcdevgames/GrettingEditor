import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:greeting_editor/Editor/Items/TextItem.dart';
import 'package:greeting_editor/Models/item.dart';

class FontChanger extends StatelessWidget {
  FontChanger(this.item, this.height, {this.label, this.onPageChanged});
  final Item item;
  final String label;
  final double height;
  final dynamic Function(int index) onPageChanged;
  @override
  Widget build(_) => ListTile(
      tileColor: item.boxColor,
      subtitle: label == null ? Center(child: Text(label)) : Container(),
      title: CarouselSlider.builder(
        itemCount: item.fontCollection.length,
        itemBuilder: (_, int itemIndex, __) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextItem(item, font: item.fontCollection[itemIndex]),
        ),
        options: CarouselOptions(
          initialPage: item.fontCollection.indexOf(item.font),
          height: height / 5,
          onPageChanged: (int index, _) {
            onPageChanged(index);
          },
        ),
      ));
}
