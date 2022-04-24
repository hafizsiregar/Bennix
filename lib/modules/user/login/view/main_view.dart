import 'package:benix/main_route.dart' show DashboardView, RegisterView, ResetPasswordView;
import 'package:benix/modules/user/login/api/request_api.dart';
import 'package:flutter/material.dart';
import 'package:request_api_helper/session.dart';
import '../../../../main_library.dart' show AnimateTransition, BaseBackground, BaseColor, BorderRadius, BorderSide, BouncingScrollPhysics, BuildContext, Button, Center, Colors, Column, EdgeInsets, Expanded, Forms, GestureDetector, Icon, Icons, Image, InitControl, InkWell, Key, MainAxisAlignment, Material, Padding, Radius, Responsive, Row, Scaffold, SingleChildScrollView, SizedBox, StatefulWidget, Switch, Text, TextEditingController, TextStyle, Widget;
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '167338239348-3kqg088v6cu1ds19eejt443d7lflp5cq.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<void> handleSignIn(context, navigatorRemove) async {
  try {
    final GoogleSignInAccount? data = await _googleSignIn.signIn();
    if (data != null) {
      final bool status = await loginGoogle(context: context, email: data.email, member: data.displayName);
      if (status) navigatorRemove(page: const DashboardView());
    }
  } catch (error) {
    print(error);
  }
}

// final _googleSignIn = GoogleSignIn();
// Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends BaseBackground<LoginView> {
  final TextEditingController email = TextEditingController(), password = TextEditingController();
  bool isRemember = true;

  _login() async {
    final bool status = await login(
      context: context,
      email: email.text,
      password: password.text,
    );
    if (status) navigatorRemove(page: const DashboardView());
  }

  _loadRemember() async {
    isRemember = await Session.load('isRemember') ?? true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadRemember();
  }

  @override
  Widget build(BuildContext context) {

  //   Future handleSignIn() async {
  //   final user = await GoogleService.login();

  //   if(user == null) {
  //     ScaffoldMessenger.of(context)
  //     .showSnackBar(SnackBar(content: Text('Sign in Failed')));
  //   } else {
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => 
  //   DashboardView()));
  //   }
  // }

    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        child: Scaffold(
          backgroundColor: BaseColor.theme?.backgroundColor,
          body: Responsive(
            breakPoint: const [480],
            maxWidth: 480,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/bennix.png',
                      width: 250,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                            'Masuk Aplikasi',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Forms.normal(
                      controller: email,
                      context: context,
                      hintText: 'abc@gmail.com',
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      prefixIcon: Image.asset('assets/icons/Message.png'),
                      border: BorderSide(
                        width: 2,
                        color: BaseColor.theme?.borderColor ?? Colors.transparent,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Forms.normal(
                      controller: password,
                      context: context,
                      hintText: 'Your Password',
                      obsecureText: true,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      prefixIcon: SizedBox(
                        height: 20,
                        child: Image.asset('assets/icons/Lock.png'),
                      ),
                      border: BorderSide(
                        width: 2,
                        color: BaseColor.theme?.borderColor ?? Colors.transparent,
                      ),
                    ),
                    Row(
                      children: [
                        // Switch(
                        //   value: isRemember,
                        //   onChanged: (val) async {
                        //     isRemember = val;
                        //     setState(() {});
                        //     await Session.save('isRemember', isRemember);
                        //   },
                        // ),
                        const SizedBox(
                          width: 4,
                        ),
                        // const Text('Ingat Saya'),
                        const Expanded(child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.only(right: 20,top: 16),
                          child: InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                            onTap: () {
                              navigator(
                                page: const ResetPasswordView(),
                              );
                            },
                            child: const Text('Lupa Password?',style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Button.flat(
                        onTap: () async {
                          await _login();
                        },
                        context: context,
                        color: BaseColor.theme?.primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'MASUK',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Material(
                                color: Colors.black38,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'OR',
                      style: TextStyle(color: BaseColor.theme?.borderColor, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Button.flat(
                      context: context,
                      onTap: () async {
                        await handleSignIn(context, navigatorRemove);
                      },
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/g.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Masuk Dengan Akun Google',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Belum punya akun? ",
                        ),
                        GestureDetector(
                          onTap: () {
                            navigator(page: const RegisterView());
                          },
                          child: Text(
                            'Daftar',
                            style: TextStyle(color: BaseColor.theme?.linkActive),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
