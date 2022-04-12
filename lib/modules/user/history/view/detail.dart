import 'package:benix/modules/user/history/api/request_api.dart';
import 'package:benix/modules/user/history/bloc/main_bloc.dart';
import 'package:request_api_helper/request_api_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../main_library.dart' show AnimateTransition, BaseBackground, BaseColor, Border, BouncingScrollPhysics, BoxDecoration, BuildContext, Button, Center, Colors, Column, Container, CrossAxisAlignment, DecorationImage, Divider, EdgeInsets, Expanded, GestureDetector, Icon, Image, InitControl, IntrinsicHeight, Key, ListView, MainAxisAlignment, Material, NetworkImage, NeverScrollableScrollPhysics, Padding, Radius, Responsive, Row, Scaffold, SingleChildScrollView, SizedBox, StatefulWidget, Text, TextAlign, TextStyle, Widget;

class HistoryDetailView extends StatefulWidget {
  final int? idHistory;
  const HistoryDetailView({Key? key, this.idHistory}) : super(key: key);

  @override
  _HistoryDetailViewState createState() => _HistoryDetailViewState();
}

class _HistoryDetailViewState extends BaseBackground<HistoryDetailView> {
  _getData() async {
    await getHistoryDetail(context, widget.idHistory);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getData();
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
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: const [
                    Text(
                      'Detail',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24, bottom: 12.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: BaseColor.theme!.successColor!,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'INVOICE',
                            style: TextStyle(
                              color: BaseColor.theme?.successColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text('Nama Pembeli'),
                                  ),
                                  Expanded(
                                    child: Text(': ${DetailHistoryBloc.data.buyerName}'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text('Email'),
                                  ),
                                  Expanded(
                                    child: Text(': ${DetailHistoryBloc.data.buyerEmail}'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text('Nomor HP'),
                                  ),
                                  Expanded(
                                    child: Text(': ${DetailHistoryBloc.data.buyerPhone}'),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text('Nama Event'),
                                  ),
                                  Expanded(
                                    child: Text(': ${DetailHistoryBloc.data.eventName}'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text('Jadwal'),
                                  ),
                                  Expanded(
                                    child: Text(': ${DetailHistoryBloc.data.eventdate}'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text('Lokasi'),
                                  ),
                                  Expanded(
                                    child: Text(': ${DetailHistoryBloc.data.status != 'paid' ? 'Alamat Belum Tersedia' :DetailHistoryBloc.data.eventPlace}'),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text('Kode Invoice'),
                                  ),
                                  Expanded(
                                    child: Text(': ${DetailHistoryBloc.data.orderNumber}'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text('Tanggal Invoice'),
                                  ),
                                  Expanded(
                                    child: Text(': ${DetailHistoryBloc.data.invoicedate}'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text('Metode Pembayaran'),
                                  ),
                                  Expanded(
                                    child: Text(': ${DetailHistoryBloc.data.paymentMethod}'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text('Status invoice'),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(': '),
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          color: DetailHistoryBloc.data.status == 'waiting'
                                              ? Colors.yellow
                                              : DetailHistoryBloc.data.status == 'paid'
                                                  ? BaseColor.theme?.successColor
                                                  : BaseColor.theme?.warningColor,
                                          child: Text(
                                            DetailHistoryBloc.data.status == 'waiting'
                                                ? 'Menunggu Pembayaran'
                                                : DetailHistoryBloc.data.status == 'paid'
                                                    ? 'Terbayar'
                                                    : 'Dibatalkan',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(
                              height: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                    flex: 30,
                                    child: Center(
                                      child: Text(
                                        'Nama Tiket',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 30,
                                    child: Center(
                                      child: Text(
                                        'Harga',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 20,
                                    child: Center(
                                      child: Text(
                                        'Jumlah',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 30,
                                    child: Center(
                                      child: Text(
                                        'Total',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 0,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: DetailHistoryBloc.data.detailTicket!.length,
                              itemBuilder: (context, index) {
                                var dataTicket = DetailHistoryBloc.data.detailTicket![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 30,
                                        child: Text(
                                          dataTicket.ticketName ?? '',
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        flex: 30,
                                        child: Text(
                                          dataTicket.price.toString(),
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        flex: 20,
                                        child: Text(
                                          dataTicket.qty.toString(),
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        flex: 30,
                                        child: Text(
                                          dataTicket.subTotal.toString(),
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const Divider(
                              height: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Total'),
                                  Text(DetailHistoryBloc.data.total.toString()),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 0,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Sertifikat',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: DetailHistoryBloc.data.detailTicket!.length,
                              itemBuilder: (context, index) {
                                var dataTicket = DetailHistoryBloc.data.detailTicket![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 30,
                                        child: Text(
                                          dataTicket.ticketName ?? '-',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Button.flat(
                                        onTap: DetailHistoryBloc.data.status != 'paid' ? null : () async {
                                          if (DateTime.parse(DetailHistoryBloc.data.eventdate!).difference(DateTime.now()).inMinutes < -30) {
                                            launch('https://admin.benix.id/api/certificate-download/${dataTicket.nameEncrypt}/${dataTicket.fileName}',);
                                          } else {
                                            Fluttertoast.showToast(msg: 'Sertifikat bisa di akses setelah 30 menit event dimulai');
                                          }
                                        },
                                        context: context,
                                        title: 'Download',
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
