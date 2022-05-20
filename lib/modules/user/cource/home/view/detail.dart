import 'dart:io';
import 'package:benix/main_library.dart';
import 'package:benix/modules/user/cource/home/api/request_api.dart';
import 'package:benix/modules/user/cource/home/model/bloc.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:benix/modules/user/cource/home/view/comments.dart';
import 'package:benix/modules/user/cource/home/view/player.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:benix/modules/user/paket/view/main_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailEcourceView extends StatefulWidget {
  final Cource data;
  const DetailEcourceView({Key? key, required this.data}) : super(key: key);

  @override
  _DetailEcourceViewState createState() => _DetailEcourceViewState();
}

class _DetailEcourceViewState extends BaseBackground<DetailEcourceView> {
  bool isVideo = true;
  int selectedVideo = 0;
  YoutubePlayerController? _controllerGlobal;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getDetailEcource(context, widget.data.id.toString(), onSuccess: () {
        setState(() {});
      });
    });
  }

  void _launchURL(url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  void _rating() {
    int selected = 0;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, states) {
              return CupertinoAlertDialog(
                title: const Text('Beri Rating'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 5; i++)
                      GestureDetector(
                        onTap: () {
                          states(
                            () {
                              selected = (i + 1);
                            },
                          );
                        },
                        child: Icon(
                          Icons.star_purple500_sharp,
                          color: selected >= (i + 1) ? Colors.yellow[700] : Colors.black26,
                          size: 30,
                        ),
                      ),
                  ],
                ),
                actions: [
                  Button.flat(
                    context: context,
                    title: 'Kirim',
                    color: Colors.transparent,
                    textColor: Colors.black,
                    onTap: () async {
                      if (selected == 0) {
                        Fluttertoast.showToast(msg: 'Isikan rating terlebih dahulu');
                      }
                      await rating(context, widget.data.id.toString(), selected.toString(), onSuccess: () {
                        getDetailEcource(context, widget.data.id.toString(), onSuccess: () {
                          setState(() {});
                          Navigator.of(context).pop();
                        });
                      });
                    },
                  ),
                ],
              );
            },
          );
        });
  }

  @override
  void dispose() {
    DetailEcourceBloc.clear();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape && widget.data.isExternal == 'eksternal') {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: YoutubePlayer(
          controller: _controllerGlobal!,
          showVideoProgressIndicator: true,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
          onReady: () {
            _controllerGlobal!.addListener(() {});
          },
        ),
      );
    }
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: BaseColor.theme?.primaryColor,
                    image: DecorationImage(
                      image: NetworkImage(widget.data.bannerUrl ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: BaseColor.theme?.primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.data.name ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.data.trainerName ?? '',
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < double.parse(DetailEcourceBloc.data.avgRate ?? '0').floor(); i++)
                              Icon(
                                Icons.star_purple500_sharp,
                                color: Colors.yellow[700],
                                size: 17,
                              ),
                            for (int i = 0 + double.parse(DetailEcourceBloc.data.avgRate ?? '0').floor(); i < 5; i++)
                              const Icon(
                                Icons.star_purple500_sharp,
                                color: Colors.black26,
                                size: 17,
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GlassmorphicContainer(
                                alignment: Alignment.center,
                                width: 70,
                                height: 30,
                                padding: EdgeInsets.all(5),
                                blur: 20,
                                border: 1,
                                borderRadius: 100,
                                linearGradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                  Color.fromARGB(255, 19, 12, 12).withOpacity(0.1),
                                  Color.fromARGB(255, 68, 60, 60).withOpacity(0.05),
                                ], stops: const [
                                  0.1,
                                  1,
                                ]),
                                borderGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFFffffff).withOpacity(0.5),
                                    const Color((0xFFFFFFFF)).withOpacity(0.5),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      DateFormat('MMM').format(widget.data.startDate!).toUpperCase(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      widget.data.startDate!.day.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(widget.data.videoType ?? '',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                )),
                            SizedBox(width: 10),
                            Text('•',
                                style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                )),
                            SizedBox(width: 10),
                            Text("${widget.data.episodeMin} - ${widget.data.episodeMax}  Episode",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.data.description == '' || widget.data.description == null ? 'Tidak Ada Deskripsi' : widget.data.description ?? '',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            btnContent(
                                text: 'Komentar',
                                onTap: () {
                                  navigator(page: CommentsView(data: widget.data));
                                },
                                icon: Icon(Icons.chat, color: Color.fromARGB(255, 87, 86, 86))),
                            SizedBox(width: 20),
                            btnContent(
                                text: 'Beri Rating',
                                onTap: () {
                                  _rating();
                                },
                                icon: Icon(Icons.add, color: Color.fromARGB(255, 87, 86, 86))),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (!isVideo) isVideo = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: isVideo
                                        ? const Border(
                                            bottom: BorderSide(
                                            width: 1,
                                          ))
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Video',
                                      style: GoogleFonts.poppins(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isVideo) isVideo = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: !isVideo
                                        ? const Border(
                                            bottom: BorderSide(
                                            width: 1,
                                          ))
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Modul',
                                      style: GoogleFonts.poppins(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        isVideo
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: DetailEcourceBloc.data.videos == null ? 0 : DetailEcourceBloc.data.videos!.length,
                                itemBuilder: (context, i) {
                                  final data = DetailEcourceBloc.data.videos?[i];
                                  late YoutubePlayerController _controller;
                                  if (data!.videoUrl!.contains('youtube.com')) {
                                    _controller = YoutubePlayerController(
                                      initialVideoId: Uri.parse(data.videoUrl!).queryParameters['v']!,
                                      flags: const YoutubePlayerFlags(
                                        autoPlay: false,
                                        mute: false,
                                        hideControls: true,
                                        endAt: 1,
                                      ),
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 2.0),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (data.isFree != '0' && (UserBloc.user.typeCourse == 'Gratis' || UserBloc.user.typeCourse == null)) {
                                            Fluttertoast.showToast(msg: 'Video Berbayar Tidak Bisa Di Buka, Silahkan Membeli Paket');
                                            navigator(page: const PaketView());
                                            return;
                                          }
                                        },
                                        child: data.videoUrl!.contains('youtube.com')
                                            // dimulai dari sini
                                            ? Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (data.videoUrl == null) {
                                                            Fluttertoast.showToast(msg: 'Video Tidak Valid');
                                                          }
                                                          if (data.isFree != '0' && (UserBloc.user.typeCourse == 'Gratis' || UserBloc.user.typeCourse == null)) {
                                                            _controller.pause();
                                                            Fluttertoast.showToast(msg: 'Video Berbayar Tidak Bisa Di Buka, Silahkan Membeli Paket');
                                                            navigator(page: const PaketView());
                                                          } else {
                                                            navigator(
                                                              page: PlayerCource(
                                                                type: Types.external,
                                                                url: data.videoUrl!,
                                                                desc: data.description!,
                                                                title: data.name!,
                                                                id: widget.data.id.toString(),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 100,
                                                          width: 170,
                                                          child: data.videoUrl!.contains('youtube.com')
                                                              ? YoutubePlayer(
                                                                  thumbnail: Container(),
                                                                  controller: _controller,
                                                                  showVideoProgressIndicator: true,
                                                                  progressColors: const ProgressBarColors(
                                                                    playedColor: Colors.amber,
                                                                    handleColor: Colors.amberAccent,
                                                                  ),
                                                                  onReady: () {
                                                                    if (data.isFree != '0' && (UserBloc.user.typeCourse == 'Gratis' || UserBloc.user.typeCourse == null)) {
                                                                      return;
                                                                    }
                                                                    _controller.addListener(() {
                                                                      if (_controllerGlobal != _controller) {
                                                                        _controllerGlobal = _controller;
                                                                      }
                                                                      selectedVideo = DetailEcourceBloc.data.videos!.indexWhere((element) => element.courceId == data.courceId);
                                                                    });
                                                                  },
                                                                )
                                                              : const SizedBox(),
                                                        ),
                                                      ),
                                                      SizedBox(width: 15),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              data.name ?? '',
                                                              style: GoogleFonts.poppins(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: <Widget>[
                                                                Text(
                                                                  data.episode == 99 ? '${data.episode} Episode' : '${data.episode} Episode',
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: Colors.black54,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Icon(
                                                                  (data.isFree != '0' && (UserBloc.user.typeCourse == 'Gratis' || UserBloc.user.typeCourse == null)) ? Icons.lock : null,
                                                                  size: 15,
                                                                  color: Colors.amberAccent,
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    data.description ?? '',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: BaseColor.theme?.captionColor,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  navigator(
                                                    page: PlayerCource(
                                                      type: Types.internal,
                                                      url: data.videoUrl!,
                                                      desc: data.description!,
                                                      title: data.name!,
                                                      id: widget.data.id.toString(),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 100,
                                                          width: 170,
                                                          child: data.isFree != '0' && (UserBloc.user.typeCourse == 'Gratis' || UserBloc.user.typeCourse == null)
                                                              ? Container(
                                                                  width: 150,
                                                                  height: 100,
                                                                  decoration: data.videoUrl!.contains('youtube.com')
                                                                      ? null
                                                                      : BoxDecoration(
                                                                          image: data.thumnail == null
                                                                              ? null
                                                                              : DecorationImage(
                                                                                  image: FileImage(File(data.thumnail ?? '')),
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                        ),
                                                                )
                                                              : Container(
                                                                  decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: FileImage(File(data.thumnail ?? '')),
                                                                      fit: BoxFit.cover,
                                                                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                                                                    ),
                                                                  ),
                                                                ),
                                                        ),
                                                        SizedBox(width: 15),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              data.name ?? '',
                                                              style: GoogleFonts.poppins(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              data.episode == 99 ? '${data.episode} Episode' : '${data.episode} Episode',
                                                              style: GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.black54,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      data.description ?? '',
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: BaseColor.theme?.captionColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: DetailEcourceBloc.data.modules == null ? 0 : DetailEcourceBloc.data.modules!.length,
                                itemBuilder: (context, i) {
                                  final data = DetailEcourceBloc.data.modules?[i];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          _launchURL(data!.moduleUrl!);
                                        },
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Icon(FeatherIcons.fileText),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data?.name ?? '',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      data?.description ?? 'Tidak Ada Deskripsi',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ],
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

  Widget btnContent({required String text, required Function() onTap, required Icon icon}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            SizedBox(width: 5),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(137, 12, 12, 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
