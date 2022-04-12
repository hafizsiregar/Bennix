import 'package:benix/modules/user/register/api/request_api.dart';
import 'package:benix/modules/user/register/bloc/model.dart';

import '../../../../main_library.dart' show BaseBackground, BaseColor, BorderRadius, BorderSide, BouncingScrollPhysics, BuildContext, Button, Center, Colors, Column, EdgeInsets, FormState, Forms, GestureDetector, GlobalKey, Icon, Icons, Image, InitControl, Key, MainAxisAlignment, Material, Navigator, Padding, Radius, Responsive, Row, Scaffold, SingleChildScrollView, SizedBox, StatefulWidget, Text, TextEditingController, TextStyle, Widget;

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends BaseBackground<RegisterView> {
  final TextEditingController name = TextEditingController(), password = TextEditingController(), email = TextEditingController(), confirm = TextEditingController();
  bool isRemember = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  _register() async {
    final bool status = await register(
      context: context,
      data: InputRegister(confirmPassword: confirm.text, email: email.text, name: name.text, password: password.text),
    );

    if (status) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return InitControl(
      formKey: _form,
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
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Forms.normal(
                    controller: name,
                    context: context,
                    hintText: 'Nama Lengkap',
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    prefixIcon: Image.asset('assets/icons/Profile.png'),
                    border: BorderSide(
                      width: 2,
                      color: BaseColor.theme?.borderColor ?? Colors.transparent,
                    ),
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Wajib!';
                      }
                    },
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
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Wajib!';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Forms.normal(
                    controller: password,
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
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Wajib!';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Forms.normal(
                    controller: confirm,
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
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Wajib!';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Button.flat(
                    onTap: () async {
                      if (_form.currentState?.validate() != null) {
                        await _register();
                      }
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
                          'DAFTAR',
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
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // Text(
                  //   'OR',
                  //   style: TextStyle(color: BaseColor.theme?.borderColor, fontSize: 16),
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // Button.flat(
                  //   context: context,
                  //   color: Colors.transparent,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Image.asset('assets/icons/g.png'),
                  //       const SizedBox(
                  //         width: 10,
                  //       ),
                  //       const Text(
                  //         'Login With Google',
                  //         style: TextStyle(fontSize: 14),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sudah punya akun? ",
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Masuk',
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
    );
  }
}
