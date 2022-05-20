import 'dart:convert';
import 'dart:io';

import 'package:benix/main_library.dart' show AnimateTransition, BaseBackground, BaseColor, Border, BorderRadius, BorderSide, BoxDecoration, BoxFit, BuildContext, Button, Center, Checkbox, Colors, Column, Container, CrossAxisAlignment, DecorationImage, EdgeInsets, Expanded, FileImage, FocusManager, FocusScope, FocusScopeNode, FormState, GestureDetector, GlobalKey, Icon, InitControl, InkWell, InputDecoration, Key, MainAxisSize, Navigator, NetworkImage, OutlineInputBorder, Padding, Radius, Row, Scaffold, Select, SelectResult, SingleChildScrollView, SizedBox, StatefulWidget, Switch, Text, TextEditingController, TextFormField, TextInputType, TextStyle, Theme, TimeOfDay, Widget, Wrap, getImage, getMaxWidth, showDatePicker;
import 'package:benix/modules/admin/event/api/request_api.dart';
import 'package:benix/modules/admin/event/bloc/main_bloc.dart';
import 'package:benix/modules/admin/event/bloc/model.dart';
import 'package:benix/modules/admin/event/view/add_ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';

part 'part_online.dart';

class AddEventView extends StatefulWidget {
  final InputEventData? dataEdit;
  const AddEventView({Key? key, this.dataEdit}) : super(key: key);

  @override
  _AddEventViewState createState() => _AddEventViewState();
}

class _AddEventViewState extends BaseBackground<AddEventView> {
  String? imagePath, networkImagePath;
  bool isEdit = false;
  SelectResult format = SelectResult();
  SelectResult topik = SelectResult();
  bool isPrivate = false;
  bool isOnline = false;
  bool isOneEmail = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _tag = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _sk = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _tempat = TextEditingController();
  final TextEditingController _maxBuy = TextEditingController();
  final TextEditingController _orgName = TextEditingController();
  final TextEditingController _urlControl = TextEditingController();
  final List _listTag = [];
  DateTime awal = DateTime.now(), akhir = DateTime.now();
  DateTime _date = DateTime(2022, 5, 10, 22, 35);
  TimeOfDay tAwal = TimeOfDay.now(), tAkhir = TimeOfDay.now();
  TimeOfDay _time = TimeOfDay.now();
  final GlobalKey<FormState> _forms = GlobalKey<FormState>();

  _getImage() async {
    final getI = await getImage(context);
    if (getI != null) imagePath = getI;

    setState(() {});
  }

  _getResource() async {
    await getFormat(
        context: context,
        onSuccess: () {
          getTopik(
              context: context,
              onSuccess: () {
                getSettings(
                    context: context,
                    onSuccess: () {
                      if (widget.dataEdit != null) {
                        isEdit = true;
                        if (widget.dataEdit?.locationType == 'offline') {
                          _address.text = widget.dataEdit?.locationAddress ?? '';
                          isOnline = false;
                        } else {
                          _urlControl.text = widget.dataEdit?.locationAddress ?? '';
                          isOnline = true;
                        }

                        networkImagePath = widget.dataEdit?.banner;
                        _name.text = widget.dataEdit?.name ?? '';
                        _desc.text = widget.dataEdit?.description ?? '';
                        _city.text = widget.dataEdit?.locationCity ?? '';
                        _maxBuy.text = widget.dataEdit?.maxBuyTicket ?? '';
                        _orgName.text = widget.dataEdit?.organizerName ?? '';
                        _tempat.text = widget.dataEdit?.locationName ?? '';
                        _sk.text = widget.dataEdit?.sk ?? '';
                        _tag.text = widget.dataEdit?.tages ?? '';
                        awal = DateTime.parse(widget.dataEdit!.startDate!);
                        akhir = DateTime.parse(widget.dataEdit!.endDate!);
                        tAwal = TimeOfDay.fromDateTime(awal);
                        tAkhir = TimeOfDay.fromDateTime(akhir);
                        isOneEmail = widget.dataEdit?.uniqueEmailTransaction == '1' ? true : false;
                        isPrivate = widget.dataEdit?.type == 'public' ? false : true;

                        for (var i in widget.dataEdit?.tickets ?? []) {
                          BlocEventAdd.addTicket(
                            TicketData(
                              name: i['name'],
                              id: i['id'],
                              endDate: DateTime.parse(i['end_date']),
                              endTime: TimeOfDay.fromDateTime(DateTime.parse(i['end_date'])),
                              harga: int.tryParse(i['price'].replaceAll('.00', '')),
                              keterangan: i['description'],
                              qty: int.tryParse(i['remaining_stock']),
                              sertifikat: i['certificate_url'],
                              startDate: DateTime.parse(i['start_date']),
                              startTime: TimeOfDay.fromDateTime(DateTime.parse(i['start_date'])),
                            ),
                          );
                        }

                        for (var i in widget.dataEdit?.categories ?? []) {
                          if (i['categories']['type'] == 'topik') {
                            topik.name.text = i['categories']['name'];
                            topik.id = i['categories']['id'].toString();
                          } else if (i['categories']['type'] == 'format') {
                            format.name.text = i['categories']['name'];
                            format.id = i['categories']['id'].toString();
                          }
                        }

                        for (int i = 0; i < widget.dataEdit!.buyerDataSettings.length; i++) {
                          if (BlocEventAdd.checkboxSetting[i].id == widget.dataEdit!.buyerDataSettings[i]['buyer_data_settings']['id']) {
                            BlocEventAdd.checkboxSetting[i].checked = true;
                          }
                        }

                        // _listTag.add({
                        //   'name': '',
                        //   'id': '',
                        // });
                      }
                      setState(() {});
                    });
              });
        });
  }

  _parseTanggal(tanggal) {
    if (tanggal == null) {
      return '';
    }
    return DateFormat('d MMM y').format(tanggal);
  }

  _create() async {
    final banner = base64.encode(File(imagePath!).readAsBytesSync());
    final List tags = [];
    final List categories = [];
    final List tickets = [];
    final List settings = [];
    for (var i in _listTag) {
      tags.add({'id': i['id']});
    }
    categories.add({
      'id': topik.id,
      'type': 'topik',
    });
    categories.add({
      'id': format.id,
      'type': 'format',
    });

    for (CheckBoxSetting i in BlocEventAdd.checkboxSetting.where((element) => element.checked).toList()) {
      settings.add({
        'id': i.id,
      });
    }

    for (TicketData i in BlocEventAdd.listTicket) {
      tickets.add({
        'name': i.name,
        'type': i.harga == 0 ? 'gratis' : 'berbayar',
        'stock_in': i.qty,
        'price': i.harga,
        'start_date': DateFormat('y-MM-dd').format(i.startDate!) + ' ' + i.startTime!.format(context).replaceAll(' AM', '').replaceAll(' PM', '') + ':00',
        'end_date': DateFormat('y-MM-dd').format(i.endDate!) + ' ' + i.endTime!.format(context).replaceAll(' AM', '').replaceAll(' PM', '') + ':00',
        'certificate': i.sertifikat == null ? '' : base64Encode(File(i.sertifikat!).readAsBytesSync()),
        'description': i.keterangan,
      });
    }

    final status = await createEvent(
        context: context,
        data: InputEventData(
          banner: banner,
          description: _desc.text,
          endDate: DateFormat('y-MM-dd').format(akhir) + ' ' + tAkhir.format(context).replaceAll(' AM', '').replaceAll(' PM', '') + ':00',
          startDate: DateFormat('y-MM-dd').format(awal) + ' ' + tAwal.format(context).replaceAll(' AM', '').replaceAll(' PM', '') + ':00',
          locationAddress: isOnline ? _urlControl.text : _address.text,
          locationCity: _city.text,
          locationLat: '',
          locationLong: '',
          locationType: isOnline ? 'online' : 'offline',
          maxBuyTicket: _maxBuy.text,
          name: _name.text,
          organizerName: _orgName.text,
          type: isPrivate ? 'private' : 'public',
          uniqueEmailTransaction: isOneEmail ? '1' : '0',
          categories: categories,
          tags: tags,
          tages: _tag.text,
          tickets: tickets,
          sk: _sk.text,
          buyerDataSettings: settings,
          locationName: _tempat.text,
        ),
        onSuccess: () {
          Navigator.of(context).pop();
        });
  }

  _update() async {
    final banner = imagePath == null ? null : base64.encode(File(imagePath!).readAsBytesSync());
    final List tags = [];
    final List categories = [];
    final List tickets = [];
    final List settings = [];
    for (var i in _listTag) {
      tags.add({'id': i['id']});
    }
    categories.add({
      'id': topik.id,
      'type': 'topik',
    });
    categories.add({
      'id': format.id,
      'type': 'format',
    });

    for (CheckBoxSetting i in BlocEventAdd.checkboxSetting.where((element) => element.checked).toList()) {
      settings.add({
        'id': i.id,
      });
    }
    counter = 0;
    for (TicketData i in BlocEventAdd.listTicket) {
      ++counter;
      String? sertifikat;
      try {
        sertifikat = i.sertifikat == null ? '' : base64Encode(File(i.sertifikat!).readAsBytesSync());
      } catch (_) {
        sertifikat = null;
      }
      tickets.add({
        'id': i.id,
        'name': i.name,
        'type': i.harga == 0 ? 'gratis' : 'berbayar',
        'stock_in': i.qty,
        'price': i.harga,
        'start_date': DateFormat('y-MM-dd').format(i.startDate!) + ' ' + i.startTime!.format(context).replaceAll(' AM', '').replaceAll(' PM', '') + ':00',
        'end_date': DateFormat('y-MM-dd').format(i.endDate!) + ' ' + i.endTime!.format(context).replaceAll(' AM', '').replaceAll(' PM', '') + ':00',
        'description': i.keterangan,
      });

      if (sertifikat != null) {
        tickets[counter - 1].addAll({
          'certificate': sertifikat,
        });
      }
    }
    final status = await updateEvent(
        context: context,
        data: InputEventData(
          banner: banner,
          description: _desc.text,
          endDate: DateFormat('y-MM-dd').format(akhir) + ' ' + tAkhir.format(context).replaceAll(' AM', '').replaceAll(' PM', '') + ':00',
          startDate: DateFormat('y-MM-dd').format(awal) + ' ' + tAwal.format(context).replaceAll(' AM', '').replaceAll(' PM', '') + ':00',
          locationAddress: isOnline ? _urlControl.text : _address.text,
          locationCity: _city.text,
          locationLat: '',
          locationLong: '',
          locationType: isOnline ? 'online' : 'offline',
          maxBuyTicket: _maxBuy.text,
          name: _name.text,
          organizerName: _orgName.text,
          type: isPrivate ? 'private' : 'public',
          uniqueEmailTransaction: isOneEmail ? '1' : '0',
          categories: categories,
          tages: _tag.text,
          tags: tags,
          tickets: tickets,
          sk: _sk.text,
          buyerDataSettings: settings,
          locationName: _tempat.text,
          id: widget.dataEdit?.id,
        ),
        onSuccess: () {
          Navigator.of(context).pop();
        });
  }

  @override
  void initState() {
    super.initState();
    _getResource();
  }

  @override
  void dispose() {
    BlocEventAdd().clean();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        formKey: _forms,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await _getImage();
                  },
                  child: Container(
                    width: getMaxWidth,
                    height: 200,
                    child: imagePath == null ? (networkImagePath == null ? const Center(child: Text('Unggah Poster / Banner')) : const SizedBox()) : const SizedBox(),
                    decoration: BoxDecoration(
                      color: BaseColor.theme?.borderColor,
                      image: imagePath == null
                          ? (networkImagePath == null
                              ? null
                              : DecorationImage(
                                  image: NetworkImage(networkImagePath!),
                                  fit: BoxFit.cover,
                                ))
                          : DecorationImage(
                              image: FileImage(File(imagePath!)),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Data Yang Dibutuhkan',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: TextFormField(
                          // focusNode: myFocusNode,
                          controller: _orgName,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(
                                fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                color: Colors.grey),
                            labelText: 'Nama Organizer',
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                          validator: (data) {
                            if (data!.isEmpty) return 'Tidak Boleh Kosong!';
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: TextFormField(
                          // focusNode: myFocusNode,
                          controller: _name,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(
                              fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                              color: Colors.grey,
                            ),
                            labelText: 'Judul Acara',
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                          validator: (data) {
                            if (data!.isEmpty) return 'Tidak Boleh Kosong!';
                          },
                        ),
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TextFormField(
                            // focusNode: myFocusNode,
                            controller: format.name,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelStyle: const TextStyle(
                                  fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                  color: Colors.grey),
                              suffixIcon: const Icon(FeatherIcons.chevronDown),
                              labelText: 'Format',
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              fillColor: Colors.white,
                              focusColor: BaseColor.theme?.primaryColor,
                              enabled: false,
                              errorStyle: TextStyle(
                                color: Theme.of(context).errorColor,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                ),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                            validator: (data) {
                              if (data!.isEmpty) return 'Tidak Boleh Kosong!';
                            },
                          ),
                        ),
                        onTap: () async {
                          await Select.single(
                            title: 'Pilih Format',
                            context: context,
                            data: BlocEventAdd.listFormat,
                            selectedId: format.id,
                          ).then((value) {
                            if (value != null) {
                              format.name.text = value.title ?? '';
                              format.id = value.id;
                              setState(() {});
                            }
                          });
                        },
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TextFormField(
                            // focusNode: myFocusNode,
                            controller: topik.name,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelStyle: const TextStyle(
                                  fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                  color: Colors.grey),
                              suffixIcon: const Icon(FeatherIcons.chevronDown),
                              labelText: 'Topik',
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              fillColor: Colors.white,
                              focusColor: BaseColor.theme?.primaryColor,
                              enabled: false,
                              errorStyle: TextStyle(
                                color: Theme.of(context).errorColor,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                ),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                            validator: (data) {
                              if (data!.isEmpty) return 'Tidak Boleh Kosong!';
                            },
                          ),
                        ),
                        onTap: () async {
                          await Select.single(
                            title: 'Pilih Format',
                            context: context,
                            data: BlocEventAdd.listTopik,
                            selectedId: topik.id,
                          ).then((value) {
                            if (value != null) {
                              topik.name.text = value.title ?? '';
                              topik.id = value.id;
                              setState(() {});
                            }
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: TextFormField(
                          controller: _tag,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(
                                fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                color: Colors.grey),
                            labelText: 'Tag',
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                          onEditingComplete: () async {
                            final FocusScopeNode currentScope = FocusScope.of(context);
                            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                              FocusManager.instance.primaryFocus!.unfocus();
                            }
                            SystemChrome.restoreSystemUIOverlays();
                            if (_tag.text.isNotEmpty) {
                              await getTags(
                                  context: context,
                                  name: _tag.text,
                                  onSuccess: (getData) {
                                    if (getData.isNotEmpty) {
                                      _listTag.add({
                                        'name': getData[1],
                                        'id': getData[0],
                                      });
                                      _tag.text = '';
                                      setState(() {});
                                    } else {
                                      addTags(
                                          context: context,
                                          name: _tag.text,
                                          onSuccess: (addData) {
                                            if (addData.isNotEmpty) {
                                              _listTag.add({
                                                'name': addData[1],
                                                'id': addData[0],
                                              });
                                              _tag.text = '';
                                              setState(() {});
                                            }
                                          });
                                    }
                                  });
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Wrap(
                          runSpacing: 6,
                          children: _listTag
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                                      color: BaseColor.theme?.primaryColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: Text(
                                              e['name'],
                                              style: TextStyle(color: BaseColor.theme?.textButtonColor, fontSize: 11),
                                            ),
                                          ),
                                          InkWell(
                                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                                            child: Icon(
                                              FeatherIcons.x,
                                              color: BaseColor.theme?.textButtonColor,
                                              size: 16,
                                            ),
                                            onTap: () {
                                              _listTag.removeWhere((element) => element['id'] == e['id']);
                                              setState(() {});
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Jadwal',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: TextFormField(
                                  // focusNode: myFocusNode,
                                  controller: TextEditingController(text: _parseTanggal(awal)),
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelStyle: const TextStyle(
                                        fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                        color: Colors.grey),
                                    suffixIcon: const Icon(FeatherIcons.calendar),
                                    labelText: 'Mulai',
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                    fillColor: Colors.white,
                                    focusColor: BaseColor.theme?.primaryColor,
                                    enabled: false,
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                  validator: (data) {
                                    if (data!.isEmpty) return 'Tidak Boleh Kosong!';
                                  },
                                ),
                              ),
                              onTap: () async {
                                showDatePicker(
                                  context: context,
                                  initialDate: awal,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 3333),
                                  ),
                                ).then((value) {
                                  if (value != null) {
                                    int getRange = value.difference(akhir).inDays;
                                    if (getRange == 0) {
                                      if (akhir.day < value.day) {
                                        akhir = value;
                                      }
                                    } else if (getRange > 0) {
                                      akhir = value;
                                    }
                                    awal = value;
                                    setState(() {});
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: TextFormField(
                                  // focusNode: myFocusNode,
                                  controller: TextEditingController(text: _parseTanggal(akhir)),
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelStyle: const TextStyle(
                                        fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                        color: Colors.grey),
                                    suffixIcon: const Icon(FeatherIcons.calendar),
                                    labelText: 'Sampai',
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                    fillColor: Colors.white,
                                    focusColor: BaseColor.theme?.primaryColor,
                                    enabled: false,
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                  validator: (data) {
                                    if (data!.isEmpty) return 'Tidak Boleh Kosong!';
                                  },
                                ),
                              ),
                              onTap: () async {
                                showDatePicker(
                                  context: context,
                                  initialDate: akhir,
                                  firstDate: awal,
                                  lastDate: awal.add(
                                    const Duration(days: 3333),
                                  ),
                                ).then((value) {
                                  if (value != null) {
                                    akhir = value;
                                    setState(() {});
                                  }
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: TextFormField(
                                  // focusNode: myFocusNode,
                                  controller: TextEditingController(text: awal.hour.toString() + ':' + awal.minute.toString()),
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelStyle: const TextStyle(
                                        fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                        color: Colors.grey),
                                    suffixIcon: const Icon(FeatherIcons.clock),
                                    labelText: 'Mulai',
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                    fillColor: Colors.white,
                                    focusColor: BaseColor.theme?.primaryColor,
                                    enabled: false,
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                  validator: (data) {
                                    if (data!.isEmpty) return 'Tidak Boleh Kosong!';
                                  },
                                ),
                              ),
                              onTap: () async {
                                // showTimePicker(context: context, initialTime: tAwal).then((value) {
                                //   if (value != null) {
                                //     int current = ((value.hour * 60) + value.minute) * 60;
                                //     int end = ((tAwal.hour * 60) + tAwal.minute) * 60;
                                //     if (current > end) {
                                //       tAkhir = value;
                                //     }
                                //     tAwal = value;
                                //     setState(() {});
                                //   }
                                // });
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      return Container(
                                        height: 300,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                height: 200,
                                                child: CupertinoDatePicker(
                                                    initialDateTime: awal,
                                                    onDateTimeChanged: (value) {
                                                      if (value != null && value != awal) {
                                                        awal = value;
                                                        setState(() {});
                                                      }
                                                    },
                                                    mode: CupertinoDatePickerMode.time)),
                                            CupertinoButton(
                                              child: const Text('OK'),
                                              onPressed: () => Navigator.of(context).pop(),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: TextFormField(
                                    // focusNode: myFocusNode,
                                    controller: TextEditingController(text: akhir.hour.toString() + ':' + akhir.minute.toString()),
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      labelStyle: const TextStyle(
                                          fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                          color: Colors.grey),
                                      suffixIcon: const Icon(FeatherIcons.clock),
                                      labelText: 'Sampai',
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                      fillColor: Colors.white,
                                      focusColor: BaseColor.theme?.primaryColor,
                                      enabled: false,
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(color: Colors.black),
                                    validator: (data) {
                                      if (data!.isEmpty) return 'Tidak Boleh Kosong!';
                                    },
                                  ),
                                ),
                                onTap: () async {
                                  // showTimePicker(
                                  //         context: context, initialTime: tAkhir)
                                  //     .then((value) {
                                  //   if (value != null) {
                                  //     int current =
                                  //         ((value.hour * 60) + value.minute) * 60;
                                  //     int start =
                                  //         ((tAwal.hour * 60) + tAwal.minute) * 60;
                                  //     if (current < start) {
                                  //       tAwal = value;
                                  //     }
                                  //     tAkhir = value;
                                  //     setState(() {});
                                  //   }
                                  // });
                                  // },
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext builder) {
                                        return Container(
                                          height: 300,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 200,
                                                child: CupertinoDatePicker(
                                                  initialDateTime: akhir,
                                                  use24hFormat: true,
                                                  onDateTimeChanged: (value) {
                                                    if (value != null && value != akhir) {
                                                      akhir = value;
                                                      setState(() {});
                                                    }
                                                  },
                                                  mode: CupertinoDatePickerMode.time,
                                                ),
                                              ),
                                              CupertinoButton(
                                                child: const Text('OK'),
                                                onPressed: () => Navigator.of(context).pop(),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                }),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Lokasi',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Acara Online',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Apakah Acara Ini Termasuk Online?',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: BaseColor.theme?.captionColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Switch(
                                value: isOnline,
                                onChanged: (val) async {
                                  isOnline = val;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      isOnline ? onlineLocation(context, _urlControl) : offlineLocation(context, _address, _city, _tempat),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Tiket',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    BlocEventAdd.listTicket.isEmpty ? 'Tiket Belum Di Buat' : 'Tiket Yang Ditambahkan ${BlocEventAdd.listTicket.length}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Button.flat(
                                onTap: () {
                                  navigator(page: const AddTicket()).then((value) async {
                                    setState(() {});
                                  });
                                },
                                context: context,
                                title: 'Atur',
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    '1 akun email - 1 kali transaksi',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Switch(
                                value: isOneEmail,
                                onChanged: (val) async {
                                  isOneEmail = val;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: TextFormField(
                          // focusNode: myFocusNode,
                          controller: _maxBuy,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(
                                fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                color: Colors.grey),
                            labelText: 'Maksimal Tiket Per Transaksi',
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                          validator: (data) {
                            if (data!.isEmpty) {
                              return 'Tidak Boleh Kosong!';
                            }
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Deskripsi Event',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: TextFormField(
                          controller: _desc,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(
                                fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                color: Colors.grey),
                            labelText: 'Detail / Keterangan',
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          maxLines: 5,
                          style: const TextStyle(color: Colors.black),
                          validator: (data) {
                            if (data!.isEmpty) {
                              return 'Tidak Boleh Kosong!';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: TextFormField(
                          controller: _sk,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(
                                fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                color: Colors.grey),
                            labelText: 'Syarat & Ketentuan',
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          maxLines: 5,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Publik',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Acara Kamu Akan Tampil Di Halaman Cari Event',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: BaseColor.theme?.captionColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Switch(
                                  value: isPrivate,
                                  onChanged: (val) async {
                                    isPrivate = val;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Pengaturan User',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Column(
                        children: BlocEventAdd.checkboxSetting
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(e.name ?? ''),
                                    ),
                                    Checkbox(
                                      value: e.checked,
                                      onChanged: (data) {
                                        if (e.isLocked) {
                                          return;
                                        }
                                        e.checked = data!;
                                        setState(() {});
                                      },
                                    )
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Anda Mensetujui Syarat dan Ketentuan Jika Membuat Event Ini',
                            style: TextStyle(
                              fontSize: 12,
                              color: BaseColor.theme?.captionColor,
                            ),
                          ),
                        ),
                      ),
                      isEdit
                          ? Row(
                              children: [
                                Expanded(
                                  child: Button.flat(
                                    context: context,
                                    title: 'Ubah',
                                    onTap: () {
                                      _update();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Button.flat(
                                    context: context,
                                    title: 'Delete',
                                    color: Theme.of(context).errorColor,
                                    onTap: () async {
                                      await deleteEvent(
                                          context: context,
                                          id: widget.dataEdit!.id.toString(),
                                          onSuccess: () {
                                            Navigator.of(context).pop();
                                          });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Button.flat(
                              context: context,
                              title: 'BUAT ACARA',
                              onTap: () async {
                                if (_forms.currentState!.validate()) {
                                  await _create();
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
