import 'dart:async';
import 'package:benix/main_route.dart' show DashboardView;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_api_helper/session.dart';
import 'package:uni_links/uni_links.dart';
import 'main_library.dart' show BaseBackground, BuildContext, Center, EdgeInsets, Image, Key, MediaQuery, Padding, Responsive, Scaffold, StatefulWidget, Text, Widget, setMaxWidth;
import 'modules/user/login/bloc/main_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends BaseBackground<Splash> {
  loadProfile() async {
    final isRemember = await Session.load('isRemember');
    // if (isRemember != null) {
    //   if (!isRemember) {
    //     await UserBloc.logout();
    //   } else {
        await UserBloc.load();
      // }
    // }
    Timer(const Duration(seconds: 2), () async {
      Uri? initialUri;
      String? id;
      try {
        initialUri = await getInitialUri();
        if (initialUri!.queryParameters['id'] != null) {
          id = initialUri.queryParameters['id'];
        }
      } catch (_) {}
      navigatorRemove(
        page: DashboardView(
          id: id,
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
    SystemChrome.restoreSystemUIOverlays();
  }

  @override
  Widget build(BuildContext context) {
    setMaxWidth(MediaQuery.of(context).size.width);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
                child: Image.asset(
                  'assets/images/bennix.png',
                ),
              ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text('Versi 1.0.1',
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
              ),),
            ),
          )
        ],
      ),
    );
  }
}
