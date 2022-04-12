import 'package:flutter/material.dart' show Color, TextEditingController;

class SelectResult {
  final TextEditingController name = TextEditingController();
  String? id;
}

class SelectData {
  final Map<String, dynamic>? objectData;
  final List? listData;
  final String? title;
  final String? id;

  SelectData({this.id, this.listData, this.objectData, this.title});
}

class SelectStyle {
  Color? backgroundColor,

      /// default Theme.of(context).textTheme.caption || Colors.green
      selectedTextColor,
      // default Colors.Transparent
      selectedBackgroundTextColor;
  SelectStyle({this.backgroundColor, this.selectedBackgroundTextColor, this.selectedTextColor});
}

class MultiSelectData {
  List<String>? title;
  List<String>? id;
  List<Map<String, dynamic>>? objectData;
  List<List>? listData;

  MultiSelectData({this.id, this.listData, this.objectData, this.title});
}

class ModelMultiSelect {
  String? id, name;
  bool? active;

  ModelMultiSelect({this.id, this.name, this.active});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'active': active,
    };
  }
}
