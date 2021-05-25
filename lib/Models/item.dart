import 'package:flutter/material.dart';
import 'package:greeting_editor/Utils/FontList.dart';

class Item {
  String _text, itemType, _logoUrl, _font;
  Offset _offset;
  List<bool> _format;
  Size size;
  Color _color, _outlineColor;
  int _maxLines, _mode;

  Item.init(this.itemType);

  static String defaultLogo =
      'https://firebasestorage.googleapis.com/v0/b/rota-app-767c2.appspot.com/o/logo%20test.png?alt=media&token=4109106b-edeb-4607-95a8-fd62b3f96178';

  String get font => _getFont(_font);
  String get text => _getText(_text);
  int get maxlines => _getMaxLines(_maxLines);
  Offset get offset => _getOffset(_offset);
  Color get outlineColor => _getOutlineColor(_outlineColor);
  String get logoUrl => _getLogoUrl(_logoUrl);
  Color get color => _getColor(_color);
  List<bool> get format => _getFormat(_format);
  int get mode => _getMode(_mode);
  List<String> get fontCollection =>
      itemType == 'ucapan' ? Font.ucapan : Font.list;
  Color get boxColor {
    switch (itemType) {
      case 'ucapan':
        return Colors.red[200];
        break;
      case 'untuk':
        return Colors.green[200];
        break;
      case 'dari':
        return Colors.blue[200];
        break;
      default:
        return Colors.white;
    }
  }

  void setFont(int _index) {
    _font = this.fontCollection[_index];
  }

  set offset(Offset _offset) {
    this._offset = _offset;
  }

  set maxlines(int _maxlines) {
    this._maxLines = _maxlines;
  }

  set text(String _text) {
    this._text = _text;
  }

  set mode(int _mode) {
    this._mode = _mode;
  }

  set color(Color _color) {
    this._color = _color;
  }

  set outlineColor(Color _outlineColor) {
    this._outlineColor = _outlineColor;
  }

  void setFormat(int index) {
    List<bool> temp = format;
    temp[index] = !temp[index];
    this._format = temp;
  }

  String _getLogoUrl(String data) => (itemType == 'dari')
      ? data == null
          ? defaultLogo
          : data
      : data == null
          ? null
          : data;

  int _getMaxLines(int _data) => _data == null
      ? itemType == 'ucapan'
          ? 1
          : 2
      : _data;

  int _getMode(int _data) => _data == null ? 0 : _data;

  Color _getOutlineColor(Color _data) => itemType == 'ucapan'
      ? _data == null
          ? Colors.black
          : _data
      : _data == null
          ? null
          : _data;

  String _getFont(String _data) => itemType == 'ucapan'
      ? _data == null
          ? 'Dancing Script'
          : _data
      : _data == null
          ? 'Oswald'
          : _data;

  String _getText(String _data) {
    if (_data != null) return _data;
    switch (itemType) {
      case 'ucapan':
        return 'Selamat & Sukses';
        break;
      case 'untuk':
        return 'Atas Peresmian Aplikasi Bisnis Pintar di DKI Jakarta';
        break;
      case 'dari':
        return 'PT. Bisnis Pintar Indonesia';
        break;
      default:
        return 'PT. Bisnis Pintar Indonesia';
    }
  }

  Offset _getOffset(Offset _offset) {
    if (_offset != null) return _offset;
    switch (itemType) {
      case 'ucapan':
        return const Offset(0.16, 0.115);
        break;
      case 'untuk':
        return const Offset(0.16, 0.40);
        break;
      case 'dari':
        return const Offset(0.16, 0.68);
        break;
      default:
        return const Offset(0.4, 0.5);
    }
  }

  List<bool> _getFormat(List<bool> _data) =>
      _data == null ? List.filled(2, false) : _data;

  Color _getColor(_data) => _data == null ? Colors.white : _data;

  static Map<String, dynamic> toMap(Item _item) => {
        'text': _item.text,
        'itemType': _item.itemType,
        'maxLines': _item.maxlines,
        'format': _item.format,
        'offset': [_item.offset.dx, _item.offset.dy],
        'size':
            _item.size == null ? null : [_item.size.width, _item.size.height],
        'color': [
          _item.color.red.toInt(),
          _item.color.green.toInt(),
          _item.color.blue.toInt()
        ],
        'outlineColor': _item.outlineColor == null
            ? null
            : [
                _item.outlineColor.red.toInt(),
                _item.outlineColor.green.toInt(),
                _item.outlineColor.blue.toInt()
              ],
        'logoUrl': _item.logoUrl,
        'font': _item.font,
        'mode': _item.mode == null ? 0 : _item.mode
      };

  Item.fromMap(Map<String, dynamic> _map)
      : _text = _map['text'],
        itemType = _map['itemType'],
        _maxLines = _map['maxLines'].toInt(),
        _format = (_map['format'] as List).map((e) => bool.fromEnvironment(e.toString(), defaultValue: false)).toList(),
        _offset = Offset(_map['offset'][0], _map['offset'][1]),
        size = _map['size'] == null
            ? null
            : Size(_map['size'][0], _map['size'][1]),
        _color = Color.fromARGB(
          255,
          _map['color'][0].toInt(),
          _map['color'][1].toInt(),
          _map['color'][2].toInt(),
        ),
        _outlineColor = _map['outlineColor'] == null || _map['outlineColor'] == "null" ? null : Color.fromARGB(
          255,
          _map['outlineColor'][0].toInt(),
          _map['outlineColor'][1].toInt(),
          _map['outlineColor'][2].toInt(),
        ),
        _logoUrl = _map['logoUrl'],
        _font = _map['font'],
        _mode = _map['mode'] == null ? 0 : _map['mode'].toInt();
}
