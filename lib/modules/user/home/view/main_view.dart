import 'package:benix/main_route.dart' show EventView;
import 'package:benix/modules/admin/event/bloc/main_bloc.dart';
import 'package:benix/modules/admin/event/bloc/model.dart';
import 'package:benix/modules/user/cource/dashboard/view/main_view.dart';
import 'package:benix/modules/user/cource/home/api/request_api.dart';
import 'package:benix/modules/user/cource/home/model/bloc.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:benix/modules/user/event/view/popular_event.dart';
import 'package:benix/modules/user/home/api/request_api.dart';
import 'package:benix/modules/user/home/bloc/model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main_library.dart' show Animation, AnimationController, AssetImage, Axis, BaseBackground, BaseColor, BorderRadius, BorderSide, BouncingScrollPhysics, BoxDecoration, BoxFit, BuildContext, Button, Center, Color, Colors, Column, Container, CrossAxisAlignment, DecorationImage, EdgeInsets, Expanded, FontWeight, Forms, GestureDetector, Icon, Icons, Image, InkWell, InputDecoration, IntrinsicHeight, Key, ListView, MainAxisAlignment, Material, MediaQuery, Navigator, NetworkImage, NeverScrollableScrollPhysics, OutlineInputBorder, Padding, Radius, Row, SingleChildScrollView, SizedBox, StatefulBuilder, StatefulWidget, Text, TextEditingController, TextFormField, TextStyle, Theme, Widget, bottom, currencyFormat, showDatePicker, showDialog, showModalBottomSheet;
import 'package:intl/intl.dart';

import '../../cource/home/view/detail.dart';
import '../../login/bloc/main_bloc.dart';
part 'part_card.dart';
part 'part_category.dart';
part 'part_nearby_card.dart';
part 'part_invite.dart';
part 'part_search.dart';
part 'part_edukasi.dart';

class HomeView extends StatefulWidget {
  final Animation? animatePosition;
  final AnimationController? animatePositionC;
  const HomeView({Key? key, this.animatePosition, this.animatePositionC}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends BaseBackground<HomeView> {
  int _counter = 0;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  List<Widget> banners = [];
  final TextEditingController _search = TextEditingController();

  void search() {
    int counters = 0;
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) => bottom(
        full: true,
        maxHeight: 0.95,
        context: context,
        child: StatefulBuilder(
          builder: (context, setState) => filterCard(
            counter: counters,
            context: context,
            onTap: () {
              // Navigator.of(context).pop();
              resultSearch('Hasil Pencarian');
            },
          ),
        ),
      ),
    );
  }

  void resultSearch(title) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) => bottom(
        full: true,
        maxHeight: 0.95,
        context: context,
        customChild: StatefulBuilder(
          builder: (context, setState) => Center(child: searchCard(context: context, navigator: navigator, title: title)),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      getBanner(context, onSuccess: (list) {
        banners = list;
        setState(() {});
      });
      newEvent(context, onSuccess: () {
        setState(() {});
      });
      popularEvent(context, onSuccess: () {
        setState(() {});
      });
      getEcource(context, onSuccess: () {
        setState(() {});
      });
      getEcourceClose(context, onSuccess: () {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _counter = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Halo' ' ' + (UserBloc.user.name ?? ''),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Temukan event favorit kamu',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 17),
              GestureDetector(
                onTap: () {
                  search();
                },
                child: Forms.normal(
                  boxShadow: const BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  context: context,
                  hintText: 'Cari Semua Acara...',
                  fillColor: Colors.white,
                  allColor: Colors.grey,
                  enabled: false,
                  prefixIcon: const Icon(
                    FeatherIcons.search,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CarouselSlider(
                  items: banners,
                  options: CarouselOptions(
                    height: 160,
                    viewportFraction: 0.95,
                    aspectRatio: 50 / 16,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    onPageChanged: (page, why) {},
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(height: 15),
                category(
                  counter: _counter,
                  context: context,
                  navigator: navigator,
                  state: setState,
                  onTap: (nama) {
                    resultSearch(nama);
                  },
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Acara Terpopuler',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PopularEvents()));
                        },
                        child: Text(
                          'Lihat Semua',
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: cardHome(navigator: navigator),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Video Edukasi',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardCourceView()));
                        },
                        child: Text(
                          'Lihat Semua',
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                //
                const SizedBox(height: 15),
                cardEdukasi(navigator: navigator, setState: setState),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Acara Terbaru",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: BlocEvent.listNewEvent.length,
                    itemBuilder: (context, index) {
                      final e = BlocEvent.listNewEvent[index];
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
                                  margin: const EdgeInsets.only(right: 16),
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
                                      const SizedBox(height: 3),
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
                                          const SizedBox(width: 5),
                                          Text(
                                            DateFormat('d MMM, HH:mm').format(e.startDate!) + '  -  ' + DateFormat('d MMM, HH:mm').format(e.endDate!),
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
                                const Icon(Icons.arrow_forward_ios_outlined, color: Color(0xff006EEE), size: 15),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      // ),
      // ),
    );
  }
}
