import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:greeting_editor/Models/item.dart';

class MaxLinesChanger extends StatelessWidget {
  MaxLinesChanger(this.item, {@required this.onMaxlinesChanged});
  final Item item;
  final void Function(int index) onMaxlinesChanged;
  @override
  Widget build(_) => ListTile(
        tileColor: item.boxColor.withOpacity(0.8),
        title: Text('Baris maksimal tulisan'),
        subtitle: Text('Geser pada angka untuk mengubah'),
        trailing: Container(
          height: 30,
          width: 80,
          decoration: BoxDecoration(
              color: item.boxColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (_, int itemIndex, __) => Center(
              child: Text((itemIndex + 1).toString()),
            ),
            options: CarouselOptions(
                initialPage: item.maxlines - 1,
                height: 20,
                onPageChanged: (int index, _) {
                  onMaxlinesChanged(index);
                }),
          ),
        ),
      );
}
