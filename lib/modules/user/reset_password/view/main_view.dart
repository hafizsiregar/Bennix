import 'package:benix/modules/user/reset_password/api/request_api.dart';
import 'package:benix/modules/user/reset_password/view/verification.dart';

import '../../../../main_library.dart' show BaseBackground, BaseColor, BorderRadius, BorderSide, BouncingScrollPhysics, BuildContext, Button, Center, Colors, Column, EdgeInsets, FormState, Forms, GlobalKey, Icon, Icons, Image, InitControl, Key, MainAxisAlignment, Material, MediaQuery, Navigator, Padding, Radius, Responsive, Row, Scaffold, SingleChildScrollView, SizedBox, StatefulWidget, Text, TextEditingController, TextStyle, Widget;

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends BaseBackground<ResetPasswordView> {
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _send() async {
    await sendMailReset(
      context: context,
      email: _email.text,
      onSuccess: (status) {
        navigator(
            page: VerificationView(
          email: _email.text,
        ));
      },
    );
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
                        "Silahkan masukan email anda untuk menerima konfirmasi permintaan lupa password",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Forms.normal(
                      context: context,
                      controller: _email,
                      hintText: 'abc@gmail.com',
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      prefixIcon: SizedBox(
                        height: 20,
                        child: Image.asset('assets/icons/Message.png'),
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
                            'KIRIM',
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
