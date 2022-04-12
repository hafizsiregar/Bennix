import 'package:benix/main_library.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends BaseBackground<SettingView> {
  TextEditingController password1 = TextEditingController(), password2 = TextEditingController(), password2K = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        formKey: _form,
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: BaseColor.theme?.primaryColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.chevron_left,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            // decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                // color: Colors.white,
                                // shape: BoxShape.circle,
                                image: DecorationImage(image: AssetImage('assets/icons/set.png')),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'Setting',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BackgroundImage(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         'Sound',
                          //         style: TextStyle(
                          //           color: BaseColor.theme?.captionColor,
                          //         ),
                          //       ),
                          //       Switch(
                          //         value: false,
                          //         onChanged: (val) async {
                          //           setState(() {});
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         'Notification',
                          //         style: TextStyle(
                          //           color: BaseColor.theme?.captionColor,
                          //         ),
                          //       ),
                          //       Switch(
                          //         value: false,
                          //         onChanged: (val) async {
                          //           setState(() {});
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   color: BaseColor.theme?.borderColor,
                          //   width: MediaQuery.of(context).size.width,
                          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Paket E-Course',
                                  style: TextStyle(
                                    color: BaseColor.theme?.captionColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Version 1.0',
                                  style: TextStyle(
                                    color: BaseColor.theme?.captionColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
