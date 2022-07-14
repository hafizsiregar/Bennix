import 'package:benix/main.dart';
import 'package:benix/main_library.dart';
import 'package:benix/modules/user/cource/home/api/request_api.dart';
import 'package:benix/modules/user/cource/home/model/bloc.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

showComment(id) async {
  final TextEditingController _messageController = TextEditingController();
  getComments(navigatorKey.currentContext!, id.toString(), onSuccess: () {
    showModalBottomSheet(
      isScrollControlled: true,
      context: navigatorKey.currentContext!,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return bottom(
            maxHeight: MediaQuery.of(context).size.height,
            context: context,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .35,
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
                Container(
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
                            saveComment(context, id.toString(), _messageController.text.toString(), onSuccess: () {
                              getComments(context, id.toString(), onSuccess: () {
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
              ],
            ),
          );
        });
      },
    );
  });
}
