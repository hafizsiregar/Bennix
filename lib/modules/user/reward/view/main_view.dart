import 'package:benix/modules/user/reward/view/widget_misi.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main_library.dart' show Animation, AnimationController, AssetImage, Axis, BaseBackground, BaseColor, BorderRadius, BorderSide, BouncingScrollPhysics, BoxDecoration, BoxFit, BuildContext, Button, Center, Color, Colors, Column, Container, CrossAxisAlignment, DecorationImage, EdgeInsets, Expanded, FontWeight, Forms, GestureDetector, Icon, Icons, Image, InkWell, InputDecoration, IntrinsicHeight, Key, ListView, MainAxisAlignment, Material, MediaQuery, Navigator, NetworkImage, NeverScrollableScrollPhysics, OutlineInputBorder, Padding, Radius, Row, SingleChildScrollView, SizedBox, StatefulBuilder, StatefulWidget, Text, TextEditingController, TextFormField, TextStyle, Theme, Widget, bottom, currencyFormat, showDatePicker, showDialog, showModalBottomSheet;
import 'item_reward.dart';

enum MenuActive { misi, merchandise }

class RewardView extends StatefulWidget {
  final Animation? animatePosition;
  final AnimationController? animatePositionC;
  const RewardView({Key? key, this.animatePosition, this.animatePositionC}) : super(key: key);

  @override
  _RewardViewState createState() => _RewardViewState();
}

class _RewardViewState extends BaseBackground<RewardView> {
  bool isDrawerOpen = false;
  MenuActive menuactive = MenuActive.misi;

  Widget _content() {
    if (menuactive == MenuActive.misi) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: progressMision(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: doneMission(),
          ),
          missionWithAction(),
        ],
      );
    } else if (menuactive == MenuActive.merchandise) {
      return itemReward();
    } else {
      return const SizedBox();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Rewards',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Poin Kamu',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '20.000',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Poin yang sudah ditukar',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '1.500',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Image.asset(
                      'assets/icons/gold.png',
                      width: 100,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    if (menuactive != MenuActive.misi) {
                      menuactive = MenuActive.misi;
                      setState(() {});
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Misi',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                        ),
                      ),
                      menuactive == MenuActive.misi
                          ? Container(
                              width: 30,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 4,
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    if (menuactive != MenuActive.merchandise) {
                      menuactive = MenuActive.merchandise;
                      setState(() {});
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Merchandise',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                        ),
                      ),
                      menuactive == MenuActive.merchandise
                          ? Container(
                              width: 30,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 4,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _content(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
