
import 'item.dart';

class Template {
  String name, templateUrl;
  List<Item> items;
  Template(this.name, this.templateUrl, this.items);
  Template.withItems(Template _template, List<Item> items)
      : this.items = items,
        this.name = _template.name,
        this.templateUrl = _template.templateUrl;

  List<Item> get itemData {
    if (items == null) {
      final List<Item> initItems = [
        Item.fromMap({
          "text": "Selamat & Sukses",
          "itemType": "ucapan",
          "maxLines": 1,
          "format": [false, false],
          "offset": [0.16, 0.12434579439252336],
          "size": [0.7, 0.2],
          "color": [255, 255, 255],
          "outlineColor": [0, 0, 0],
          "logoUrl": null,
          "font": "Kaushan Script",
          "mode": 0
        }),
        Item.fromMap({
          "text": "Atas Peresmian Aplikasi Bisnis Pintar di DKI Jakarta",
          "itemType": "untuk",
          "maxLines": 2,
          "format": [false, false],
          "offset": [0.15844235571745402, 0.3423675893623139],
          "size": [0.7, 0.2],
          "color": [255, 255, 255],
          "outlineColor": [0, 0, 0],
          "logoUrl": null,
          "font": "Oswald",
          "mode": 0
        }),
        Item.fromMap({
          "text": "PT. Bisnis Pintar Indonesia",
          "itemType": "dari",
          "maxLines": 2,
          "format": [false, false],
          "offset": [0.16, 0.6550778697361457],
          "size": [0.7, 0.2],
          "color": [255, 255, 255],
          "outlineColor": [0, 0, 0],
          "logoUrl": "https://firebasestorage.googleapis.com/v0/b/rota-app-767c2.appspot.com/o/logo%20test.png?alt=media&token=4109106b-edeb-4607-95a8-fd62b3f96178",
          "font": "Oswald",
          "mode": 0
        })  
      ];
      return initItems;
    }
    return items;
  }

  set itemData(List<Item> items) {
    this.items = items;
  }

  static Map<String, dynamic> toMap(Template _template) => {
        'text': _template.name,
        'templateUrl': _template.templateUrl,
        'items': _template.items,
      };

  Template.fromMap(Map<String, dynamic> _map)
      : name = _map['name'],
        templateUrl = _map['templateUrl'],
        items = _map['items'];
}
