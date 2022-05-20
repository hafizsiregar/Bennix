import 'package:benix/main_route.dart' show CalendarView, EventView, HistoryView, HomeView, LoginView;
import 'package:benix/modules/admin/event/api/request_api.dart';
import 'package:benix/modules/admin/event/bloc/main_bloc.dart';
import 'package:benix/modules/user/home/bloc/model.dart';
import 'package:benix/modules/user/home/bloc/static_data.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_api_helper/session.dart';
import '../../../../main_library.dart' show AnimateTransition, Animation, AnimationController, BackgroundImage, BaseBackground, BuildContext, Colors, Column, CurvedAnimation, Curves, DrawerBack, EdgeInsets, Expanded, Icon, Icons, InitControl, InkWell, Key, MainAxisAlignment, Material, MediaQuery, NeverScrollableScrollPhysics, Padding, PageController, PageView, Row, Scaffold, SizedBox, Stack, StatefulWidget, Text, TextStyle, Tween, Widget, getMaxWidth;

class DashboardView extends StatefulWidget {
  final int selectedPage;
  final String? id;
  const DashboardView({Key? key, this.selectedPage = 0, this.id}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends BaseBackground<DashboardView> {
  Animation? animatePosition;
  AnimationController? animatePositionC;
  int _currenPage = 0;
  PageController control = PageController(initialPage: 0);
  List<DrawerMenu> _listDrawer = [];

  _getDataHome() async {
    if (widget.selectedPage == 0) {
      await getCategory(
          context: context,
          onSuccess: () {
            if (widget.id != null) {
              BlocEvent.selectEvent(int.parse(widget.id!));
              navigator(page: const EventView());
            }
          });
    }
    setState(() {});
  }

  _initMenu() async {
    _currenPage = widget.selectedPage;
    _listDrawer = listDrawer;
    final getToken = await Session.load('token');
    if (getToken != null) {
      _listDrawer.removeLast();
      _listDrawer.add(DrawerMenu(
        title: 'Keluar',
        icon: Icons.logout,
        customFunction: () async {
          // _handleSignOut();
          await UserBloc.logout();
          navigatorRemove(page: const LoginView());
        },
      ));
    }
  }

  @override
  void initState() {
    control = PageController(initialPage: widget.selectedPage);
    _getDataHome();
    _initMenu();
    super.initState();
    animatePositionC = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    Future.delayed(Duration.zero, () {
      animatePosition = Tween(begin: 0.0, end: getMaxWidth * 0.7).animate(CurvedAnimation(parent: animatePositionC!, curve: Curves.easeInOut)
        ..addListener(() {
          setState(() {});
        }));
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        doubleClick: true,
        child: BackgroundImage(
          child: Scaffold(
            key: _key,
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: Material(
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: UserBloc.user.photoProfile == null ? null : NetworkImage(UserBloc.user.photoProfile!),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                UserBloc.user.name == null ? '' : UserBloc.user.name!,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                UserBloc.user.email == null ? '' : UserBloc.user.email!,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Divider(thickness: 0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: _listDrawer.map((e) {
                          return InkWell(
                            onTap: () async {
                              if (e.needLogin != null) {
                                final loadToken = await Session.load('token');
                                if (loadToken == null) {
                                  navigator(page: const LoginView());
                                  return;
                                }
                              }
                              if (e.locked != null) {
                                if (e.locked!) return;
                              }
                              if (e.isRemoved == true) {
                                if (e.navigate != null) {
                                  navigatorRemove(page: e.navigate);
                                }
                              } else {
                                if (e.navigate != null) {
                                  navigator(page: e.navigate);
                                }
                              }

                              if (e.customFunction != null) {
                                e.customFunction!();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: <Widget>[
                                  Icon(e.icon),
                                  SizedBox(width: 15),
                                  Text(
                                    e.title!,
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: Stack(children: [
              DrawerBack(
                animationController: animatePositionC ?? AnimationController(vsync: this),
                position: animatePosition == null ? 0 : animatePosition!.value,
                navigator: navigator,
                navigatorRemove: navigatorRemove,
                dataMenu: _listDrawer,
                child: SizedBox(
                  width: getMaxWidth,
                  height: MediaQuery.of(context).size.height,
                  child: Material(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: InkWell(
                                onTap: () {
                                  _key.currentState!.openDrawer();
                                },
                                child: Image.asset(
                                  'assets/icons/drawer.png',
                                  width: 18,
                                  height: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, right: 20),
                              child: Image.asset(
                                'assets/images/bennix.png',
                                width: 120,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 22),
                        Expanded(
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: control,
                            onPageChanged: (page) async {
                              _currenPage = page;
                              setState(() {});
                            },
                            children: [
                              HomeView(
                                animatePosition: animatePosition,
                                animatePositionC: animatePositionC,
                              ),
                              const CalendarView(),
                              const HistoryView(),
                            ],
                          ),
                        ),
                        BottomNavigationBar(
                            currentIndex: _currenPage,
                            selectedItemColor: Colors.blue,
                            unselectedItemColor: Colors.grey,
                            showUnselectedLabels: true,
                            onTap: (index) {
                              control.jumpToPage(index);
                            },
                            items: const [
                              BottomNavigationBarItem(
                                icon: Icon(Icons.home),
                                label: 'Home',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.calendar_today),
                                label: 'Calendar',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.history),
                                label: 'History',
                              ),
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
