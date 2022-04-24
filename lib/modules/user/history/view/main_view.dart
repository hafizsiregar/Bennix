import 'package:benix/modules/user/history/api/request_api.dart';
import 'package:benix/modules/user/history/bloc/main_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../../main_library.dart' show AnimateTransition, BaseBackground, BaseColor, BorderRadius, BoxDecoration, BuildContext, CrossAxisAlignment, Column, Container, DecorationImage, EdgeInsets, Expanded, GestureDetector, Icon, Image, InitControl, IntrinsicHeight, Key, ListView, MainAxisAlignment, Material, NetworkImage, Padding, Radius, Responsive, Row, Scaffold, SizedBox, StatefulWidget, Text, TextStyle, Widget;
import 'package:intl/intl.dart';

import 'detail.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends BaseBackground<HistoryView> {
  _getData() async {
    await getHistory(context);
    setState(() {});
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
                        'Riwayat',
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
                      ? Column(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Image.asset('assets/images/history.png'),
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
                            ),
                          ],
                        )
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
                                            onTap: () {
                                              navigator(page: HistoryDetailView(idHistory: BlocHistoryEvent.listEvent[index].id));
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
                                                          BlocHistoryEvent.listEvent[index].isCheckin == '1' ?  'Hadir'  : BlocHistoryEvent.listEvent[index].isCheckin == '0' ? 'Belum Checkin': 'Tidak Hadir',
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
                                                                    : (BlocHistoryEvent.listEvent[index].event!.locationAddress ?? '')
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
