import 'package:flutter/material.dart';

import '../TemplatePreview.dart';
import '../../Models/Template.dart';

class TemplateShow extends StatelessWidget {
  TemplateShow({@required this.template, @required this.width, @required this.height});
  final Template template;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          TemplatePreview(
            items: template.itemData,
            size: Size(width, height),
            templateUrl: template.templateUrl,
          ),
          Container(
            height: (height/2) - AppBar().preferredSize.height,
            width: width,
            color: Colors.white10,
          )
        ],
      ),
    );
  }
}