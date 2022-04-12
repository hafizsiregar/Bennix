import 'package:flutter/material.dart';
import 'package:benix/main_library.dart';
import 'package:benix/widget/buttons.dart';

import 'package:benix/widget/forms.dart';
import 'package:benix/widget/model/select_model.dart';

SelectData? _selectedData;
MultiSelectData? _multiSelectedData;

class Select {
  static Future<SelectData?> single({List<SelectData>? data, String? selectedId, required title, required context, SelectStyle? style, bool isSearch = true}) async {
    style ??= SelectStyle();
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    await Future.delayed(Duration.zero, () async {
      // final theme = Theme.of(context);
      return showModalBottomSheet<void>(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) => SelectBase(
          data: data ?? [],
          selectedid: selectedId,
          title: title,
          style: style!,
          isSearch: isSearch,
        ),
      );
    });
    return _selectedData;
  }

  static Future<MultiSelectData?> multi({List<SelectData>? data, List<String>? selectedId, required title, required context, SelectStyle? style}) async {
    style ??= SelectStyle();
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    await Future.delayed(Duration.zero, () async {
      final theme = Theme.of(context);
      return showModalBottomSheet<void>(
        isScrollControlled: true,
        backgroundColor: style!.backgroundColor ?? theme.backgroundColor,
        context: context,
        builder: (BuildContext context) => MultiSelectBase(
          data: data ?? [],
          selectedid: selectedId,
          title: title,
          style: style!,
        ),
      );
    });
    return _multiSelectedData;
  }
}

class SelectBase extends StatefulWidget {
  final List<SelectData>? data;
  final String? selectedid;
  final String title;
  final SelectStyle style;
  final bool isSearch;
  const SelectBase({
    Key? key,
    this.data,
    this.selectedid,
    required this.title,
    required this.style,
    required this.isSearch,
  }) : super(key: key);

  static getSelectedData() {
    return _selectedData;
  }

  @override
  _SelectBase createState() => _SelectBase();
}

class _SelectBase extends State<SelectBase> {
  TextEditingController _searching = TextEditingController();

  selected(SelectData selectedData) {
    _selectedData = selectedData;
    Navigator.of(context).pop();
  }

  current(id) {
    _selectedData = null;
    if (id != null && id != '') {
      for (SelectData i in widget.data ?? []) {
        if (i.id == id) {
          _selectedData = i;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _searching = TextEditingController();
    current(widget.selectedid);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: Container(
            decoration: BoxDecoration(color: widget.style.backgroundColor ?? theme.backgroundColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 2,
                      indent: getMaxWidth * 0.35,
                      endIndent: getMaxWidth * 0.35,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Text(
                        '${widget.title} ',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    widget.isSearch
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            child: Forms.normal(
                              context: context,
                              controller: _searching,
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Searching...',
                              onChanged: (val) {
                                setState(() {});
                              },
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      child: Column(
                        children: widget.data!.isEmpty
                            ? []
                            : widget.data!
                                .where((SelectData value) => value.title!.toUpperCase().contains(_searching.text.toUpperCase()))
                                .map(
                                  (value) => ListTile(
                                    tileColor: widget.selectedid == value.id ? widget.style.selectedBackgroundTextColor ?? Colors.transparent : Colors.transparent,
                                    leading: Icon(
                                      Icons.check,
                                      color: widget.selectedid == value.id! ? widget.style.selectedTextColor ?? (theme.textTheme.bodyText2 != null ? theme.textTheme.bodyText2!.color : Colors.green) : Colors.transparent,
                                    ),
                                    title: Text(value.title!, style: TextStyle(color: widget.selectedid == value.id ? widget.style.selectedTextColor ?? (theme.textTheme.bodyText2 != null ? theme.textTheme.bodyText2!.color : Colors.green) : theme.textTheme.bodyText2!.color)),
                                    onTap: () {
                                      selected(value);
                                    },
                                  ),
                                )
                                .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MultiSelectBase extends StatefulWidget {
  final List<SelectData>? data;
  final List<String>? selectedid;
  final String title;
  final SelectStyle style;
  const MultiSelectBase({
    Key? key,
    this.data,
    this.selectedid,
    required this.title,
    required this.style,
  }) : super(key: key);

  static getSelectedData() {
    return _selectedData;
  }

  @override
  _MultiSelectBase createState() => _MultiSelectBase();
}

class _MultiSelectBase extends State<MultiSelectBase> {
  final TextEditingController _searching = TextEditingController();
  List _parseList = [];
  final List<String> _id = [], _name = [];

  selected(name, id, active) {
    bool _activated = false;
    if (!active) {
      _id.add(id);
      _name.add(name);
      _activated = true;
    } else {
      _id.remove(id);
      _name.remove(name);
      _activated = false;
    }

    for (var i in _parseList) {
      if (i['id'] == id) {
        i['active'] = _activated;
      }
    }

    setState(() {});
  }

  parse() {
    List<String> selectedId = widget.selectedid ?? [];
    _parseList = [];

    if (widget.data != null) {
      if (widget.data is List) {
        for (SelectData i in widget.data ?? []) {
          bool _havevalue = false;
          if (selectedId is List) {
            for (String j in selectedId) {
              if (i.id == j) {
                _id.add(i.id!);
                _name.add(i.title!);
                _havevalue = true;
                break;
              }
            }
          }
          _parseList.add(ModelMultiSelect(
            active: _havevalue,
            id: i.id,
            name: i.title,
          ).toMap());
        }
      }
    }
  }

  @override
  void initState() {
    _multiSelectedData = null;
    _parseList.clear();
    _id.clear();
    _name.clear();
    super.initState();
    parse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: Container(
            decoration: BoxDecoration(color: widget.style.backgroundColor ?? theme.backgroundColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 2,
                      indent: getMaxWidth * 0.35,
                      endIndent: getMaxWidth * 0.35,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Text(
                        '${widget.title} ',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Forms.normal(
                        context: context,
                        controller: _searching,
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Searching...',
                        onChanged: (val) {
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      child: Column(
                        children: _parseList.isEmpty
                            ? []
                            : _parseList
                                .where((value) => value['name'].toString().toUpperCase().contains(_searching.text.toUpperCase()))
                                .map((value) => ListTile(
                                      leading: Icon(
                                        Icons.check,
                                        color: value['active'] ? BaseColor.theme!.successColor : Colors.transparent,
                                      ),
                                      title: Text(value['name'], style: TextStyle(color: value['active'] ? BaseColor.theme!.successColor : Theme.of(context).textTheme.bodyText2?.color)),
                                      onTap: () {
                                        selected(value['name'], value['id'], value['active']);
                                      },
                                    ))
                                .toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Button.flat(
                        context: context,
                        title: 'Pilih',
                        onTap: () {
                          _multiSelectedData = MultiSelectData(
                            id: _id,
                            title: _name,
                          );
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
