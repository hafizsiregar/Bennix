import 'dart:io';

import 'package:benix/main_library.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../model/model.dart';

class AddVideoDetailView extends StatefulWidget {
  final VideoData data;
  final bool isExtern, isFree;
  const AddVideoDetailView({Key? key, required this.data, required this.isExtern, required this.isFree}) : super(key: key);

  @override
  State<AddVideoDetailView> createState() => _AddVideoDetailViewState();
}

class _AddVideoDetailViewState extends BaseBackground<AddVideoDetailView> {
  TextEditingController video = TextEditingController(), deskripsi = TextEditingController(), linkVideo = TextEditingController();
  VideoData? selected;

  @override
  Widget build(BuildContext context) {
    return InitControl(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tambah Video',
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 12),
                      child: GestureDetector(
                        onTap: () async {
                          final pathVideo = await getVideo(context);
                          if (pathVideo != null) {
                            final fileName = await VideoThumbnail.thumbnailFile(
                              video: pathVideo,
                              imageFormat: ImageFormat.PNG,
                              timeMs: 1,
                              maxHeight: 100,
                              quality: 100,
                            );
                            widget.data.detailVideo ??= [];
                            final data = VideoData();
                            data.isExtern = widget.isExtern;
                            data.episode = '0';
                            data.name = '';
                            data.videoPath = widget.isExtern ? linkVideo.text : pathVideo;
                            data.desc = '';
                            data.isfree = widget.isFree;
                            data.thumnail = fileName;
                            widget.data.detailVideo!.add(data);
                          }
                          setState(() {});
                        },
                        child: Container(
                          height: 100,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              width: 2,
                              color: Colors.black26,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Upload Video',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: widget.data.detailVideo == null
                          ? []
                          : widget.data.detailVideo!.map<Widget>(
                              (e) {
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12.0, top: 12),
                                      child: GestureDetector(
                                        onTap: () async {
                                          video.text = e.name ?? '';
                                          deskripsi.text = e.desc ?? '';
                                          selected = e;
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 160,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.black26,
                                            ),
                                            image: e.thumnail == null
                                                ? (e.networkThumnail != null)
                                                    ? DecorationImage(
                                                        image: NetworkImage(e.networkThumnail!),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : null
                                                : DecorationImage(
                                                    image: FileImage(
                                                      File(e.thumnail!),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          child: e.thumnail != null || e.networkThumnail != null
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
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                                        onTap: () {
                                          widget.data.detailVideo!.removeAt(widget.data.detailVideo!.indexOf(e));
                                          setState(() {});
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black12,
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: const Icon(
                                            Icons.close,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ).toList(),
                    )
                  ],
                ),
              ),
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
                height: 6,
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
              Button.flat(
                context: context,
                title: 'Simpan',
                onTap: () {
                  if (selected != null) {
                    selected!.name = video.text;
                    selected!.desc = deskripsi.text;
                    selected = null;
                    setState(() {});
                    video.text = '';
                    deskripsi.text = '';
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
