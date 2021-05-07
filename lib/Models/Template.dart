
import 'item.dart';

class Template {
  String name, templateUrl;
  List<Item> _items;
  Template(this.name, this.templateUrl);
  Template.withItems(Template _template, List<Item> _items)
      : this._items = _items,
        this.name = _template.name,
        this.templateUrl = _template.templateUrl;

  List<Item> get items {
    if (_items == null) {
      final List<Item> initItems = [
        Item.init('ucapan'),
        Item.init('untuk'),
        Item.init('dari')
      ];
      return initItems;
    }
    return _items;
  }

  set items(List<Item> _items) {
    this._items = _items;
  }

  static Map<String, dynamic> toMap(Template _template) => {
        'text': _template.name,
        'templateUrl': _template.templateUrl,
        'items': _template.items,
      };

  Template.fromMap(Map<String, dynamic> _map)
      : name = _map['name'],
        templateUrl = _map['templateUrl'],
        _items = _map['items'];
}
