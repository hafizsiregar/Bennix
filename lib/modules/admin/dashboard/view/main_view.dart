import 'dart:io';

import 'package:benix/main_library.dart';
import 'package:benix/modules/admin/dashboard/bloc/main_bloc.dart';
import 'package:benix/modules/admin/event/api/request_api.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';

import '../../../../widget/downloader.dart';
import '../../event/bloc/main_bloc.dart';
import '../../event/bloc/model.dart';
import '../../event/view/add_event.dart';
import '../api/request_api.dart';

class DashboardAdmin extends StatefulWidget {
  final int id;
  const DashboardAdmin({Key? key, required this.id}) : super(key: key);

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends BaseBackground<DashboardAdmin> {
  bool _loading = false;

  checkingData(url) async {
    _loading = true;
    setState(() {});
    String dir = await getPlatformDir('');
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '$dir/export_${widget.id}';
    String myUrl = '';

    if (await File(filePath).exists()) {
      try {
        OpenFile.open(filePath);
      } catch (_) {
        File(filePath).delete();
        checkingData(url);
      }
    } else {
      try {
        myUrl = url;
        var request = await httpClient.getUrl(Uri.parse(myUrl));
        var response = await request.close();
        if (response.statusCode == 200) {
          var bytes = await consolidateHttpClientResponseBytes(response);
          file = File(filePath);
          await file.writeAsBytes(bytes);
          _loading = false;
          setState(() {});
          OpenFile.open(file.path);
        } else {
          filePath = 'Error code: ' + response.statusCode.toString();
        }
      } catch (ex) {
        filePath = 'Can not fetch url';
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getDataDashboard(widget.id, onSuccess: () {
      setState(() {});
    });
    getDetailPeserta(widget.id, onSuccess: () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return InitControl(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                child: Row(
                  children: [
                    InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                        width: 20,
                        child: Center(
                          child: Icon(Icons.chevron_left),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text('Dashboard'),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.all(Radius.circular(12)), boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.4),
                      offset: const Offset(1, 2),
                      blurRadius: 10,
                    )
                  ]),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(12))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Peserta Hadir',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  DashboardAdminBloc.data.pesertaHadir.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            // decoration: const BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(12))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Peserta Tidak Hadir',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  DashboardAdminBloc.data.pesertaTidakHadir.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('Event ini telah diikuti sebanyak ${DashboardAdminBloc.data.jumlahPeserta} Peserta dengan spesifikasi sebagai berikut'),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
                      child: Row(
                        children: [
                          Image.asset('assets/images/user.png'),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${DashboardAdminBloc.data.pesetaBerbayar} Peserta Berbayar'),
                              Text('${DashboardAdminBloc.data.pesertaTidakBayar} Peserta Tidak Berbayar'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Button.flat(
                          onTap: () async {
                            await detailEvent(
                              context: context,
                              id: BlocEvent.listEvent[widget.id].id.toString(),
                              onSuccess: (getData) async {
                                await navigator(
                                  page: AddEventView(
                                    dataEdit: InputEventData(
                                      banner: BlocEvent.listEvent[widget.id].banner!,
                                      description: BlocEvent.listEvent[widget.id].description!,
                                      endDate: BlocEvent.listEvent[widget.id].endDate!.toString(),
                                      locationAddress: BlocEvent.listEvent[widget.id].locationAddress!,
                                      locationCity: BlocEvent.listEvent[widget.id].locationCity,
                                      locationLat: BlocEvent.listEvent[widget.id].locationLat,
                                      locationLong: BlocEvent.listEvent[widget.id].locationLong,
                                      locationType: BlocEvent.listEvent[widget.id].locationType!,
                                      tages: BlocEvent.listEvent[widget.id].tages,
                                      maxBuyTicket: BlocEvent.listEvent[widget.id].maxBuyTicket.toString(),
                                      name: BlocEvent.listEvent[widget.id].name!,
                                      organizerImg: BlocEvent.listEvent[widget.id].organizerImg,
                                      organizerName: BlocEvent.listEvent[widget.id].organizerName!,
                                      startDate: BlocEvent.listEvent[widget.id].startDate.toString(),
                                      type: BlocEvent.listEvent[widget.id].type!,
                                      uniqueEmailTransaction: BlocEvent.listEvent[widget.id].uniqueEmailTransaction.toString(),
                                      id: BlocEvent.listEvent[widget.id].id,
                                      categories: getData['data']['events_categories'],
                                      tags: getData['data']['events_categories'],
                                      tickets: getData['data']['tickets'],
                                      sk: BlocEvent.listEvent[widget.id].sk,
                                      buyerDataSettings: getData['data']['events_buyer_data_settings'],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          context: context,
                          title: 'Edit Event',
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        Button.flat(
                          onTap: () async {
                            checkingData('https://admin.benix.id/api/events/${widget.id}/peserta?export=1');
                          },
                          context: context,
                          title: 'Export',
                          child: _loading ? const CircularProgressIndicator() : null,
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      'Daftar Peserta',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            SizedBox(
                              width: 50,
                              child: Center(
                                child: Text('id'),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Center(
                                child: Text('Nama'),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Center(
                                child: Text('Gambar'),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Center(
                                child: Text('Email'),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Center(
                                child: Text('No Hp'),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Center(
                                child: Text('Paket'),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Center(
                                child: Text('Periode'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 900,
                          child: Divider(),
                        ),
                        // content
                        for (int i = 0; i < 5; i++)
                          Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 50,
                                    child: Center(
                                      child: Text('1'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 200,
                                    child: Center(
                                      child: Text('Fabian Beliza'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Center(
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.black26,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 200,
                                    child: Center(
                                      child: Text('Fabian@mail.com'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 150,
                                    child: Center(
                                      child: Text('085234567678'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 100,
                                    child: Center(
                                      child: Text('Premium'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 100,
                                    child: Center(
                                      child: Text('20'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 900,
                                height: 10,
                                child: Center(
                                    child: Divider(
                                  height: 0,
                                )),
                              ),
                            ],
                          ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 50),
                          child: Row(
                            children: [
                              DashboardAdminBloc.data.table.page > 1 ? const Text('Previous') : const SizedBox(),
                              SizedBox(
                                width: DashboardAdminBloc.data.table.page > 1 ? 16 : 0,
                              ),
                              const Text('Page'),
                              const SizedBox(
                                width: 16,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Colors.black87),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: Center(
                                  child: Text(DashboardAdminBloc.data.table.page.toString()),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text('of ${DashboardAdminBloc.data.table.lastPage.toString()}'),
                              const SizedBox(
                                width: 16,
                              ),
                              DashboardAdminBloc.data.table.page < DashboardAdminBloc.data.table.lastPage ? const Text('Next') : const SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
