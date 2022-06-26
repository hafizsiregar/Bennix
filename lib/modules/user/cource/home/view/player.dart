import 'dart:io';

import 'package:benix/main_library.dart';
import 'package:benix/modules/user/cource/home/api/request_api.dart';
import 'package:benix/modules/user/cource/home/model/bloc.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../login/bloc/main_bloc.dart';
import '../../../paket/view/main_view.dart';

class PlayerC {
  final Types type;
  final String url, title, desc, id;
  PlayerC({required this.desc, required this.id, required this.title, required this.type, required this.url});
}

enum Types { external, internal }

class PlayerCource extends StatefulWidget {
  final Types type;
  final String url, title, desc, id;

  const PlayerCource({Key? key, required this.type, required this.url, required this.desc, required this.title, required this.id}) : super(key: key);

  @override
  _PlayerCourceState createState() => _PlayerCourceState();
}

class _PlayerCourceState extends BaseBackground<PlayerCource> {
  Widget players = const SizedBox();
  int selectedVideo = 0;
  YoutubePlayerController? _controllerGlobal;
  late YoutubePlayerController _controller;
  late PlayerC dataBased;
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('id', timeago.IdMessages());
    Future.delayed(
      Duration.zero,
      () async {
        dataBased = PlayerC(desc: widget.desc, id: widget.id, title: widget.title, type: widget.type, url: widget.url);
        players = dataBased.type == Types.external
            ? YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  _controller.addListener(() {});
                },
              )
            : BetterPlayer.network(
                dataBased.url,
                betterPlayerConfiguration: const BetterPlayerConfiguration(
                  fit: BoxFit.contain,
                ),
              );
        setState(() {});

        getDetailVideo(widget.id, onSuccess: () {
          setState(() {});
        });
        if (dataBased.type == Types.external) {
          _controller = YoutubePlayerController(
            initialVideoId: Uri.parse(dataBased.url).queryParameters['v']!,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
              hideControls: false,
            ),
          );
        }
        // await getComments(context, dataBased.id.toString(), onSuccess: () {
        //   setState(() {});
        // });
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    CourceBloc.detailVideo.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape && dataBased.type == Types.external) {
      _controller = YoutubePlayerController(
        initialVideoId: Uri.parse(dataBased.url).queryParameters['v']!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          hideControls: false,
        ),
      );
      return YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        onReady: () {},
        onEnded: (end) {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          _controller = YoutubePlayerController(
            initialVideoId: Uri.parse(dataBased.url).queryParameters['v']!,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
              hideControls: false,
            ),
          );
          setState(() {});
        },
      );
    }
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        safeArea: true,
        child: Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: players,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          dataBased.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          dataBased.desc,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: const [
                      Text(
                        'Video Selanjutnya',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: CourceBloc.detailVideo.isEmpty ? 0 : CourceBloc.detailVideo.length,
                      itemBuilder: (context, i) {
                        final data = CourceBloc.detailVideo[i];
                        late YoutubePlayerController _controller;
                        if (data.videoUrl!.contains('youtube.com')) {
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
                                                  dataBased = PlayerC(
                                                    type: Types.internal,
                                                    url: data.videoUrl!,
                                                    desc: data.description!,
                                                    title: data.name!,
                                                    id: data.id.toString(),
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
                                        dataBased = PlayerC(
                                          type: Types.internal,
                                          url: data.videoUrl!,
                                          desc: data.description!,
                                          title: data.name!,
                                          id: data.id.toString(),
                                        );

                                        players = dataBased.type == Types.external
                                            ? YoutubePlayer(
                                                controller: _controller,
                                                showVideoProgressIndicator: true,
                                                progressColors: const ProgressBarColors(
                                                  playedColor: Colors.amber,
                                                  handleColor: Colors.amberAccent,
                                                ),
                                                onReady: () {
                                                  _controller.addListener(() {});
                                                },
                                              )
                                            : BetterPlayer.network(
                                                dataBased.url,
                                                betterPlayerConfiguration: const BetterPlayerConfiguration(
                                                  fit: BoxFit.contain,
                                                ),
                                              );
                                        setState(() {});
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
                                                    const SizedBox(
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
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
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
