import 'package:benix/modules/user/calendar/api/request_api.dart';
import 'package:benix/modules/user/history/bloc/main_bloc.dart';
import 'package:benix/modules/user/history/bloc/model.dart';
import 'package:benix/modules/user/history/view/detail.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main_library.dart' show AnimateTransition, BaseBackground, BaseColor, BorderRadius, BoxDecoration, BuildContext, Button, CrossAxisAlignment, Column, Container, DecorationImage, EdgeInsets, Expanded, GestureDetector, Icon, Image, InitControl, IntrinsicHeight, Key, ListView, MainAxisAlignment, MainAxisSize, Material, NetworkImage, Padding, Radius, Responsive, Row, Scaffold, SizedBox, StatefulWidget, Text, TextStyle, Widget;
import 'package:intl/intl.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends BaseBackground<CalendarView> {
  _getData() async {
    await getUpcomming(context, onSuccess: () {
      setState(() {});
    });
  }

  _updateHadir(id, ischeckin) async {
    await updateHadir(
        context: context,
        data: HistoryEvent(id: id, isCheckin: ischeckin.toString()),
        onSuccess: () {
          Navigator.of(context).pop();
        });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    BlocHistoryEvent().clean();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        child: Responsive(
          child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: const [
                      Text(
                        'Kalender',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // child: SingleChildScrollView(
                  //   physics: const BouncingScrollPhysics(),
                  child: BlocHistoryEvent.listEvent.isEmpty
                      ? Column(children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Image.asset('assets/images/calendar.png'),
                                ),
                                const Text(
                                  'Acara Kosong',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),
                          )
                        ])
                      : ListView.builder(
                          itemCount: BlocHistoryEvent.listEvent.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: GestureDetector(
                                onTap: () async {
                                  // Map getData = await detailEvent(
                                  //   context: context,
                                  //   id: BlocEvent.listEvent[index].id.toString(),
                                  // );
                                },
                                child: Material(
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                            image: DecorationImage(
                                              image: NetworkImage(BlocHistoryEvent.listEvent[index].event!.banner!),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: BlocHistoryEvent.listEvent[index].status != 'paid'
                                                ? null
                                                : BlocHistoryEvent.listEvent[index].isCheckin == '2'
                                                    ? null
                                                    : () async {
                                                        var startDate = BlocHistoryEvent.listEvent[index].event!.startDate!;
                                                        startDate = startDate.subtract(const Duration(minutes: 30));
                                                        DateTime now = DateTime.now();

                                                        if (now.difference(startDate).inMinutes < 0) {
                                                          showDialog(
                                                              context: context,
                                                              builder: (_) => const AlertDialog(
                                                                    title: Text('Peringatan !'),
                                                                    content: Text('Acara belum dimulai, klik 30 menit sebelum mulai'),
                                                                  ));
                                                        } else {
                                                          if (BlocHistoryEvent.listEvent[index].event!.locationType == 'online') {
                                                            if (await canLaunch(BlocHistoryEvent.listEvent[index].event!.locationAddress!)) {
                                                              launch(BlocHistoryEvent.listEvent[index].event!.locationAddress!, forceWebView: false, forceSafariVC: true);
                                                            } else {
                                                              launch(BlocHistoryEvent.listEvent[index].event!.locationAddress!);
                                                            }
                                                          }
                                                        }
                                                      },
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          DateFormat('d MMM y HH:mm:ss').format(BlocHistoryEvent.listEvent[index].event!.startDate!) + ' - ' + DateFormat('d MMM y HH:mm:ss').format(BlocHistoryEvent.listEvent[index].event!.endDate!),
                                                          style: TextStyle(
                                                            color: BaseColor.theme?.primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(BlocHistoryEvent.listEvent[index].event!.name ?? ''),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          BlocHistoryEvent.listEvent[index].event!.locationType == 'online' ? FeatherIcons.globe : FeatherIcons.mapPin,
                                                          size: 16,
                                                          color: BaseColor.theme?.captionColor,
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            BlocHistoryEvent.listEvent[index].event!.locationType == 'online'
                                                                ? BlocHistoryEvent.listEvent[index].status != 'paid'
                                                                    ? 'Pembayaran Belum Selesai'
                                                                    : ('online')
                                                                : (BlocHistoryEvent.listEvent[index].event!.locationName ?? '') + ',' + (BlocHistoryEvent.listEvent[index].event!.locationAddress ?? ''),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: BaseColor.theme?.captionColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text('Rp '),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          BlocHistoryEvent.listEvent[index].total == 0 ? 'Gratis' : NumberFormat.simpleCurrency(name: '', decimalDigits: 0).format(BlocHistoryEvent.listEvent[index].total),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: BaseColor.theme?.captionColor,
                                                          ),
                                                        ),
                                                      ),
                                                      BlocHistoryEvent.listEvent[index].event!.locationType == 'online'
                                                          ? BlocHistoryEvent.listEvent[index].isCheckin == '2'
                                                              ? Container(
                                                                  padding: const EdgeInsets.all(8),
                                                                  decoration: BoxDecoration(color: Colors.red[400]!, borderRadius: const BorderRadius.all(Radius.circular(20))),
                                                                  child: const Text(
                                                                    "Tidak Hadir",
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                )
                                                              : Button.flat(
                                                                  onTap: BlocHistoryEvent.listEvent[index].status != 'paid'
                                                                      ? () {
                                                                          navigator(page: HistoryDetailView(idHistory: BlocHistoryEvent.listEvent[index].id));
                                                                          // Fluttertoast.showToast(msg: 'Silahkan selesaikan pembayaran terlebih dahulu');
                                                                        }
                                                                      : () async {
                                                                          var startDate = BlocHistoryEvent.listEvent[index].event!.startDate!;
                                                                          startDate = startDate.subtract(const Duration(minutes: 30));
                                                                          DateTime now = DateTime.now();
                                                                          if (now.difference(startDate).inMinutes < 0) {
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (_) => const AlertDialog(
                                                                                      title: Text('Peringatan !'),
                                                                                      content: Text('Acara belum dimulai, klik 30 menit sebelum mulai'),
                                                                                    ));
                                                                          } else {
                                                                            if (BlocHistoryEvent.listEvent[index].isCheckin == '1') {
                                                                              if (await canLaunch(BlocHistoryEvent.listEvent[index].event!.locationAddress!)) {
                                                                                launch(BlocHistoryEvent.listEvent[index].event!.locationAddress!, forceWebView: false, forceSafariVC: true);
                                                                              } else {
                                                                                launch(BlocHistoryEvent.listEvent[index].event!.locationAddress!);
                                                                              }
                                                                            } else {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (_) => AlertDialog(
                                                                                        title: Text('Selamat Datang ${UserBloc.user.name}'),
                                                                                        content: Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              width: double.infinity,
                                                                                              child: ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  int? id = BlocHistoryEvent.listEvent[index].id;
                                                                                                  _updateHadir(id, 1);
                                                                                                },
                                                                                                child: const Text("Hadir"),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: double.infinity,
                                                                                              child: ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  int? id = BlocHistoryEvent.listEvent[index].id;
                                                                                                  _updateHadir(id, 2);
                                                                                                },
                                                                                                style: ElevatedButton.styleFrom(
                                                                                                  primary: Colors.red, // background
                                                                                                  onPrimary: Colors.white, // foreground
                                                                                                ),
                                                                                                child: const Text("Tidak Hadir"),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ));
                                                                            }
                                                                          }
                                                                        },
                                                                  context: context,
                                                                  title: 'Buka',
                                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                                )
                                                          : const SizedBox(),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                  // ),
                ),
              ],
            ),
          ),
          breakPoint: const [380],
        ),
      ),
    );
  }
}
