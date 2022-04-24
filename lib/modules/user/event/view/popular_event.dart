import 'package:benix/modules/admin/event/bloc/main_bloc.dart';
import 'package:benix/modules/user/event/view/main_view.dart';
import 'package:benix/widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PopularEvents extends StatefulWidget {
  const PopularEvents({Key? key}) : super(key: key);

  @override
  State<PopularEvents> createState() => _PopularEventsState();
}

class _PopularEventsState extends BaseBackground<PopularEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Acara Terpopuler',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final e = BlocEvent.listEvent[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          BlocEvent.selectEvent(e.id);
                          navigator(page: const EventView());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 86,
                                height: 65,
                                margin: EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(e.banner!),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(e.name ?? '',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    SizedBox(height: 3),
                                    Text(
                                      e.organizerName ?? '',
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey[600],
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    // Spacer(),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.access_time_sharp,
                                          color: Colors.grey[600],
                                          size: 10,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          DateFormat('d MMM, HH:mm')
                                                  .format(e.startDate!) +
                                              '  -  ' +
                                              DateFormat('d MMM, HH:mm')
                                                  .format(e.endDate!),
                                          style: GoogleFonts.poppins(
                                            color: Colors.grey[600],
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_outlined,
                                  color: Color(0xff006EEE), size: 15),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
