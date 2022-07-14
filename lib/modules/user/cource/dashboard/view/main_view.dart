import 'package:benix/main_route.dart' show CalendarView, HistoryView, LoginView;
import 'package:benix/modules/user/cource/home/api/request_api.dart';
import 'package:benix/modules/user/cource/home/model/static_data.dart';
import 'package:benix/modules/user/cource/home/view/main_view.dart';
import 'package:benix/modules/user/home/bloc/model.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:request_api_helper/session.dart';
import '../../../../../main_library.dart' show Alignment, AnimateTransition, Animation, AnimationController, BaseBackground, BaseColor, BorderRadius, BuildContext, Center, Color, Colors, Column, CurvedAnimation, Curves, DrawerBack, EdgeInsets, Expanded, Icon, Icons, InitControl, InkWell, Key, MainAxisAlignment, Material, MaterialType, MediaQuery, NeverScrollableScrollPhysics, Padding, PageController, PageView, Positioned, Radius, Responsive, Row, Scaffold, SizedBox, Stack, StatefulWidget, Text, TextStyle, Tween, Widget, getMaxWidth;
// import 'package:google_sign_in/google_sign_in.dart';

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   clientId: '167338239348-3kqg088v6cu1ds19eejt443d7lflp5cq.apps.googleusercontent.com',
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );
// Future<void> _handleSignOut() => _googleSignIn.disconnect();

class DashboardCourceView extends StatefulWidget {
  final int selectedPage;
  const DashboardCourceView({Key? key, this.selectedPage = 0}) : super(key: key);

  @override
  _DashboardCourceViewState createState() => _DashboardCourceViewState();
}

class _DashboardCourceViewState extends BaseBackground<DashboardCourceView> {
  Animation? animatePosition;
  AnimationController? animatePositionC;
  int _currenPage = 0;
  PageController control = PageController(initialPage: 0);
  List<DrawerMenu> _listDrawer = [];

  _getDataHome() async {
    if (widget.selectedPage == 0) {
      await getEcource(context, onSuccess: () {
        setState(() {});
      });
      // await getCategory(context: context);
    }
  }

  _initMenu() async {
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

  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        doubleClick: true,
        child: Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
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
                      children: [
                        Expanded(
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: control,
                            onPageChanged: (page) async {
                              _currenPage = page;
                              setState(() {});
                            },
                            children: [
                              CourceHomeViews(
                                animatePosition: animatePosition,
                                animatePositionC: animatePositionC,
                              ),
                              const CalendarView(),
                              const HistoryView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 100,
              //   right: 12,
              //   child: SizedBox(
              //     child: Material(
              //       color: BaseColor.theme?.primaryColor,
              //       borderRadius: const BorderRadius.all(Radius.circular(100)),
              //       child: InkWell(
              //         onTap: () {
              //           navigator(
              //             page: const AddVideoView(),
              //           );
              //         },
              //         borderRadius: const BorderRadius.all(Radius.circular(100)),
              //         child: Padding(
              //           padding: const EdgeInsets.all(12.0),
              //           child: Center(
              //             child: Icon(
              //               FeatherIcons.plusSquare,
              //               color: BaseColor.theme?.textButtonColor,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 12.0),
              //   child: SizedBox(
              //     height: 80,
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
              //       child: Material(
              //         elevation: 10,
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 8.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               Material(
              //                 color: _currenPage == 0 ? BaseColor.theme?.primaryColor : Colors.transparent,
              //                 type: MaterialType.circle,
              //                 child: InkWell(
              //                   focusColor: Colors.transparent,
              //                   highlightColor: Colors.transparent,
              //                   splashColor: Colors.transparent,
              //                   onTap: () {
              //                     if (_currenPage != 0) {
              //                       control.jumpToPage(0);
              //                     }
              //                   },
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Column(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children:  [
              //                         Padding(
              //                           padding: const EdgeInsets.only(bottom: 2.0),
              //                           child: Icon(
              //                             FeatherIcons.compass,
              //                             size: 20,
              //                             color:_currenPage == 0 ? Colors.white :Colors.black
              //                           ),
              //                         ),
              //                         Text(
              //                           'Beranda',
              //                           style: TextStyle(
              //                             color: _currenPage == 0 ? Colors.white :Colors.black
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               Material(
              //                 color: _currenPage == 1 ? BaseColor.theme?.primaryColor : Colors.transparent,
              //                 type: MaterialType.circle,
              //                 child: InkWell(
              //                   focusColor: Colors.transparent,
              //                   highlightColor: Colors.transparent,
              //                   splashColor: Colors.transparent,
              //                   onTap: () {
              //                     if (_currenPage != 1) {
              //                       control.jumpToPage(1);
              //                     }
              //                   },
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Column(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children:  [
              //                         Padding(
              //                           padding: const EdgeInsets.only(bottom: 2.0),
              //                           child: Icon(
              //                             FeatherIcons.calendar,
              //                             size: 20,
              //                             color:_currenPage == 1 ? Colors.white :Colors.black
              //                           ),
              //                         ),
              //                         Text(
              //                           'Kalender',
              //                           style: TextStyle(
              //                             color: _currenPage == 1 ? Colors.white :Colors.black
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               Material(
              //                 color: _currenPage == 2 ? BaseColor.theme?.primaryColor : Colors.transparent,
              //                 type: MaterialType.circle,
              //                 child: InkWell(
              //                   focusColor: Colors.transparent,
              //                   highlightColor: Colors.transparent,
              //                   splashColor: Colors.transparent,
              //                   onTap: () {
              //                     if (_currenPage != 2) {
              //                       control.jumpToPage(2);
              //                     }
              //                   },
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Column(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children:  [
              //                         Padding(
              //                           padding: const EdgeInsets.only(bottom: 2.0),
              //                           child: Icon(
              //                             FeatherIcons.clock,
              //                             size: 20,
              //                             color: _currenPage == 2 ? Colors.white :Colors.black,
              //                           ),
              //                         ),
              //                         Text(
              //                           'Riwayat',
              //                           style: TextStyle(
              //                             color:_currenPage == 2 ? Colors.white :Colors.black
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
