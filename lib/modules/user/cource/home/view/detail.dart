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
  bool isVideo = false, isModules = false;
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
                  padding: const EdgeInsets.all(15),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.data.trainerName ?? '',
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    navigator(page: CommentsView(data: widget.data));
                                  },
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: const Icon(FeatherIcons.messageCircle),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    _rating();
                                  },
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: const Icon(FeatherIcons.star),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.data.name ?? '',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(FeatherIcons.clock),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(widget.data.jam == null && widget.data.menit == null ? 'Tidak Ada Durasi' : '${widget.data.jam} Jam ${widget.data.menit} Menit'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(FeatherIcons.star),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text('${widget.data.avgRate == '0' ? 'Tidak Ada Rating' : widget.data.avgRate}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(FeatherIcons.video),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text('${widget.data.episodeMax} Episode'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(FeatherIcons.user),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text('200 Penonton'),
                                      ],
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
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isVideo) isVideo = false;
                                    isModules = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: !isVideo && !isModules
                                        ? const Border(
                                            bottom: BorderSide(
                                            width: 1,
                                          ))
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Overview',
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
                                    if (!isVideo) isVideo = true;
                                    isModules = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: isVideo && !isModules
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
                                    if (!isModules) isModules = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: isModules
                                        ? const Border(
                                            bottom: BorderSide(
                                            width: 1,
                                          ))
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Module',
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
                        isVideo && !isModules
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
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                            Expanded(
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Expanded(
                                                                    child: Text(
                                                                      data.name ?? '',
                                                                      style: GoogleFonts.poppins(
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  (data.isFree != '0')
                                                                      ? Icon(
                                                                          Icons.lock,
                                                                          size: 16,
                                                                          color: Colors.yellow[800],
                                                                        )
                                                                      : const SizedBox(),
                                                                ],
                                                              ),
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
                                                  SizedBox(
                                                    height: 10,
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
                                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Text(
                                                                  data.name ?? '',
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              (data.isFree != '0')
                                                                  ? Icon(
                                                                      Icons.lock,
                                                                      size: 16,
                                                                      color: Colors.yellow[800],
                                                                    )
                                                                  : const SizedBox(),
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
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : isModules
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: DetailEcourceBloc.data.modules?.length,
                                    itemBuilder: (context, index) {
                                      final data = DetailEcourceBloc.data.modules![index];
                                      return Row(
                                        children: [
                                          const Icon(
                                            FeatherIcons.fileText,
                                            size: 50,
                                          ),
                                          Text(data.name ?? ''),
                                        ],
                                      );
                                    },
                                  )
                                : SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Key Points',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Wrap(
                                          children: (widget.data.dipelajari ?? '').split('\n').map<Widget>((e) {
                                            return SizedBox(
                                              width: (MediaQuery.of(context).size.width * .5) - 20,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    FeatherIcons.checkCircle,
                                                    color: Colors.blue,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Expanded(child: Text(e)),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          'Course ini cocok untuk',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Wrap(
                                          children: (widget.data.cocokUntuk ?? '').split('\n').map<Widget>((e) {
                                            return SizedBox(
                                              width: (MediaQuery.of(context).size.width * .5) - 20,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    FeatherIcons.checkCircle,
                                                    color: Colors.blue,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Expanded(child: Text(e)),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                      ],
                                    ),
                                  )
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
          boxShadow: const [
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
