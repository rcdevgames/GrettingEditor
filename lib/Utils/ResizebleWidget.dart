import 'package:flutter/material.dart';

class ResizebleWidget extends StatefulWidget {
  ResizebleWidget(
      {this.ballDiameter = 20,
      this.color = Colors.white,
      @required this.isSelected,
      @required this.child,
      @required this.size,
      @required this.getDetails,
      @required this.initSize,
      @required this.initOffset});

  final Widget child;
  final double ballDiameter;
  final Size initSize;
  final Size size;
  final Color color;
  final Offset initOffset;
  final Map<int, bool> Function({int index}) isSelected;
  final Function(Offset offset, Size size) getDetails;
  @override
  _ResizebleWidgetState createState() {
    return _ResizebleWidgetState(
        Size(initSize.width * size.width, initSize.height * size.width),
        Offset(initOffset.dx * size.width, initOffset.dy * size.width),
        color);
  }
}

class _ResizebleWidgetState extends State<ResizebleWidget> {
  _ResizebleWidgetState(this._size, this._offset, this.color);
  Size _size;
  Offset _offset;
  double _mid, _newHeight, _newWidth;
  Color color;

  @override
  Widget build(BuildContext context) {
    widget.getDetails(_offset, _size);
    Color selectedColor =
        widget.isSelected().values.first ? color : Colors.transparent;
    // top left
    List<Widget> selector = [
      Positioned(
        top: _offset.dy - widget.ballDiameter / 2,
        left: _offset.dx - widget.ballDiameter / 2,
        child: _ManipulatingBall(
          color: selectedColor,
          ballDiameter: widget.ballDiameter,
          onDrag: (Offset newOffset) {
            _mid = (newOffset.dx + newOffset.dy) / 2;
            _newHeight = _size.height - 2 * _mid;
            _newWidth = _size.width - 2 * _mid;

            setState(() {
              _size = Size(_newWidth > 0 ? _newWidth : 0,
                  _newHeight > 0 ? _newHeight : 0);
              _offset = Offset(_offset.dx + _mid, _offset.dy + _mid);
            });
          },
        ),
      ),
      // top middle
      Positioned(
        top: _offset.dy - 10 / 2,
        left: _offset.dx + _size.width / 2 - widget.ballDiameter / 2 - 10,
        child: _ManipulatingStrip(
          horizontal: true,
          color: selectedColor,
          ballDiameter: widget.ballDiameter,
          onDrag: (Offset newOffset) {
            double newHeight = _size.height - newOffset.dy;
            setState(() {
              _size = Size(_size.width, newHeight > 0 ? newHeight : 0);
              _offset = Offset(_offset.dx, _offset.dy + newOffset.dy);
            });
          },
        ),
      ),
      // top right
      Positioned(
        top: _offset.dy - widget.ballDiameter / 2,
        left: _offset.dx + _size.width - widget.ballDiameter / 2,
        child: _ManipulatingBall(
          color: selectedColor,
          ballDiameter: widget.ballDiameter,
          onDrag: (Offset newOffset) {
            _mid = (newOffset.dx + (newOffset.dy * -1)) / 2;
            _newHeight = _size.height + 2 * _mid;
            _newWidth = _size.width + 2 * _mid;

            setState(() {
              _size = Size(_newWidth > 0 ? _newWidth : 0,
                  _newHeight > 0 ? _newHeight : 0);
              _offset = Offset(_offset.dx - _mid, _offset.dy - _mid);
            });
          },
        ),
      ),
      // center right
      Positioned(
        top: _offset.dy + _size.height / 2 - widget.ballDiameter / 2,
        left: _offset.dx + _size.width - 12 / 2,
        child: _ManipulatingStrip(
          color: selectedColor,
          ballDiameter: widget.ballDiameter,
          onDrag: (Offset newOffset) {
            _newWidth = _size.width + newOffset.dx;

            setState(() {
              _size = Size(_newWidth > 0 ? _newWidth : 0, _size.height);
            });
          },
        ),
      ),
      // bottom right
      Positioned(
        top: _offset.dy + _size.height - widget.ballDiameter / 2,
        left: _offset.dx + _size.width - widget.ballDiameter / 2,
        child: _ManipulatingBall(
          color: selectedColor,
          ballDiameter: widget.ballDiameter,
          onDrag: (Offset newOffset) {
            _mid = (newOffset.dx + newOffset.dy) / 2;
            _newHeight = _size.height + 2 * _mid;
            _newWidth = _size.width + 2 * _mid;
            setState(() {
              _size = Size(_newWidth > 0 ? _newWidth : 0,
                  _newHeight > 0 ? _newHeight : 0);
              _offset = Offset(_offset.dx - _mid, _offset.dy - _mid);
            });
          },
        ),
      ),
      // bottom center
      Positioned(
        top: _offset.dy + _size.height - 10 / 2,
        left: _offset.dx + _size.width / 2 - widget.ballDiameter / 2 - 10,
        child: _ManipulatingStrip(
          color: selectedColor,
          horizontal: true,
          ballDiameter: widget.ballDiameter,
          onDrag: (Offset newOffset) {
            _newHeight = _size.height + newOffset.dy;
            setState(() {
              _size = Size(_size.width, _newHeight > 0 ? _newHeight : 0);
            });
          },
        ),
      ),
      // bottom left
      Positioned(
        top: _offset.dy + _size.height - widget.ballDiameter / 2,
        left: _offset.dx - widget.ballDiameter / 2,
        child: _ManipulatingBall(
          color: selectedColor,
          ballDiameter: widget.ballDiameter,
          onDrag: (Offset newOffset) {
            _mid = ((newOffset.dx * -1) + newOffset.dy) / 2;
            _newHeight = _size.height + 2 * _mid;
            _newWidth = _size.width + 2 * _mid;
            setState(() {
              _size = Size(_newWidth > 0 ? _newWidth : 0,
                  _newHeight > 0 ? _newHeight : 0);
              _offset = Offset(_offset.dx - _mid, _offset.dy - _mid);
            });
          },
        ),
      ),
      //left center
      Positioned(
        top: _offset.dy + _size.height / 2 - widget.ballDiameter / 2,
        left: _offset.dx - 8 / 2,
        child: _ManipulatingStrip(
          color: selectedColor,
          ballDiameter: widget.ballDiameter,
          onDrag: (Offset newOffset) {
            _newWidth = _size.width - newOffset.dx;
            setState(() {
              _size = Size(_newWidth > 0 ? _newWidth : 0, _size.height);
              _offset = Offset(_offset.dx + newOffset.dx, _offset.dy);
            });
          },
        ),
      )
    ];
    return Stack(
      children: <Widget>[
        Positioned(
          top: _offset.dy,
          left: _offset.dx,
          child: Container(
            height: _size.height,
            width: _size.width,
            decoration: BoxDecoration(
                border: Border.all(color: selectedColor, width: 2)),
            child: widget.child,
          ),
        ),
        // center center
        Positioned(
          top: _offset.dy,
          left: _offset.dx,
          child: _ManipulatingArea(
              width: _size.width,
              height: _size.height,
              onDrag: (Offset newOffset) {
                setState(() {
                  _offset = Offset(
                      _offset.dx + newOffset.dx, _offset.dy + newOffset.dy);
                  widget.isSelected(index: widget.isSelected().keys.first);
                });
              }),
        ),
        if (widget.isSelected().values.first)
          for (var i = 0; i < selector.length; i++) selector[i]
      ],
    );
  }
}

class _ManipulatingStrip extends StatefulWidget {
  _ManipulatingStrip(
      {this.onDrag,
      @required this.ballDiameter,
      @required this.color,
      this.horizontal = false});

  final Function(Offset offset) onDrag;
  final double ballDiameter;
  final bool horizontal;
  final Color color;

  @override
  _ManipulatingStripState createState() => _ManipulatingStripState();
}

class _ManipulatingStripState extends State<_ManipulatingStrip> {
  Offset _offset, _newOffset;

  _handleDrag(DragStartDetails details) {
    setState(() {
      _offset = details.globalPosition;
    });
  }

  _handleUpdate(DragUpdateDetails details) {
    _newOffset = Offset(details.globalPosition.dx - _offset.dx,
        details.globalPosition.dy - _offset.dy);
    _offset = Offset(details.globalPosition.dx, details.globalPosition.dy);
    widget.onDrag(_newOffset);
  }

  @override
  Widget build(_) => GestureDetector(
        onPanStart: _handleDrag,
        onPanUpdate: _handleUpdate,
        child: Container(
          width: widget.horizontal ? widget.ballDiameter + 10 : 10,
          height: widget.horizontal ? 10 : widget.ballDiameter,
          decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: widget.color == Colors.transparent
                      ? Colors.transparent
                      : Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 3.0,
                )
              ]),
        ),
      );
}

class _ManipulatingBall extends StatefulWidget {
  _ManipulatingBall(
      {this.onDrag, @required this.ballDiameter, @required this.color});

  final Function(Offset offset) onDrag;
  final Color color;
  final double ballDiameter;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<_ManipulatingBall> {
  Offset _offset, _newOffset;

  _handleDrag(DragStartDetails details) {
    setState(() {
      _offset = details.globalPosition;
    });
  }

  _handleUpdate(DragUpdateDetails details) {
    _newOffset = Offset(details.globalPosition.dx - _offset.dx,
        details.globalPosition.dy - _offset.dy);
    _offset = Offset(details.globalPosition.dx, details.globalPosition.dy);
    widget.onDrag(_newOffset);
  }

  @override
  Widget build(_) => GestureDetector(
        onPanStart: _handleDrag,
        onPanUpdate: _handleUpdate,
        child: Container(
          width: widget.ballDiameter,
          height: widget.ballDiameter,
          decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.color == Colors.transparent
                      ? Colors.transparent
                      : Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 3.0,
                )
              ]),
        ),
      );
}

class _ManipulatingArea extends StatefulWidget {
  _ManipulatingArea({this.onDrag, @required this.width, @required this.height});

  final Function(Offset offset) onDrag;
  final double width;
  final double height;

  @override
  _ManipulatingAreaState createState() => _ManipulatingAreaState();
}

class _ManipulatingAreaState extends State<_ManipulatingArea> {
  Offset _offset, _newOffset;

  _handleDrag(DragStartDetails details) {
    setState(() {
      _offset = details.globalPosition;
    });
  }

  _handleUpdate(DragUpdateDetails details) {
    _newOffset = Offset(details.globalPosition.dx - _offset.dx,
        details.globalPosition.dy - _offset.dy);
    _offset = Offset(details.globalPosition.dx, details.globalPosition.dy);
    widget.onDrag(_newOffset);
  }

  @override
  Widget build(_) => GestureDetector(
        onPanStart: _handleDrag,
        onPanUpdate: _handleUpdate,
        child: Container(
          width: widget.width,
          height: widget.height,
          color: Colors.transparent,
        ),
      );
}
