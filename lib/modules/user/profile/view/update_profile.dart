import 'package:benix/main_library.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:benix/modules/user/profile/api/request_api.dart';
import 'package:intl/intl.dart';

enum Gender { L, W }

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({Key? key}) : super(key: key);

  @override
  _UpdateProfileViewState createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends BaseBackground<UpdateProfileView> {
  TextEditingController nama = TextEditingController(text: UserBloc.user.name), email = TextEditingController(text: UserBloc.user.email), phone = TextEditingController(text: UserBloc.user.phone);
  DateTime lahir = DateTime.parse(UserBloc.user.tanggalLahir ?? DateTime.now().toString());
  Gender _gender = UserBloc.user.gender == 'male' ? Gender.L : Gender.W;
  @override
  void initState() {
    super.initState();
  }

  Color _getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return BaseColor.theme!.primaryColor!;
    }
    return BaseColor.theme!.primaryColor!;
  }

  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
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
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: UserBloc.user.photoProfile == null
                                    ? null
                                    : DecorationImage(
                                        image: NetworkImage(UserBloc.user.photoProfile!),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'Perbarui Profil',
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: nama,
                                decoration: const InputDecoration(
                                  label: Text('Nama Lengkap'),
                                ),
                              ),
                              TextFormField(
                                controller: phone,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  label: Text('No HP'),
                                  prefix: Text('+62 '),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(context: context, initialDate: lahir, firstDate: DateTime(1970), lastDate: DateTime.now()).then((value) {
                                    if (value != null) {
                                      lahir = value;
                                      setState(() {});
                                    }
                                  });
                                },
                                child: TextFormField(
                                  controller: TextEditingController(
                                    text: DateFormat('dd MMM yyyy').format(lahir),
                                  ),
                                  decoration: const InputDecoration(
                                    enabled: false,
                                    label: Text('Tanggal Lahir'),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black54,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Radio<Gender>(
                                  activeColor: BaseColor.theme?.primaryColor,
                                  fillColor: MaterialStateProperty.resolveWith(_getColor),
                                  value: Gender.L,
                                  groupValue: _gender,
                                  onChanged: (Gender? value) {
                                    setState(() {
                                      _gender = value!;
                                    });
                                  },
                                ),
                                const Text('Pria')
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                Radio<Gender>(
                                  activeColor: Theme.of(context).textTheme.bodyText1!.color,
                                  fillColor: MaterialStateProperty.resolveWith(_getColor),
                                  value: Gender.W,
                                  groupValue: _gender,
                                  onChanged: (Gender? value) {
                                    setState(() {
                                      _gender = value!;
                                    });
                                  },
                                ),
                                const Text('Wanita')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
                onTap: () async {
                  await saveProfile(
                    context: context,
                    phone: phone.text[0] == '0' ? phone.text.substring(1, phone.text.length) : phone.text,
                    name: nama.text,
                    gender: _gender == Gender.L ? 'male' : 'female',
                    date: DateFormat('yyyy-MM-dd').format(lahir),
                    onSuccess: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
                context: context,
                title: 'Ubah',
                color: const Color(0xffFFBDAE),
                textColor: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
