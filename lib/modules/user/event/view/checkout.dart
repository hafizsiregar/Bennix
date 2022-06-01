import 'package:benix/main_library.dart' show AnimateTransition, BaseBackground, BaseColor, BorderRadius, BorderSide, BuildContext, Button, Color, Colors, Column, CrossAxisAlignment, EdgeInsets, Expanded, FormState, GestureDetector, GlobalKey, Icon, InitControl, InputDecoration, Key, ListView, MaterialState, MaterialStateProperty, OutlineInputBorder, Padding, Radio, Row, Scaffold, SizedBox, StatefulBuilder, StatefulWidget, Text, TextEditingController, TextFormField, TextStyle, Theme, Widget, showDatePicker;
import 'package:benix/modules/admin/event/api/request_api.dart';
import 'package:benix/modules/admin/event/bloc/main_bloc.dart';
// import 'package:benix/modules/admin/event/bloc/model.dart';
import 'package:benix/modules/user/event/api/request_api.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';

enum Gender { L, W }

class BuyTicket extends StatefulWidget {
  final int? buyQty, id, price;
  const BuyTicket({Key? key, this.buyQty, this.id, this.price}) : super(key: key);

  @override
  _BuyTicketState createState() => _BuyTicketState();
}

class _BuyTicketState extends BaseBackground<BuyTicket> {
  final GlobalKey<FormState> _forms = GlobalKey<FormState>();
  final List<Widget> _allForms = [];
  final List<Gender> _gender = [];
  final List<TextEditingController> _allNama = [];
  final List<TextEditingController> _allEmail = [];
  final List<TextEditingController> _allNumber = [];
  final List<TextEditingController> _ktp = [];
  final List<int> _settings = [];
  final List<DateTime> _lahir = [];
  bool isKtp = false, isLahir = false, isJenisKelamin = false;
  // EventData? _selectedEvent;

  _parseTanggal(tanggal) {
    if (tanggal == null) {
      return '';
    }
    return DateFormat('d MMM y').format(tanggal);
  }

  _getEvent() async {
    // List<EventData> _event = BlocEvent.listEvent.where((element) => element.id == BlocEvent.selectedEventId).toList();
    // for (EventData i in _event) {
    //   _selectedEvent = i;
    // }
    await detailEvent(
      context: context,
      id: BlocEvent.selectedEventId.toString(),
      onSuccess: (data) {
        _settings.clear();
        for (var i in data['data']['events_buyer_data_settings']) {
          int idSetting = i['buyer_data_settings']['id'];
          if (idSetting == 4) isKtp = true;
          if (idSetting == 5) isLahir = true;
          if (idSetting == 6) isJenisKelamin = true;
          _settings.add(idSetting);
        }

        buildForm();
        setState(() {});
      },
    );
  }

  _checkout() async {
    List listTicket = [];
    List listPrice = [];
    List listQty = [];
    List listSettings = [];
    List listData = [];

    for (int i = 0; i < widget.buyQty!; i++) {
      listTicket.add(widget.id);
      listPrice.add(widget.price);
      listQty.add(1);
      listSettings.add(_settings);
      List datas = [_allNama[i].text, _allEmail[i].text, _allNumber[i].text];
      if (isKtp) datas.add(_ktp[i].text);
      if (isLahir) datas.add(DateFormat('y-M-d').format(_lahir[i]));
      if (isJenisKelamin) datas.add(_gender[i] == Gender.L ? 'Laki - Laki' : 'Perempuan');
      listData.add(datas);
    }

    Map<String, dynamic> body = {
      'event_id': BlocEvent.selectedEventId,
      'list_ticket': listTicket,
      'list_price': listPrice,
      'list_qty': listQty,
      'list_buyer_data_setting': listSettings,
      'list_value_data': listData,
    };
    await checkout(context: context, data: body, navigator: navigator, onSuccess: (status) {});

    // if (req) Navigator.of(context).pop();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _getEvent();
    });
    super.initState();
  }

  void buildForm() {
    Color _getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return BaseColor.theme!.primaryColor!;
      }
      return BaseColor.theme!.primaryColor!;
    }

    _allForms.clear();
    for (int i = 0; i < widget.buyQty!; i++) {
      _allNama.add(TextEditingController());
      _allEmail.add(TextEditingController());
      _ktp.add(TextEditingController());
      _allNumber.add(TextEditingController());
      _lahir.add(DateTime(1990));
      _gender.add(Gender.L);
      if (i == 0) {
        _allNama[0].text = UserBloc.user.name ?? '';
        _allEmail[0].text = UserBloc.user.email ?? '';
        _allNumber[0].text = UserBloc.user.phone ?? '';
      }
      _allForms.add(
        StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'Ticket Profile ' + (i + 1).toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    // focusNode: myFocusNode,
                    controller: _allNama[i],
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelStyle: const TextStyle(
                          fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                          color: Colors.grey),
                      labelText: 'Nama Lengkap',
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
                    controller: _allEmail[i],
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelStyle: const TextStyle(
                          fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                          color: Colors.grey),
                      labelText: 'Email',
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
                    controller: _allNumber[i],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelStyle: const TextStyle(
                          fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                          color: Colors.grey),
                      labelText: 'Nomor Handphone',
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      fillColor: Colors.white,
                      prefix: const Text('+62 '),
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
                !isKtp
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: TextFormField(
                          // focusNode: myFocusNode,
                          controller: _ktp[i],
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(
                                fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                color: Colors.grey),
                            labelText: 'Nomor Identitas Diri',
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
                !isLahir
                    ? const SizedBox()
                    : GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TextFormField(
                            // focusNode: myFocusNode,
                            controller: TextEditingController(text: _parseTanggal(_lahir[i])),
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelStyle: const TextStyle(
                                  fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                                  color: Colors.grey),
                              suffixIcon: const Icon(FeatherIcons.calendar),
                              labelText: 'Tanggal Lahir',
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
                            initialDate: _lahir[i],
                            firstDate: DateTime(1990),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            if (value != null) {
                              _lahir[i] = value;
                              setState(() {});
                            }
                          });
                        },
                      ),
                !isJenisKelamin
                    ? const SizedBox()
                    : Row(
                        children: [
                          Row(
                            children: [
                              Radio<Gender>(
                                activeColor: BaseColor.theme?.primaryColor,
                                fillColor: MaterialStateProperty.resolveWith(_getColor),
                                value: Gender.L,
                                groupValue: _gender[i],
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _gender[i] = value!;
                                  });
                                },
                              ),
                              const Text('Pria')
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Radio<Gender>(
                                activeColor: Theme.of(context).textTheme.bodyText1!.color,
                                fillColor: MaterialStateProperty.resolveWith(_getColor),
                                value: Gender.W,
                                groupValue: _gender[i],
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _gender[i] = value!;
                                  });
                                },
                              ),
                              const Text('Wanita')
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          );
        }),
      );
    }
    setState(() {});
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
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _allForms.length,
                  itemBuilder: (context, index) {
                    return _allForms[index];
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
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
                    Button.flat(
                      context: context,
                      title: 'Pesan',
                      onTap: () async {
                        if (_forms.currentState!.validate()) {
                          _checkout();
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
