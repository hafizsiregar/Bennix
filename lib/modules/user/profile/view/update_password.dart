import 'package:benix/main_library.dart';
import 'package:benix/modules/user/profile/api/request_api.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({Key? key}) : super(key: key);

  @override
  _UpdatePasswordViewState createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends BaseBackground<UpdatePasswordView> {
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
                                image: DecorationImage(image: AssetImage('assets/icons/password.png')),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'Perbarui Password',
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: password1,
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text('Password Saat Ini'),
                            ),
                            validator: (data) {
                              if (data!.length < 8) {
                                return 'Minimal 8 Huruf';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: password2,
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text('Password Baru'),
                            ),
                            validator: (data) {
                              if (data!.length < 8) {
                                return 'Minimal 8 Huruf';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: password2K,
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text('Konfirmasi Password'),
                            ),
                            validator: (data) {
                              if (password2K.text != password2.text) {
                                return 'Password Tidak Sama';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button.flat(
                context: context,
                title: 'Ubah',
                color: const Color(0xffFFBDAE),
                textColor: Colors.black,
                onTap: () async {
                  if (_form.currentState!.validate()) {
                    await updatePassword(
                      context: context,
                      p: password1.text,
                      pp: password2.text,
                      ppk: password2K.text,
                      onSuccess: () {
                        Navigator.of(context).pop();
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
