import 'dart:io';

import 'package:benix/main_library.dart';
import 'package:benix/modules/admin/cource/api/request_api.dart';
import 'package:benix/modules/admin/cource/model/main_bloc.dart';
import 'package:benix/modules/admin/cource/model/model.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:request_api_helper/request_api_helper.dart';

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
            title: 'Tambah Video',
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: BaseColor.theme!.primaryColor,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(
                            FeatherIcons.chevronLeft,
                            color: BaseColor.theme!.textButtonColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                'Bennix E-Course',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: BaseColor.theme!.textButtonColor,
                                ),
                              ),
                            ),
                            Text(
                              'Unggah Video',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: BaseColor.theme!.textButtonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //////////////////////
                // step 1
                //////////////////////

                step[0]
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Deskripsi',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff383838),
                              ),
                            ),
                            const Text(
                              'Isi Data Dengan Benar',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff383838),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                banner = await getImage(context);
                                setState(() {});
                              },
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
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
                                        child: Text('Pilih Banner'),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Forms.border(
                                context: context,
                                controller: _judul,
                                hintText: 'Masukkan Judul',
                                label: 'Judul',
                                isfloat: true,
                                validator: (data) {
                                  if (data!.isEmpty) {
                                    return 'harus Di Isi';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 24.0),
                              child: Text(
                                '(Judul Akan Muncul Di Beranda / Pencarian)',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff8a8a8a),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Forms.border(
                                context: context,
                                controller: _pengajar,
                                hintText: 'Masukkan Nama Pelatih / Trainer',
                                label: 'Pengajar',
                                isfloat: true,
                                validator: (data) {
                                  if (data!.isEmpty) {
                                    return 'harus Di Isi';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 24.0),
                              child: Text(
                                '(Nama Pengajar Akan Muncul Di Dalam Deskripsi)',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff8a8a8a),
                                ),
                              ),
                            ),
                            GestureDetector(
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
                                padding: const EdgeInsets.only(bottom: 24),
                                child: Forms.border(
                                  context: context,
                                  controller: TextEditingController(text: kategori?.title),
                                  hintText: 'Pilih Kategori',
                                  label: 'Kategori',
                                  isfloat: true,
                                  enabled: false,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Forms.border(
                                context: context,
                                controller: _deskripsi,
                                hintText: 'Masukkan Deskripsi',
                                label: 'Deskripsi',
                                height: 3,
                                isfloat: true,
                                validator: (data) {
                                  if (data!.isEmpty) {
                                    return 'harus Di Isi';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 24.0),
                              child: Text(
                                '(Masukkan Deskripsi Yang Menjelaskan Video Anda)',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff8a8a8a),
                                ),
                              ),
                            ),
                            Row(
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
                            const Padding(
                              padding: EdgeInsets.only(bottom: 24.0),
                              child: Text(
                                '(Video akan muncul sesuai awal dan akhir)',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff8a8a8a),
                                ),
                              ),
                            ),
                            Row(
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
                          ],
                        ),
                      ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Video',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff383838),
                                  ),
                                ),
                                Text(
                                  'Minimal 1 Video Untuk Mengupload',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff8a8a8a),
                                  ),
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            Button.flat(
                              context: context,
                              onTap: () async {
                                await _showAddVideo();
                                setState(() {});
                              },
                              title: 'Tambah',
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: AdminCourceBloc.videoData.length,
                        itemBuilder: (context, index) {
                          final datas = AdminCourceBloc.videoData[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                    color: Colors.black.withOpacity(0.08),
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 4.0),
                                                child: Text(
                                                  datas.name ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                'Server',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Color(0xff8a8a8a),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Expanded(child: SizedBox()),
                                          InkWell(
                                            onTap: () async {
                                              AdminCourceBloc.delete(index);
                                              await deleteCourceVideo(context: context, id: datas.id.toString());
                                              setState(() {});
                                            },
                                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                                            child: Icon(
                                              FeatherIcons.x,
                                              color: Theme.of(context).errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      datas.episode ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      AddVideoBloc.videoData.isEmpty && AdminCourceBloc.videoData.isEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.width * 0.5,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      FeatherIcons.videoOff,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text('Tidak Ada Data'),
                                  ],
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: AddVideoBloc.videoData.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final datas = AddVideoBloc.videoData[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Material(
                                          color: Colors.black.withOpacity(0.08),
                                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(bottom: 4.0),
                                                        child: Text(
                                                          datas.name ?? '',
                                                          style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        datas.isExtern! ? datas.videoPath ?? '' : 'Internal',
                                                        style: const TextStyle(
                                                          fontSize: 11,
                                                          color: Color(0xff8a8a8a),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      AddVideoBloc.delete(index);

                                                      setState(() {});
                                                    },
                                                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                    child: Icon(
                                                      FeatherIcons.x,
                                                      color: Theme.of(context).errorColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            datas.episode ?? '',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Modul',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff383838),
                                  ),
                                ),
                                Text(
                                  'Opsional',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff8a8a8a),
                                  ),
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            Button.flat(
                              context: context,
                              onTap: () async {
                                await _showAddModul();
                                setState(() {});
                              },
                              title: 'Tambah',
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: AdminCourceBloc.moduleData.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final datas = AdminCourceBloc.moduleData[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                    color: Colors.black.withOpacity(0.08),
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 4.0),
                                                child: Text(
                                                  datas.name ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Expanded(child: SizedBox()),
                                          InkWell(
                                            onTap: () async {
                                              AddVideoBloc.deleteModul(index);
                                              await deleteCourceModule(context: context, id: datas.id.toString());
                                              setState(() {});
                                            },
                                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                                            child: Icon(
                                              FeatherIcons.x,
                                              color: Theme.of(context).errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      FeatherIcons.fileText,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      AddVideoBloc.moduleData.isEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.width * 0.5,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      FeatherIcons.fileText,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text('Tidak Ada Modul'),
                                  ],
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: AddVideoBloc.moduleData.length,
                              itemBuilder: (context, index) {
                                final datas = AddVideoBloc.moduleData[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Material(
                                          color: Colors.black.withOpacity(0.08),
                                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 4.0),
                                                      child: Text(
                                                        datas.name ?? '',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Expanded(child: SizedBox()),
                                                InkWell(
                                                  onTap: () {
                                                    AddVideoBloc.deleteModul(index);
                                                    setState(() {});
                                                  },
                                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                  child: Icon(
                                                    FeatherIcons.x,
                                                    color: Theme.of(context).errorColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            FeatherIcons.fileText,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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
                                  final bool stat = await updateEcource(
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
                                  );
                                  return;
                                } else {
                                  final bool stat = await createEcource(
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
                                  );
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
