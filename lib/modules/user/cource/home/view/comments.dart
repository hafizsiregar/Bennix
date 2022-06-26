import 'package:benix/main_library.dart';
import 'package:benix/modules/user/cource/home/api/request_api.dart';
import 'package:benix/modules/user/cource/home/model/bloc.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsView extends StatefulWidget {
  final Cource data;
  const CommentsView({Key? key, required this.data}) : super(key: key);

  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends BaseBackground<CommentsView> {
  bool isVideo = true;
  final TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('id', timeago.IdMessages());
    Future.delayed(Duration.zero, () async {
      await getComments(context, widget.data.id.toString(), onSuccess: () {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Komentar',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                )),
            actions: [
              SizedBox(),
            ],
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.builder(
                        itemCount: CommentsBloc.getList().take(10).toList().length,
                        itemBuilder: (context, index) {
                          List<Comment> dataList = CommentsBloc.getList().take(10).toList();
                          Comment comment = dataList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(comment.image ?? ''),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '@' + (comment.name ?? ''),
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        timeago.format(comment.created!, locale: 'id'),
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(fontSize: 11),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        comment.chat ?? '',
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 20, right: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: _messageController,
                        // style: const TextStyle(height: 0.5, color: Colors.black),
                        scrollPadding: EdgeInsets.zero,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: "Tambahkan Komentar",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      child: Image.asset('assets/icons/send.png'),
                      onTap: () async {
                        if (_messageController.text == '') {
                          return;
                        }
                        saveComment(context, widget.data.id.toString(), _messageController.text.toString(), onSuccess: () {
                          getComments(context, widget.data.id.toString(), onSuccess: () {
                            _messageController.clear;
                            setState(() {});
                          });
                          setState(() {});
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
