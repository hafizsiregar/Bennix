import 'package:benix/main_library.dart'
    show
        AnimateTransition,
        BaseBackground,
        BaseColor,
        Border,
        BorderRadius,
        BorderSide,
        BoxDecoration,
        BoxShape,
        BuildContext,
        Button,
        Center,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        Expanded,
        FormState,
        GestureDetector,
        GlobalKey,
        Icon,
        InitControl,
        InkWell,
        InputDecoration,
        Key,
        MainAxisSize,
        Navigator,
        OutlineInputBorder,
        Padding,
        Positioned,
        Radius,
        Row,
        Scaffold,
        SingleChildScrollView,
        SizedBox,
        Stack,
        StatefulBuilder,
        StatefulWidget,
        Text,
        TextEditingController,
        TextFormField,
        TextInputType,
        TextStyle,
        Theme,
        TimeOfDay,
        Widget,
        bottom,
        currencyFormat,
        getImage,
        getMaxWidth,
        showDatePicker,
        showModalBottomSheet,
        showTimePicker;
import 'package:benix/modules/admin/event/bloc/main_bloc.dart';
import 'package:benix/modules/admin/event/bloc/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';

part 'part_ticket.dart';

int counter = 9999999999999;

class AddTicket extends StatefulWidget {
  const AddTicket({Key? key}) : super(key: key);

  @override
  _AddTicketState createState() => _AddTicketState();
}

class _AddTicketState extends BaseBackground<AddTicket> {
  final GlobalKey<FormState> _forms = GlobalKey<FormState>();

  _parseTanggal(tanggal) {
    if (tanggal == null) {
      return '';
    }
    return DateFormat('d MMM y').format(tanggal);
  }

  _showBottom(
      {bool isEdit = false,
      getharga,
      getqty,
      getname,
      getket,
      getid,
      getawal,
      getakhir,
      gettAwal,
      gettAkhir,
      getSertifikat}) async {
    TextEditingController harga = TextEditingController();
    TextEditingController qty = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController ket = TextEditingController();
    DateTime awal = DateTime.now(), akhir = DateTime.now();
    DateTime _date = DateTime(2022, 5, 10, 22, 35);
    TimeOfDay tAwal = TimeOfDay.now(), tAkhir = TimeOfDay.now();
    String? sertifikat;
    if (isEdit) {
      harga.text = getharga.toString();
      qty.text = getqty.toString();
      name.text = getname.toString();
      ket.text = getket.toString();
      awal = getawal;
      akhir = getakhir;
      tAkhir = gettAkhir;
      tAwal = gettAwal;
      sertifikat = getSertifikat;
    }

    await showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) => bottom(
        title: isEdit ? 'Ubah Ticket' : 'Tambah Ticket',
        full: true,
        maxHeight: 0.95,
        context: context,
        child: StatefulBuilder(
          builder: (context, setStates) => Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      // focusNode: myFocusNode,
                      controller: name,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelStyle: const TextStyle(
                            fontSize:
                                14.0, //I believe the size difference here is 6.0 to account padding
                            color: Colors.grey),
                        labelText: 'Nama Tiket',
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
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
                      controller: qty,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelStyle: const TextStyle(
                            fontSize:
                                14.0, //I believe the size difference here is 6.0 to account padding
                            color: Colors.grey),
                        labelText: 'Jumlah Tiket',
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
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
                      style: const TextStyle(color: Colors.black),
                      onChanged: (data) {
                        if (data.isNotEmpty) {
                          currencyFormat(data: data, controller: qty);
                          setState(() {});
                        }
                      },
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
                      // focusNode: myFocusNode,
                      controller: harga,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelStyle: const TextStyle(
                            fontSize:
                                14.0, //I believe the size difference here is 6.0 to account padding
                            color: Colors.grey),
                        labelText: 'Harga',
                        filled: true,
                        prefix: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text('Rp'),
                            ),
                          ],
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
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
                      style: const TextStyle(color: Colors.black),
                      onChanged: (data) {
                        if (data.isNotEmpty) {
                          currencyFormat(data: data, controller: harga);
                          setState(() {});
                        }
                      },
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'Tidak Boleh Kosong!';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final getI = await getImage(context);
                        if (getI != null) sertifikat = getI;

                        setState(() {});
                      },
                      child: TextFormField(
                        // focusNode: myFocusNode,
                        controller: TextEditingController(
                            text: sertifikat == null
                                ? ''
                                : sertifikat!.split(
                                    '/')[sertifikat!.split('/').length - 1]),
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelStyle: const TextStyle(
                              fontSize:
                                  14.0, //I believe the size difference here is 6.0 to account padding
                              color: Colors.grey),
                          labelText: 'Unggah Sertifikat',
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          fillColor: Colors.white,
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
                          enabled: false,
                        ),
                        style: const TextStyle(color: Colors.black),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                        "Sesuaikan ukuran dan tata letak pada sertifikat dengan contoh berikut: "),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.blue, // foreground
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: const Text('Contoh Sertifikat'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                        'assets/images/example_cert.png'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Dengan tinggi: 2480 dan Lebar 3500, untuk sisi tengah atas dengan ketinggian 1058 dan untuk ketinggian bawah 118",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                              ));
                    },
                    child: const Text('Lihat'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      // focusNode: myFocusNode,
                      controller: ket,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelStyle: const TextStyle(
                            fontSize:
                                14.0, //I believe the size difference here is 6.0 to account padding
                            color: Colors.grey),
                        labelText: 'Keterangan',
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
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
                      style: const TextStyle(color: Colors.black),
                      maxLines: 4,
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
                      'Tanggal Penjualan',
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
                              controller: TextEditingController(
                                  text: _parseTanggal(awal)),
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                labelStyle: const TextStyle(
                                    fontSize:
                                        14.0, //I believe the size difference here is 6.0 to account padding
                                    color: Colors.grey),
                                suffixIcon: const Icon(FeatherIcons.calendar),
                                labelText: 'Mulai',
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
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
                              controller: TextEditingController(
                                  text: _parseTanggal(akhir)),
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                labelStyle: const TextStyle(
                                    fontSize:
                                        14.0, //I believe the size difference here is 6.0 to account padding
                                    color: Colors.grey),
                                suffixIcon: const Icon(FeatherIcons.calendar),
                                labelText: 'Sampai',
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
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
                              controller: TextEditingController(
                                  text: tAwal.format(context)),
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                labelStyle: const TextStyle(
                                    fontSize:
                                        14.0, //I believe the size difference here is 6.0 to account padding
                                    color: Colors.grey),
                                suffixIcon: const Icon(FeatherIcons.clock),
                                labelText: 'Mulai',
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
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
                            showTimePicker(context: context, initialTime: tAwal).then((value) {
                                  if (value != null) {
                                    int current = ((value.hour * 60) + value.minute) * 60;
                                    int end = ((tAwal.hour * 60) + tAwal.minute) * 60;
                                    if (current > end) {
                                      tAkhir = value;
                                    }
                                    tAwal = value;
                                    setState(() {});
                                  }
                                });
                            // showModalBottomSheet(
                            //     context: context,
                            //     builder: (BuildContext builder) {
                            //       return Container(
                            //         height: 300,
                            //         child: Column(
                            //           children: [
                            //             SizedBox(
                            //               height: 200,
                            //               child: CupertinoDatePicker(
                            //                 initialDateTime: _date,
                            //                 onDateTimeChanged:
                            //                     (DateTime value) {
                            //                   setState(() {
                            //                     _date = value;
                            //                   });
                            //                 },
                            //                 use24hFormat: true,
                            //                 mode: CupertinoDatePickerMode.time,
                            //               ),
                            //             ),
                            //             CupertinoButton(
                            //               child: const Text('OK'),
                            //               onPressed: () =>
                            //                   Navigator.of(context).pop(),
                            //             )
                            //           ],
                            //         ),
                            //       );
                            //     });
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
                              controller: TextEditingController(
                                  text: tAkhir.format(context)),
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                labelStyle: const TextStyle(
                                    fontSize:
                                        14.0, //I believe the size difference here is 6.0 to account padding
                                    color: Colors.grey),
                                suffixIcon: const Icon(FeatherIcons.clock),
                                labelText: 'Sampai',
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
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
                            showTimePicker(
                              context: context,
                              initialTime: tAkhir,
                            ).then((value) {
                              if (value != null) {
                                int current =
                                    ((value.hour * 60) + value.minute) * 60;
                                int start =
                                    ((tAwal.hour * 60) + tAwal.minute) * 60;
                                if (current < start) {
                                  tAwal = value;
                                }
                                tAkhir = value;
                                setState(() {});
                              }
                            });
                            // showModalBottomSheet(
                            //     context: context,
                            //     builder: (BuildContext builder) {
                            //       return Container(
                            //         height: 300,
                            //         child: Column(
                            //           children: [
                            //             SizedBox(
                            //               height: 200,
                            //               child: CupertinoDatePicker(
                            //                 initialDateTime: _date,
                            //                 onDateTimeChanged:
                            //                     (DateTime value) {
                            //                   setState(() {
                            //                     _date = value;
                            //                   });
                            //                 },
                            //                 use24hFormat: true,
                            //                 mode: CupertinoDatePickerMode.time,
                            //               ),
                            //             ),
                            //             CupertinoButton(
                            //               child: const Text('OK'),
                            //               onPressed: () =>
                            //                   Navigator.of(context).pop(),
                            //             )
                            //           ],
                            //         ),
                            //       );
                            //     });
                          },
                        ),
                      )
                    ],
                  ),
                  isEdit
                      ? Row(
                          children: [
                            Expanded(
                              child: Button.flat(
                                context: context,
                                title: 'Ubah',
                                onTap: () {
                                  if (_forms.currentState!.validate()) {
                                    BlocEventAdd.editTicket(TicketData(
                                      endDate: akhir,
                                      endTime: tAkhir,
                                      harga: int.parse(
                                          harga.text.replaceAll(',', '')),
                                      id: getid,
                                      keterangan: ket.text,
                                      name: name.text,
                                      qty: int.parse(
                                          qty.text.replaceAll(',', '')),
                                      startDate: awal,
                                      startTime: tAwal,
                                      sertifikat: sertifikat,
                                    ));
                                    setState(() {});
                                    Navigator.of(context).pop();
                                  }
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
                                onTap: () {
                                  BlocEventAdd.deleteTicket(getid);
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        )
                      : Button.flat(
                          context: context,
                          title: 'Buat Tiket',
                          onTap: () {
                            if (_forms.currentState!.validate()) {
                              ++counter;
                              BlocEventAdd.addTicket(TicketData(
                                endDate: akhir,
                                endTime: tAkhir,
                                harga:
                                    int.parse(harga.text.replaceAll('.', '')),
                                id: counter,
                                keterangan: ket.text,
                                name: name.text,
                                qty: int.parse(qty.text.replaceAll('.', '')),
                                startDate: awal,
                                startTime: tAwal,
                                sertifikat: sertifikat,
                              ));
                              setState(() {});
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        formKey: _forms,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          onTap: () async {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            FeatherIcons.chevronLeft,
                          ),
                        ),
                      ),
                      const Text(
                        'Daftar Tiket',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocEventAdd.listTicket.isEmpty
                      ? const Center(
                          child: Text('Tidak Ada Data'),
                        )
                      : SingleChildScrollView(
                          child: Column(
                              children: BlocEventAdd.listTicket
                                  .map(
                                    (e) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          _showBottom(
                                            isEdit: true,
                                            getharga:
                                                NumberFormat.simpleCurrency(
                                                        name: '',
                                                        decimalDigits: 0)
                                                    .format(e.harga),
                                            getqty: NumberFormat.simpleCurrency(
                                                    name: '', decimalDigits: 0)
                                                .format(e.qty),
                                            getid: e.id,
                                            getket: e.keterangan,
                                            getname: e.name,
                                            getakhir: e.endDate,
                                            getawal: e.startDate,
                                            gettAkhir: e.endTime,
                                            gettAwal: e.startTime,
                                            getSertifikat: e.sertifikat,
                                          );
                                        },
                                        child: ticketWidget(
                                          deskripsi: e.keterangan,
                                          tanggal: DateFormat('d MMM y')
                                                  .format(e.endDate!) +
                                              ' | ' +
                                              e.endTime!.format(context),
                                          title: e.name,
                                          harga: e.harga == 0
                                              ? 'Gratis'
                                              : 'Rp. ' +
                                                  NumberFormat.simpleCurrency(
                                                          name: '',
                                                          decimalDigits: 0)
                                                      .format(e.harga),
                                          jumlah: NumberFormat.simpleCurrency(
                                                  name: '', decimalDigits: 0)
                                              .format(e.qty),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ),
                ),
                Button.flat(
                  context: context,
                  title: 'Buat Tiket',
                  onTap: () {
                    _showBottom();
                    if (_forms.currentState!.validate()) {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
