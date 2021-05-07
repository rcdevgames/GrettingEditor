import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:greeting_editor/Editor/Items/TextItem.dart';
import 'package:greeting_editor/Models/item.dart';
import 'package:greeting_editor/Utils/ResizebleWidget.dart';

class TemplateItem extends StatefulWidget {
  TemplateItem(
      {@required this.item,
      @required this.size,
      @required this.getDetails,
      @required this.isSelected});
  final Item item;
  final Size size;
  final void Function(Item item) getDetails;
  final Map<int, bool> Function({int index}) isSelected;

  @override
  _TemplateItemState createState() => _TemplateItemState();
}

class _TemplateItemState extends State<TemplateItem> {
  @override
  Widget build(_) {
    if (widget.getDetails != null) widget.getDetails(widget.item);
    return ResizebleWidget(
      getDetails: (Offset newOffset, Size newSize) {
        if (widget.item.offset ==
                Offset(newOffset.dx / widget.size.width,
                    newOffset.dy / widget.size.width) &&
            widget.item.size ==
                Size(newSize.width / widget.size.width,
                    newSize.height / widget.size.width)) return;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          widget.item.offset = Offset(newOffset.dx / widget.size.width,
              newOffset.dy / widget.size.width);
          widget.item.size = Size(newSize.width / widget.size.width,
              newSize.height / widget.size.width);
          setState(() {});
        });
      },
      isSelected: widget.isSelected,
      size: widget.size,
      color: widget.item.boxColor,
      initOffset:
          widget.item.offset == null ? widget.item.offset : widget.item.offset,
      initSize:
          widget.item.size == null ? const Size(0.7, 0.2) : widget.item.size,
      child: Center(child: TextItem(widget.item)),
    );
  }
}
