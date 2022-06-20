import 'dart:io';

import 'package:benix/main_library.dart';
import 'package:benix/modules/admin/cource/api/request_api.dart';
import 'package:benix/modules/admin/cource/model/main_bloc.dart';
import 'package:benix/modules/admin/cource/model/model.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'custom_form.dart';

class AddVideoView extends StatefulWidget {
  final Cource? editData;
  const AddVideoView({Key? key, this.editData}) : super(key: key);

  @override
  _AddVideoViewState createState() => _AddVideoViewState();
}

class _AddVideoViewState extends BaseBackground<AddVideoView> {
  List<bool> step = [false, false, false];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _judul = TextEditingController(), _pengajar = TextEditingController(), _deskripsi = TextEditingController();
  DateTime? start = DateTime.now(), end = DateTime.now().add(const Duration(days: 1));
  SelectData? kategori;
  int currentIndex = 0;
  bool isExtern = false;
  String? banner, bannerNetwork;
  List<bool> error = [false, false, false, false];
  bool toogle = false;

  _datePicker(date, initial) async {
    await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2021),
      lastDate: DateTime(2200),
    ).then((value) {
      if (value != null) {
        setState(() {
          if (initial == 'start') {
            start = value;
          } else if (initial == 'end') {
            end = value;
          }
        });
      }
    });
  }

  _showAddVideo() {
    String? pathVideo, pathModul;
    TextEditingController? video = TextEditingController(), episode = TextEditingController(), linkVideo = TextEditingController(), deskripsi = TextEditingController();
    GlobalKey<FormState> _formsS = GlobalKey<FormState>();
    bool isFree = true;
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStates) {
          return bottom(
            context: context,
            child: InitControl(
              formKey: _formsS,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Upload Video',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Forms.border(
                            controller: video,
                            context: context,
                            hintText: 'Masukkan Nama Video',
                            label: 'Nama',
                            isfloat: true,
                            validator: (data) {
                              if (data!.isEmpty) {
                                return 'harus Di Isi';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Forms.border(
                            controller: episode,
                            context: context,
                            hintText: '0 - 100',
                            label: 'Episode',
                            isfloat: true,
                            keyboardType: TextInputType.number,
                            onChanged: (data) {
                              if (data.isNotEmpty) {
                                if (int.parse(data) > 100) {
                                  episode.text = '100';
                                  setStates(() {});
                                }
                              }
                            },
                            validator: (data) {
                              if (data!.isEmpty) {
                                return 'harus Di Isi';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Forms.border(
                    controller: deskripsi,
                    context: context,
                    hintText: 'Masukkan Deskripsi Video',
                    label: 'Deskripsi',
                    isfloat: true,
                    height: 3,
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'harus Di Isi';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Video Gratis',
                        style: TextStyle(
                          color: BaseColor.theme?.captionColor,
                        ),
                      ),
                      Switch(
                        value: isFree,
                        onChanged: (val) async {
                          isFree = val;
                          setStates(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isExtern
                      ? Forms.border(
                          controller: linkVideo,
                          context: context,
                          hintText: 'Masukkan Link Video',
                          label: 'Link Video',
                          isfloat: true,
                          validator: (data) {
                            if (data!.isEmpty) {
                              return 'harus Di Isi';
                            }
                            return null;
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Button.flat(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                                color: pathVideo != null ? null : const Color(0xff595959),
                                onTap: () async {
                                  pathVideo = await getVideo(context);
                                  setStates(() {});
                                },
                                context: context,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Icon(
                                        FeatherIcons.video,
                                        size: 50,
                                        color: BaseColor.theme!.textButtonColor,
                                      ),
                                    ),
                                    const Text(
                                      'Video',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button.flat(
                    context: context,
                    title: 'Tambah Video',
                    onTap: () {
                      if (pathVideo == null && !isExtern) {
                        Fluttertoast.showToast(msg: 'File Video Belum Di Pilih');
                        return;
                      }
                      if (_formsS.currentState!.validate()) {
                        AddVideoBloc.add(
                          VideoData(
                            isExtern: isExtern,
                            episode: episode.text,
                            name: video.text,
                            videoPath: isExtern ? linkVideo.text : pathVideo,
                            desc: deskripsi.text,
                            isfree: isFree,
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  _showAddModul() {
    String? pathModul;
    TextEditingController? modul = TextEditingController();
    TextEditingController? deskripsi = TextEditingController();
    GlobalKey<FormState> _formsS = GlobalKey<FormState>();
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStates) {
          return bottom(
            title: 'Tambah Modul',
            context: context,
            child: InitControl(
              formKey: _formsS,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Forms.border(
                    controller: modul,
                    context: context,
                    hintText: 'Masukkan Nama Modul',
                    label: 'Nama',
                    isfloat: true,
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'harus Di Isi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Forms.border(
                    controller: deskripsi,
                    context: context,
                    hintText: 'Masukkan Deskripsi Modul',
                    label: 'Deskripsi',
                    isfloat: true,
                    height: 3,
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'harus Di Isi';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Button.flat(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          color: pathModul != null ? null : const Color(0xff595959),
                          onTap: () async {
                            pathModul = await getFile(context: context, extension: ['pdf']);
                            setStates(() {});
                          },
                          context: context,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Icon(
                                  FeatherIcons.video,
                                  size: 50,
                                  color: BaseColor.theme!.textButtonColor,
                                ),
                              ),
                              const Text(
                                'Modul',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button.flat(
                    context: context,
                    title: 'Tambah Modul',
                    onTap: () {
                      if (pathModul == null) {
                        Fluttertoast.showToast(msg: 'File Modul Belum Di Pilih');
                        return;
                      }
                      if (_formsS.currentState!.validate()) {
                        AddVideoBloc.addModule(
                          ModulData(
                            name: modul.text,
                            modulePath: pathModul,
                            desc: deskripsi.text,
                          ),
                        );
                        Navigator.of(context).pop();
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  _initEdit() async {
    if (widget.editData != null) {
      await detailCourceAdmin(context: context, id: widget.editData!.id.toString());
      _judul.text = AdminCourceBloc.edit.name ?? '';
      _pengajar.text = AdminCourceBloc.edit.trainerName ?? '';
      _deskripsi.text = AdminCourceBloc.edit.description ?? '';
      start = AdminCourceBloc.edit.startDate;
      end = AdminCourceBloc.edit.endDate;
      isExtern = AdminCourceBloc.edit.isExternal == 'internal' ? false : true;
      bannerNetwork = AdminCourceBloc.edit.bannerUrl;
      List<SelectData> getTitle = AddVideoBloc.ketegori.where((element) => element.id == AdminCourceBloc.edit.kategori).toList();
      kategori = SelectData(
        id: AdminCourceBloc.edit.kategori ?? '',
        title: getTitle.isNotEmpty ? getTitle[0].title : '',
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await category(context: context);
      _initEdit();
    });
    AddVideoBloc.init();
  }

  @override
  void dispose() {
    AdminCourceBloc.cleanEdit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        formKey: _formKey,
        child: Scaffold(
          backgroundColor: const Color(0xfff7f7f7),
          appBar: AppBar(
            title: Text(
              'Buat E-Cource',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),
            actions: [],
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),

                //////////////////////
                // step 1
                //////////////////////

                step[0]
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () async {
                                banner = await getImage(context);
                                setState(() {});
                              },
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.black26,
                                  ),
                                  image: banner == null
                                      ? (bannerNetwork != null)
                                          ? DecorationImage(
                                              image: NetworkImage(bannerNetwork!),
                                              fit: BoxFit.cover,
                                            )
                                          : null
                                      : DecorationImage(
                                          image: FileImage(
                                            File(banner!),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                child: banner != null || bannerNetwork != null
                                    ? const SizedBox()
                                    : const Center(
                                        child: Text(
                                          'Upload Banner',
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          addCourceForm(
                            error: error[0],
                            control: _judul,
                            title: 'Judul Course',
                            isRequired: true,
                            maxLength: 255,
                            hint: 'Masukkan Judul',
                            maxLine: 1,
                            onChanged: () {
                              error[0] = false;
                              setState(() {});
                            },
                            onError: () {
                              error[0] = true;
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          addCourceForm(
                            error: error[1],
                            control: _pengajar,
                            title: 'Nama Pengajar',
                            maxLength: 255,
                            isRequired: true,
                            hint: 'Masukkan Nama Pelatih / Trainer',
                            maxLine: 1,
                            onChanged: () {
                              error[1] = false;
                              setState(() {});
                            },
                            onError: () {
                              error[1] = true;
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Select.single(
                          //       title: 'Pilih Kategori',
                          //       context: context,
                          //       data: AddVideoBloc.ketegori,
                          //       selectedId: kategori?.id,
                          //       isSearch: true,
                          //     ).then((value) {
                          //       if (value != null) {
                          //         if (value.id != null) {
                          //           kategori = SelectData(
                          //             id: value.id,
                          //             title: value.title,
                          //           );
                          //         }
                          //       }
                          //     });
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(bottom: 24),
                          //     child: Forms.border(
                          //       context: context,
                          //       controller: TextEditingController(text: kategori?.title),
                          //       hintText: 'Pilih Kategori',
                          //       label: 'Kategori',
                          //       isfloat: true,
                          //       enabled: false,
                          //     ),
                          //   ),
                          // ),
                          addCourceForm(
                            error: error[2],
                            control: _deskripsi,
                            title: 'Deskripsi Course',
                            maxLength: 3000,
                            isRequired: true,
                            hint: 'Masukkan Deskripsi',
                            maxLine: null,
                            onChanged: () {
                              error[2] = false;
                              setState(() {});
                            },
                            onError: () {
                              error[2] = true;
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          addCourceForm(
                            maxLine: null,
                            title: 'Yang Akan Dipelajari',
                            hint: 'Masukkan Benefit',
                            onChanged: () {
                              setState(() {});
                            },
                            onError: () {
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          addCourceForm(
                            maxLine: null,
                            title: 'E course ini cocok untuk',
                            hint: 'Masukkan target audience',
                            onChanged: () {
                              setState(() {});
                            },
                            onError: () {
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Select.single(
                                      title: 'Pilih Kategori',
                                      context: context,
                                      data: AddVideoBloc.ketegori,
                                      selectedId: kategori?.id,
                                      isSearch: true,
                                    ).then((value) {
                                      if (value != null) {
                                        if (value.id != null) {
                                          kategori = SelectData(
                                            id: value.id,
                                            title: value.title,
                                          );
                                        }
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              FeatherIcons.sliders,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Text(
                                              'Kategori',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Expanded(child: SizedBox()),
                                            Text(
                                              kategori?.title ?? '',
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Icon(
                                              FeatherIcons.chevronRight,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black38,
                                  height: 0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _datePicker(start, 'start');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 4),
                                            child: Forms.border(
                                              context: context,
                                              hintText: DateFormat('dd MMM yyyy').format(start!),
                                              label: 'Tanggal Mulai',
                                              isfloat: true,
                                              enabled: false,
                                              validator: (data) {
                                                if (start == null) {
                                                  return 'harus Di Isi';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _datePicker(end, 'end');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 4),
                                            child: Forms.border(
                                              context: context,
                                              hintText: DateFormat('dd MMM yyyy').format(end!),
                                              label: 'Tanggal Berakhir',
                                              enabled: false,
                                              isfloat: true,
                                              validator: (data) {
                                                if (end == null) {
                                                  return 'harus Di Isi';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black38,
                                  height: 0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'External (Link Video Selain Bennix)',
                                        style: TextStyle(
                                          color: BaseColor.theme?.captionColor,
                                        ),
                                      ),
                                      Switch(
                                        value: isExtern,
                                        onChanged: (val) async {
                                          isExtern = val;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // const Padding(
                          //   padding: EdgeInsets.only(bottom: 24.0),
                          //   child: Text(
                          //     '(Video akan muncul sesuai awal dan akhir)',
                          //     style: TextStyle(
                          //       fontSize: 11,
                          //       fontWeight: FontWeight.w500,
                          //       color: Color(0xff8a8a8a),
                          //     ),
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () {
                              toogle ? toogle = false : toogle = true;
                              setState(() {});
                            },
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 18),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              toogle ? FeatherIcons.chevronUp : FeatherIcons.chevronDown,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Text(
                                              'Konten Course',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: toogle ? 160 : 0,
                            child: toogle
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await _showAddVideo();
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 120,
                                              width: 160,
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.black26,
                                                ),
                                                image: banner == null
                                                    ? (bannerNetwork != null)
                                                        ? DecorationImage(
                                                            image: NetworkImage(bannerNetwork!),
                                                            fit: BoxFit.cover,
                                                          )
                                                        : null
                                                    : DecorationImage(
                                                        image: FileImage(
                                                          File(banner!),
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                              child: banner != null || bannerNetwork != null
                                                  ? const SizedBox()
                                                  : const Center(
                                                      child: Text(
                                                        'Upload Video',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 20.0),
                      //   child: Row(
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: const [
                      //           Text(
                      //             'Video',
                      //             style: TextStyle(
                      //               fontSize: 22,
                      //               fontWeight: FontWeight.w500,
                      //               color: Color(0xff383838),
                      //             ),
                      //           ),
                      //           Text(
                      //             'Minimal 1 Video Untuk Mengupload',
                      //             style: TextStyle(
                      //               fontSize: 12,
                      //               fontWeight: FontWeight.w500,
                      //               color: Color(0xff8a8a8a),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const Expanded(child: SizedBox()),
                      //       Button.flat(
                      //         context: context,
                      //         onTap: () async {
                      //           await _showAddVideo();
                      //           setState(() {});
                      //         },
                      //         title: 'Tambah',
                      //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   itemCount: AdminCourceBloc.videoData.length,
                      //   itemBuilder: (context, index) {
                      //     final datas = AdminCourceBloc.videoData[index];
                      //     return Padding(
                      //       padding: const EdgeInsets.only(bottom: 20.0),
                      //       child: Stack(
                      //         alignment: Alignment.centerLeft,
                      //         children: [
                      //           Padding(
                      //             padding: const EdgeInsets.only(left: 16.0),
                      //             child: Material(
                      //               color: Colors.black.withOpacity(0.08),
                      //               borderRadius: const BorderRadius.all(Radius.circular(20)),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(12.0),
                      //                 child: Row(
                      //                   children: [
                      //                     const SizedBox(
                      //                       width: 20,
                      //                     ),
                      //                     Column(
                      //                       crossAxisAlignment: CrossAxisAlignment.start,
                      //                       children: [
                      //                         Padding(
                      //                           padding: const EdgeInsets.only(bottom: 4.0),
                      //                           child: Text(
                      //                             datas.name ?? '',
                      //                             style: const TextStyle(
                      //                               fontSize: 16,
                      //                               fontWeight: FontWeight.w600,
                      //                             ),
                      //                           ),
                      //                         ),
                      //                         const Text(
                      //                           'Server',
                      //                           style: TextStyle(
                      //                             fontSize: 11,
                      //                             color: Color(0xff8a8a8a),
                      //                             fontWeight: FontWeight.w500,
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                     const Expanded(child: SizedBox()),
                      //                     InkWell(
                      //                       onTap: () async {
                      //                         AdminCourceBloc.delete(index);
                      //                         await deleteCourceVideo(context: context, id: datas.id.toString());
                      //                         setState(() {});
                      //                       },
                      //                       borderRadius: const BorderRadius.all(Radius.circular(100)),
                      //                       child: Icon(
                      //                         FeatherIcons.x,
                      //                         color: Theme.of(context).errorColor,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           Container(
                      //             height: 40,
                      //             width: 40,
                      //             decoration: const BoxDecoration(
                      //               color: Colors.blue,
                      //               shape: BoxShape.circle,
                      //             ),
                      //             child: Center(
                      //               child: Text(
                      //                 datas.episode ?? '',
                      //                 style: const TextStyle(
                      //                   fontSize: 18,
                      //                   color: Colors.white,
                      //                   fontWeight: FontWeight.w700,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                      // AddVideoBloc.videoData.isEmpty && AdminCourceBloc.videoData.isEmpty
                      //     ? SizedBox(
                      //         height: MediaQuery.of(context).size.width * 0.5,
                      //         child: Center(
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: const [
                      //               Icon(
                      //                 FeatherIcons.videoOff,
                      //               ),
                      //               SizedBox(
                      //                 height: 20,
                      //               ),
                      //               Text('Tidak Ada Data'),
                      //             ],
                      //           ),
                      //         ),
                      //       )
                      //     : ListView.builder(
                      //         shrinkWrap: true,
                      //         itemCount: AddVideoBloc.videoData.length,
                      //         physics: const NeverScrollableScrollPhysics(),
                      //         itemBuilder: (context, index) {
                      //           final datas = AddVideoBloc.videoData[index];
                      //           return Padding(
                      //             padding: const EdgeInsets.only(bottom: 20.0),
                      //             child: Stack(
                      //               alignment: Alignment.centerLeft,
                      //               children: [
                      //                 Padding(
                      //                   padding: const EdgeInsets.only(left: 16.0),
                      //                   child: Material(
                      //                     color: Colors.black.withOpacity(0.08),
                      //                     borderRadius: const BorderRadius.all(Radius.circular(20)),
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(12.0),
                      //                       child: Row(
                      //                         children: [
                      //                           const SizedBox(
                      //                             width: 20,
                      //                           ),
                      //                           Expanded(
                      //                             child: Column(
                      //                               crossAxisAlignment: CrossAxisAlignment.start,
                      //                               children: [
                      //                                 Padding(
                      //                                   padding: const EdgeInsets.only(bottom: 4.0),
                      //                                   child: Text(
                      //                                     datas.name ?? '',
                      //                                     style: const TextStyle(
                      //                                       fontSize: 16,
                      //                                       fontWeight: FontWeight.w600,
                      //                                     ),
                      //                                   ),
                      //                                 ),
                      //                                 Text(
                      //                                   datas.isExtern! ? datas.videoPath ?? '' : 'Internal',
                      //                                   style: const TextStyle(
                      //                                     fontSize: 11,
                      //                                     color: Color(0xff8a8a8a),
                      //                                     fontWeight: FontWeight.w500,
                      //                                   ),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                           SizedBox(
                      //                             width: 40,
                      //                             child: InkWell(
                      //                               onTap: () async {
                      //                                 AddVideoBloc.delete(index);

                      //                                 setState(() {});
                      //                               },
                      //                               borderRadius: const BorderRadius.all(Radius.circular(100)),
                      //                               child: Icon(
                      //                                 FeatherIcons.x,
                      //                                 color: Theme.of(context).errorColor,
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Container(
                      //                   height: 40,
                      //                   width: 40,
                      //                   decoration: const BoxDecoration(
                      //                     color: Colors.blue,
                      //                     shape: BoxShape.circle,
                      //                   ),
                      //                   child: Center(
                      //                     child: Text(
                      //                       datas.episode ?? '',
                      //                       style: const TextStyle(
                      //                         fontSize: 18,
                      //                         color: Colors.white,
                      //                         fontWeight: FontWeight.w700,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         },
                      //       ),
                      Row(
                        children: [
                          Expanded(
                            child: Button.flat(
                              context: context,
                              title: widget.editData != null ? 'Update Ecource' : 'Simpan Ecource',
                              onTap: () async {
                                if (banner == null && bannerNetwork == null) {
                                  Fluttertoast.showToast(msg: 'Harap Memilih Banner');
                                  return;
                                }
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                if (widget.editData != null) {
                                  await updateEcource(
                                      context: context,
                                      data: Cource(
                                        bannerUrl: banner,
                                        name: _judul.text,
                                        certificateUrl: '',
                                        description: _deskripsi.text,
                                        endDate: end,
                                        id: widget.editData!.id,
                                        isExternal: isExtern ? 'eksternal' : 'internal',
                                        startDate: start,
                                        trainerName: _pengajar.text,
                                        kategori: kategori?.id,
                                      ),
                                      modul: AddVideoBloc.moduleData,
                                      video: AddVideoBloc.videoData,
                                      modulOld: AdminCourceBloc.moduleData,
                                      videoOld: AdminCourceBloc.videoData,
                                      onSuccess: () {});
                                  return;
                                } else {
                                  createEcource(
                                      context: context,
                                      data: AddVideo(
                                        name: _judul.text,
                                        bannerPath: banner,
                                        certificatePath: '',
                                        desc: _deskripsi.text,
                                        end: DateFormat('yyyy-MM-dd').format(end!),
                                        modul: AddVideoBloc.moduleData,
                                        start: DateFormat('yyyy-MM-dd').format(start!),
                                        trainer: _pengajar.text,
                                        video: AddVideoBloc.videoData,
                                        videoType: isExtern ? 'eksternal' : 'internal',
                                        kategori: kategori?.id,
                                      ),
                                      onSuccess: () {});
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: widget.editData == null ? 0 : 20,
                          ),
                          widget.editData == null
                              ? const SizedBox()
                              : Expanded(
                                  child: Button.flat(
                                    color: Colors.red,
                                    context: context,
                                    title: 'Delete',
                                    onTap: () async {
                                      await deleteCource(context: context, id: widget.editData?.id.toString());
                                    },
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
