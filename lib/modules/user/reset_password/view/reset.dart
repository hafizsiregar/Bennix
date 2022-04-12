import 'package:benix/main_route.dart';
import 'package:benix/modules/user/reset_password/api/request_api.dart';

import '../../../../main_library.dart' show BaseBackground, BaseColor, BorderRadius, BorderSide, BouncingScrollPhysics, BuildContext, Button, Center, Colors, Column, EdgeInsets, FormState, Forms, GlobalKey, Icon, Icons, Image, InitControl, Key, MainAxisAlignment, Material, MediaQuery, Navigator, Padding, Radius, Responsive, Row, Scaffold, SingleChildScrollView, SizedBox, StatefulWidget, Text, TextEditingController, TextStyle, Widget;

class ResetPasswordView2 extends StatefulWidget {
  final String email;
  const ResetPasswordView2({Key? key, required this.email}) : super(key: key);

  @override
  _ResetPasswordView2State createState() => _ResetPasswordView2State();
}

class _ResetPasswordView2State extends BaseBackground<ResetPasswordView2> {
  final TextEditingController _password = TextEditingController(), _passwordk = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _send() async {
    final status = await changePassword(
      context: context,
      email: widget.email,
      p2: _passwordk.text,
      p: _password.text,
    );

    if (status) {
      navigatorRemove(
        page: const LoginView(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InitControl(
      formKey: _formKey,
      doubleClick: true,
      child: Scaffold(
        backgroundColor: BaseColor.theme?.backgroundColor,
        body: Responsive(
          breakPoint: const [480],
          maxWidth: 480,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Masukkan Password Baru",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Forms.normal(
                      controller: _password,
                      context: context,
                      hintText: 'Password',
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
                    const SizedBox(
                      height: 20,
                    ),
                    Forms.normal(
                      controller: _passwordk,
                      context: context,
                      hintText: 'Konfirmasi Password',
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
                    const SizedBox(
                      height: 30,
                    ),
                    Button.flat(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) await _send();
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
                            'SEND',
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
