import 'package:benix/modules/admin/event/api/request_api.dart';
import 'package:benix/modules/admin/event/bloc/main_bloc.dart';
import 'package:benix/modules/admin/event/bloc/model.dart';
import 'package:benix/modules/user/event/view/buy_ticket.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import '../../../../main_library.dart'
    show
        Alignment,
        AnimateTransition,
        BaseBackground,
        BaseColor,
        Border,
        BorderRadius,
        BouncingScrollPhysics,
        BoxConstraints,
        BoxDecoration,
        BoxFit,
        BoxShape,
        BuildContext,
        Button,
        Center,
        Colors,
        Column,
        ConstrainedBox,
        Container,
        CrossAxisAlignment,
        DecorationImage,
        EdgeInsets,
        Expanded,
        FontWeight,
        Icon,
        Icons,
        Image,
        InitControl,
        InkWell,
        Key,
        LinearGradient,
        MainAxisAlignment,
        Material,
        Navigator,
        NetworkImage,
        Padding,
        Positioned,
        Radius,
        Responsive,
        Row,
        Scaffold,
        SingleChildScrollView,
        SizedBox,
        Stack,
        StatefulWidget,
        Text,
        TextStyle,
        TimeOfDay,
        Widget,
        getMaxWidth;

class EventView extends StatefulWidget {
  const EventView({Key? key}) : super(key: key);

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends BaseBackground<EventView> {
  EventData? _selectedEvent;
  final List<TicketData> _ticket = [];
  _getEvent() async {
    List<EventData> _event = BlocEvent.listEvent
        .where((element) => element.id == BlocEvent.selectedEventId)
        .toList();
    for (EventData i in _event) {
      _selectedEvent = i;
    }
    final Map data = await detailEvent(
      context: context,
      id: BlocEvent.selectedEventId.toString(),
    );

    for (var i in data != null ? data['data']['tickets'] : []) {
      final DateTime startDate = DateTime.parse(i['start_date']);
      final DateTime endDate = DateTime.parse(i['end_date']);
      _ticket.add(
        TicketData(
          id: i['id'],
          endDate: endDate,
          endTime: TimeOfDay.fromDateTime(endDate),
          startDate: startDate,
          startTime: TimeOfDay.fromDateTime(startDate),
          harga: double.parse(i['price']).floor(),
          keterangan: i['description'],
          name: i['name'],
          qty: double.parse(i['remaining_stock']).floor(),
        ),
      );
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getEvent();
  }

  @override
  void dispose() async {
    BlocEvent.selectEvent(null);
    super.dispose();
  }

  bool isBuyTicket = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 300,
                  maxHeight: 300,
                  maxWidth: getMaxWidth,
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      width: getMaxWidth,
                      height: 463,
                      decoration: BoxDecoration(
                        image: _selectedEvent?.banner == null
                            ? null
                            : DecorationImage(
                                image: NetworkImage(_selectedEvent!.banner!),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: getMaxWidth,
                      height: 463,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: BaseColor.theme?.primaryColor,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white
                                      ),
                                    )),
                                InkWell(
                                  onTap: () {
                                    Share.share(
                                        'Temukan acara ${_selectedEvent?.name} di aplikasi Bennix, Bennix menyediakan acara dan e-course terupdate serta dapatkan e-sertifikat diakun mu. Segera download aplikasi https://benix.id?id=${BlocEvent.selectedEventId}');
                                  },  
                                  child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: BaseColor.theme?.primaryColor,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Icon(
                                        Icons.ios_share_outlined,
                                        color: Colors.white
                                      ),
                                    )
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                          // width: getMaxWidth * 0.8,
                          height: 184,
                          child:
                              Image.asset('assets/images/background_dtl.png')),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: isBuyTicket
                        ? buyTicket(context, _ticket, navigator)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: _selectedEvent?.organizerImg == 'null' ? Container(height: 100,width: 100,
                                     color: Colors.blue,
                                    )  :Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: NetworkImage(
                                          _selectedEvent?.organizerImg ??
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm1N8tGE9JE-BAn4GgYgG6MHCngMqXZKpZYzAUaI8kaPywl-kM_-9Zk8OnNOhmdt1sBjQ&usqp=CAU',
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(_selectedEvent?.name ?? '',
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        Text(
                                          (_selectedEvent?.startDate == null
                                                  ? 'Undefined'
                                                  : DateFormat('d MMM HH:mm')
                                                      .format(_selectedEvent!
                                                          .startDate!)) +
                                              ' - ' +
                                              (_selectedEvent?.endDate == null
                                                  ? 'Undefined'
                                                  : DateFormat('d MMM HH:mm')
                                                      .format(_selectedEvent!
                                                          .endDate!)),
                                          style: GoogleFonts.poppins(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                        Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                image: _selectedEvent
                                                            ?.organizerImg ==
                                                        null
                                                    ? null
                                                    : DecorationImage(
                                                        image: NetworkImage(
                                                            _selectedEvent!
                                                                .organizerImg!),
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                _selectedEvent!.organizerName!,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                       const SizedBox(height: 10),
                                        Text(
                                            _selectedEvent!.sumPeserta! +
                                                ' ' +
                                                (_selectedEvent!.sumPeserta ==
                                                        100
                                                    ? 'Peserta'
                                                    : 'Peserta'),
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Tentang Acara',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                                
                              
                              const SizedBox(height: 17),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _selectedEvent?.description ?? '',
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: BaseColor.theme?.captionColor,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                               Divider(
                                color: Colors.grey[200],
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Syarat dan Ketentuan',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                               Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _selectedEvent?.sk ?? '-',
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: BaseColor.theme?.captionColor,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Button.flat(
                height: 53,
                onTap: () {
                  if (isBuyTicket) {
                    isBuyTicket = false;
                  } else {
                    isBuyTicket = true;
                  }
                  setState(() {});
                },
                context: context,
                color: BaseColor.theme?.primaryColor,
                child: Text(
                  isBuyTicket ? 'Detail Acara' : 'BELI TIKET',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
