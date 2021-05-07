import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:greeting_editor/Editor/Items/TemplateItem.dart';
import 'package:greeting_editor/Models/item.dart';

class TemplatePreview extends StatefulWidget {
  TemplatePreview(
      {@required this.size,
      this.getDetails,
      @required this.items,
      @required this.templateUrl,
      this.isLoading,
      this.getId});
  final Size size;
  final bool isLoading;
  final List<Item> items;
  final String templateUrl;
  final void Function(List<Item> items) getDetails;
  final void Function(int id) getId;

  @override
  _TemplatePreviewState createState() {
    List<bool> status = List<bool>.filled(items.length, false);
    return _TemplatePreviewState(status, items, isLoading);
  }
}

class _TemplatePreviewState extends State<TemplatePreview> {
  _TemplatePreviewState(this.status, this.items, this.isLoading) {
    if (isLoading == null) isLoading = false;
  }
  List<bool> status;
  List<Item> items;
  bool isLoading;
  int id;
  Map<int, bool> _isSelected(bool isNonSelected, {int index, int i}) {
    if (index == null) return {i: status[i]};
    if (isNonSelected) {
      setState(() {
        status = List<bool>.filled(items.length, false);
        id = 3;
      });
    } else
      setState(() {
        for (int i = 0; i < status.length; i++) {
          status[i] = i == index ? true : false;
        }
        id = index;
      });
    return {i: status[i]};
  }

  @override
  Widget build(_) {
    if (widget.getDetails != null) widget.getDetails(items);
    if (widget.getId != null) widget.getId(id);
    return Container(
      height: widget.size.width,
      width: widget.size.width,
      color: Colors.grey[200],
      child: Stack(
        children: [
          if (widget.templateUrl != null)
            TextButton(
              onPressed: () {
                _isSelected(true, index: 0, i: 0);
              },
              child: Center(
                  child: Image.network(
                widget.templateUrl,
                loadingBuilder:
                    (_, Widget child, ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  if (loadingProgress.cumulativeBytesLoaded ==
                      loadingProgress.expectedTotalBytes) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        isLoading = true;
                      });
                    });
                  }
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Gambar sedang di muat',
                          style: TextStyle(color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.grey,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        )
                      ]);
                },
              )),
            ),
          if (isLoading)
            for (int i = 0; i < items.length; i++)
              TemplateItem(
                isSelected: ({index}) => _isSelected(false, index: index, i: i),
                size: widget.size,
                getDetails: (Item item) {
                  if (items[i] == item) return;
                  setState(() {
                    items[i] = item;
                  });
                },
                item: items[i],
              )
        ],
      ),
    );
  }
}
