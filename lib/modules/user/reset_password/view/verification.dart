import 'package:benix/modules/user/reset_password/api/request_api.dart';
import 'package:benix/modules/user/reset_password/view/reset.dart';
import 'package:request_api_helper/request_api_helper.dart';

import '../../../../main_library.dart' show BaseBackground, BaseColor, BorderRadius, BorderSide, BouncingScrollPhysics, BuildContext, Button, Center, Colors, Column, EdgeInsets, Expanded, FocusNode, FocusScope, Forms, GestureDetector, Icon, Icons, InitControl, Key, MainAxisAlignment, Material, MediaQuery, Navigator, Padding, Radius, Responsive, Row, Scaffold, SingleChildScrollView, SizedBox, StatefulWidget, Text, TextAlign, TextEditingController, TextInputType, TextStyle, Widget;

class VerificationView extends StatefulWidget {
  final String email;
  const VerificationView({Key? key, required this.email}) : super(key: key);

  @override
  _VerificationViewState createState() => _VerificationViewState();
}

class _VerificationViewState extends BaseBackground<VerificationView> {
  List<TextEditingController> otpC = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()];
  List<FocusNode> otpNode = [FocusNode(), FocusNode(), FocusNode(), FocusNode(), FocusNode(), FocusNode()];
  String value = '';
  bool isRemember = false;

  check() async {
    await checkOtp(
        context: context,
        email: widget.email,
        otp: value,
        onSuccess: () {
          navigator(
              page: ResetPasswordView2(
            email: widget.email,
          ));
        });

    return;
  }

  @override
  Widget build(BuildContext context) {
    return InitControl(
      doubleClick: true,
      child: Scaffold(
        backgroundColor: BaseColor.theme?.backgroundColor,
        body: SizedBox(
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
                      'Masukkan OTP',
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
                      "Email Telah Dikirim",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Forms.normal(
                                  controller: otpC[0],
                                  context: context,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  focusNode: otpNode[0],
                                  keyboardType: TextInputType.number,
                                  counterText: '',
                                  border: BorderSide(
                                    width: 2,
                                    color: BaseColor.theme?.borderColor ?? Colors.transparent,
                                  ),
                                  onChanged: (data) {
                                    value = '';
                                    for (TextEditingController i in otpC) {
                                      if (i.text.isNotEmpty) {
                                        value += i.text;
                                      }
                                    }
                                    if (data.isNotEmpty) {
                                      FocusScope.of(context).requestFocus(otpNode[1]);
                                    } else if (data.isEmpty) {}
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Forms.normal(
                                  controller: otpC[1],
                                  context: context,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  focusNode: otpNode[1],
                                  keyboardType: TextInputType.number,
                                  counterText: '',
                                  border: BorderSide(
                                    width: 2,
                                    color: BaseColor.theme?.borderColor ?? Colors.transparent,
                                  ),
                                  onChanged: (data) {
                                    value = '';
                                    for (TextEditingController i in otpC) {
                                      if (i.text.isNotEmpty) {
                                        value += i.text;
                                      }
                                    }
                                    if (data.isNotEmpty) {
                                      FocusScope.of(context).requestFocus(otpNode[2]);
                                    } else if (data.isEmpty) {
                                      FocusScope.of(context).requestFocus(otpNode[0]);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Forms.normal(
                                  controller: otpC[2],
                                  context: context,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  focusNode: otpNode[2],
                                  keyboardType: TextInputType.number,
                                  counterText: '',
                                  border: BorderSide(
                                    width: 2,
                                    color: BaseColor.theme?.borderColor ?? Colors.transparent,
                                  ),
                                  onChanged: (data) {
                                    value = '';
                                    for (TextEditingController i in otpC) {
                                      if (i.text.isNotEmpty) {
                                        value += i.text;
                                      }
                                    }
                                    if (data.isNotEmpty) {
                                      FocusScope.of(context).requestFocus(otpNode[3]);
                                    } else if (data.isEmpty) {
                                      FocusScope.of(context).requestFocus(otpNode[1]);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Forms.normal(
                                  controller: otpC[3],
                                  context: context,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  focusNode: otpNode[3],
                                  keyboardType: TextInputType.number,
                                  counterText: '',
                                  border: BorderSide(
                                    width: 2,
                                    color: BaseColor.theme?.borderColor ?? Colors.transparent,
                                  ),
                                  onChanged: (data) {
                                    value = '';
                                    for (TextEditingController i in otpC) {
                                      if (i.text.isNotEmpty) {
                                        value += i.text;
                                      }
                                    }
                                    if (data.isNotEmpty) {
                                      FocusScope.of(context).requestFocus(otpNode[4]);
                                    } else if (data.isEmpty) {
                                      FocusScope.of(context).requestFocus(otpNode[2]);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Forms.normal(
                                  controller: otpC[4],
                                  context: context,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  focusNode: otpNode[4],
                                  keyboardType: TextInputType.number,
                                  counterText: '',
                                  border: BorderSide(
                                    width: 2,
                                    color: BaseColor.theme?.borderColor ?? Colors.transparent,
                                  ),
                                  onChanged: (data) {
                                    value = '';
                                    for (TextEditingController i in otpC) {
                                      if (i.text.isNotEmpty) {
                                        value += i.text;
                                      }
                                    }
                                    if (data.isNotEmpty) {
                                      FocusScope.of(context).requestFocus(otpNode[5]);
                                    } else if (data.isEmpty) {
                                      FocusScope.of(context).requestFocus(otpNode[3]);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Forms.normal(
                                  controller: otpC[5],
                                  context: context,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  focusNode: otpNode[5],
                                  keyboardType: TextInputType.number,
                                  counterText: '',
                                  border: BorderSide(
                                    width: 2,
                                    color: BaseColor.theme?.borderColor ?? Colors.transparent,
                                  ),
                                  onChanged: (data) {
                                    value = '';
                                    for (TextEditingController i in otpC) {
                                      if (i.text.isNotEmpty) {
                                        value += i.text;
                                      }
                                    }
                                    if (data.isNotEmpty) {
                                      check();
                                    } else if (data.isEmpty) {
                                      FocusScope.of(context).requestFocus(otpNode[4]);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Button.flat(
                    context: context,
                    color: BaseColor.theme?.primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'CONTINUE',
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
                    onTap: () async {
                      check();
                    },
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text(
                  //       "Resend code in ",
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.of(context).pop();
                  //       },
                  //       child: Text(
                  //         '00:20',
                  //         style: TextStyle(color: BaseColor.theme?.linkActive),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
