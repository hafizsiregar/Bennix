import 'package:benix/main_library.dart';
import 'package:benix/modules/user/cource/home/api/request_api.dart';
import 'package:benix/modules/user/cource/home/model/bloc.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

enum Types { external, internal }

class PlayerCource extends StatefulWidget {
  final Types type;
  final String url, title, desc, id;

  const PlayerCource({Key? key, required this.type, required this.url, required this.desc, required this.title, required this.id}) : super(key: key);

  @override
  _PlayerCourceState createState() => _PlayerCourceState();
}

class _PlayerCourceState extends BaseBackground<PlayerCource> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('id', timeago.IdMessages());
    Future.delayed(
      Duration.zero,
      () async {
        if (widget.type == Types.external) {
          _controller = YoutubePlayerController(
            initialVideoId: Uri.parse(widget.url).queryParameters['v']!,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
              hideControls: false,
            ),
          );
        }
        print(widget.id);
        await getComments(context, widget.id.toString());
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape && widget.type == Types.external) {
      _controller = YoutubePlayerController(
        initialVideoId: Uri.parse(widget.url).queryParameters['v']!,
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
            initialVideoId: Uri.parse(widget.url).queryParameters['v']!,
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
                    child: widget.type == Types.external
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
                        : BetterPlayer.network(widget.url),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
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
                      Text(
                        widget.desc,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
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
                        'Komentar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: CommentsBloc.getList().toList().length,
                    itemBuilder: (context, index) {
                      List<Comment> dataList = CommentsBloc.getList().toList();
                      Comment comment = dataList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.name ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              comment.chat ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
