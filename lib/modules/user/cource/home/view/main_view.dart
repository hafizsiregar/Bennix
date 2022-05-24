import 'package:benix/main_route.dart' show EventView;
import 'package:benix/modules/admin/cource/model/main_bloc.dart';
import 'package:benix/modules/admin/cource/model/model.dart';
import 'package:benix/modules/admin/cource/view/main_view.dart';
import 'package:benix/modules/admin/event/bloc/main_bloc.dart';
import 'package:benix/modules/admin/event/bloc/model.dart';
import 'package:benix/modules/user/cource/home/api/request_api.dart';
import 'package:benix/modules/user/cource/home/model/bloc.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:benix/modules/user/cource/home/view/near_course.dart';
import 'package:benix/modules/user/cource/home/view/new_course.dart';
import 'package:benix/modules/user/home/api/request_api.dart';
import 'package:benix/modules/user/home/bloc/model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail.dart';

import '../../../../../main_library.dart' show Animation, AnimationController, AssetImage, Axis, BaseBackground, BaseColor, Border, BorderRadius, BorderSide, BouncingScrollPhysics, BoxConstraints, BoxDecoration, BoxFit, BoxShape, BuildContext, Button, Center, Color, Colors, Column, ConstrainedBox, Container, CrossAxisAlignment, CurvedAnimation, Curves, DecorationImage, EdgeInsets, Expanded, FontWeight, Forms, GestureDetector, Icon, Icons, Image, InkWell, InputDecoration, IntrinsicHeight, Key, ListView, MainAxisAlignment, MainAxisSize, Material, MaterialType, MediaQuery, Navigator, NetworkImage, OutlineInputBorder, Padding, Positioned, Radius, Responsive, Row, Scaffold, SingleChildScrollView, SizedBox, Stack, StatefulBuilder, StatefulWidget, Text, TextEditingController, TextFormField, TextStyle, Theme, Tween, Widget, bottom, currencyFormat, showDatePicker, showModalBottomSheet;
import 'package:intl/intl.dart';
part 'part_card.dart';
part 'part_category.dart';
part 'part_nearby_card.dart';
part 'part_invite.dart';
part 'part_search.dart';

class CourceHomeViews extends StatefulWidget {
  final Animation? animatePosition;
  final AnimationController? animatePositionC;
  const CourceHomeViews({Key? key, this.animatePosition, this.animatePositionC}) : super(key: key);

  @override
  _CourceHomeViewsState createState() => _CourceHomeViewsState();
}

class _CourceHomeViewsState extends BaseBackground<CourceHomeViews> {
  final TextEditingController _search = TextEditingController();
  List<Widget> banners = [];

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
      await getEcource(context, onSuccess: () {
        setState(() {});
      });
      await getEcourceClose(context, onSuccess: () {
        setState(() {});
      });
      await getBanner(context, onSuccess: (datas) {
        banners = datas;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // perubahan
      appBar: AppBar(
        title: Text('E-Cource',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              navigator(page: AddVideoView());
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 18,
          ),
        ),
      ),
      body: Material(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Forms.normal(
                      controller: _search,
                      context: context,
                      hintText: 'Cari E-Course',
                      fillColor: Colors.black.withOpacity(0.05),
                      border: const BorderSide(width: 0, color: Colors.transparent),
                      prefixIcon: const Icon(
                        FeatherIcons.search,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CarouselSlider(
                      items: banners,
                      options: CarouselOptions(
                        height: 200,
                        viewportFraction: 0.95,
                        aspectRatio: 50 / 16,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                        onPageChanged: (page, why) {},
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: category(
                        // counter: _counter,
                        context: context,
                        navigator: navigator,
                        state: setState,
                        onTap: (nama) {
                          resultSearch(nama);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "E-Course Terdekat",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NearCourse(
                                            list: CourceBloc.getList(),
                                          )));
                            },
                            child: Text(
                              'Lihat Semua',
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: cardHome(navigator: navigator, dataList: CourceBloc.getList(filter: _search.text), setState: setState),
                    ),
                    // cardNearby(context),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    // CarouselSlider(
                    //   items: banners,
                    //   options: CarouselOptions(
                    //     height: 170,
                    //     viewportFraction: 1,
                    //     initialPage: 0,
                    //     enableInfiniteScroll: false,
                    //     reverse: false,
                    //     autoPlay: true,
                    //     enlargeCenterPage: true,
                    //     onPageChanged: (page, why) {},
                    //     scrollDirection: Axis.horizontal,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "E-Course Terbaru",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewCourse(
                                            list: CourceBloc.getList(),
                                          )));
                            },
                            child: Text(
                              'Lihat Semua',
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: card2(navigator: navigator, dataList: CourceBloc.getList(filter: _search.text), setState: setState),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
