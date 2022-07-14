import 'dart:async';
import 'package:benix/main_route.dart';
import 'package:benix/modules/user/home/bloc/model.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_api_helper/request_api_helper.dart';
import 'package:benix/main_library.dart';
import 'package:request_api_helper/session.dart';

double? _maxWidth = 0;

get getMaxWidth => _maxWidth;

setMaxWidth(max) {
  _maxWidth = max;
}

@optionalTypeArgs
abstract class BaseBackground<T extends StatefulWidget> extends State<T> with TickerProviderStateMixin {
  AnimationController? transitionController;
  Animation<double>? animationTransition;
  List<Bloc>? bloc;

  Future<void> navigator({page}) async {
    transitionController!.forward();
    await Navigator.push(context, slideRight(page: page)).then((value) {
      transitionController!.reverse();
      setState(() {});
    });
  }

  navigatorRemove({page}) async {
    transitionController!.forward();
    Navigator.pushAndRemoveUntil(context, slideRight(page: page), (route) => false);
  }

  getSizeBottom() {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  @override
  void initState() {
    RequestApiHelper.initState();
    super.initState();
    transitionController = AnimationController(
      duration: const Duration(
        milliseconds: 600,
      ),
      vsync: this,
    );
    animationTransition = CurvedAnimation(
      parent: transitionController!,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    if (transitionController != null) transitionController!.dispose();
    super.dispose();
    if (bloc != null) {
      for (Bloc i in bloc!) {
        i.clean();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'This is Base Background v 0.0.1\nChange Your Widget',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

DateTime? currentNow;
Future<bool> _onWillPop() async {
  DateTime now = DateTime.now();
  if (currentNow == null) {
    currentNow = now;
    Fluttertoast.showToast(msg: 'Tekan Kembali Lagi Untuk Keluar');
    Timer(const Duration(seconds: 2), () {
      currentNow = null;
    });
  } else if (currentNow!.difference(now).inSeconds < 4) {
    currentNow = null;
    return true;
  } else {
    currentNow = now;
    Fluttertoast.showToast(msg: 'Tekan Kembali Lagi Untuk Keluar');
    Timer(const Duration(seconds: 3), () {
      currentNow = null;
    });
  }
  return false;
}

class InitControl extends StatelessWidget {
  final Widget? child;
  final bool? doubleClick;
  final bool? safeArea;
  final VoidCallback? onTapScreen;
  final GlobalKey<FormState>? formKey;

  const InitControl({
    Key? key,
    this.child,
    this.doubleClick,
    this.safeArea,
    this.onTapScreen,
    this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: doubleClick != null && doubleClick == true
          ? _onWillPop
          : () async {
              // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
              SystemChrome.restoreSystemUIOverlays();
              return true;
            },
      child: GestureDetector(
        onTap: () {
          final FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
          // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          SystemChrome.restoreSystemUIOverlays();
          if (onTapScreen != null) {
            onTapScreen!();
          }
        },
        child: Form(
          key: formKey,
          child: SafeArea(top: safeArea ?? false, bottom: safeArea ?? false, child: child!),
        ),
      ),
    );
  }
}

class Copy {
  static clipboard({String? value, String? showMessage}) {
    Clipboard.setData(ClipboardData(text: value));
    if (showMessage != null) {
      Fluttertoast.showToast(msg: showMessage);
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class DrawerBack extends StatelessWidget {
  final Widget child;
  final Function navigator, navigatorRemove;
  final double position;
  final AnimationController animationController;
  final List<DrawerMenu> dataMenu;
  const DrawerBack({Key? key, required this.child, required this.navigator, required this.navigatorRemove, required this.position, required this.animationController, required this.dataMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        SizedBox(
          width: getMaxWidth,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  onTap: () {
                    animationController.reverse();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: UserBloc.user.photoProfile == null ? null : DecorationImage(image: NetworkImage(UserBloc.user.photoProfile!), fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    UserBloc.user.name ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  children: dataMenu
                      .map(
                        (e) => InkWell(
                          onTap: () async {
                            animationController.reverse();
                            // if (e.title == 'My Profile') {
                            //   return BackDark(
                            //     barrierDismissible: true,
                            //     view: Redirects(
                            //       widget: profileWidget(context: context),
                            //     ),
                            //   ).dialog(context);
                            // }
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
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                                  child: Row(
                                    children: [
                                      Icon(
                                        e.icon,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        e.title ?? '',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: position,
          child: child,
        ),
      ],
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final Widget child;
  final BorderRadius? radius;
  const BackgroundImage({Key? key, required this.child, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.3,
            child: Container(
              child: const Center(),
              decoration: BoxDecoration(
                borderRadius: radius ?? const BorderRadius.all(Radius.zero),
                image: const DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  colorFilter: ColorFilter.mode(Colors.black12, BlendMode.multiply),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class Responsive extends StatelessWidget {
  final Widget child;

  /// width Break Point
  final List<int> breakPoint;
  final double? maxWidth;

  const Responsive({Key? key, required this.child, required this.breakPoint, this.maxWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool checkBreakPoint = true;
    // for (int i in breakPoint.reversed) {
    //   if (i >= getMaxWidth) {
    //     checkBreakPoint = false;
    //   }
    // }
    // if (checkBreakPoint) {
    //   return Center(
    //     child: ConstrainedBox(
    //       constraints: BoxConstraints(maxWidth: maxWidth ?? 480),
    //       child: child,
    //     ),
    //   );
    // } else {}
    return Center(
      child: child,
    );
  }
}
