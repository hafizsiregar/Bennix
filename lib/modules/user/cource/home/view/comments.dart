import 'package:benix/main_library.dart';
import 'package:benix/modules/user/cource/home/api/request_api.dart';
import 'package:benix/modules/user/cource/home/model/bloc.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'detail.dart';

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
      await getComments(context, widget.data.id.toString());
      setState(() {});
    });
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
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                              )),
                          const Text(
                            'Komentar',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                    itemCount: CommentsBloc.getList().take(10).toList().length,
                    itemBuilder: (context, index) {
                      List<Comment> dataList = CommentsBloc.getList().take(10).toList();
                      Comment comment = dataList[index];
                      return Card(
                        elevation: 0.5,
                        child: ListTile(
                          leading: const Icon(Icons.comment),
                          title: Text(comment.name ?? ''),
                          subtitle: Text(comment.chat ?? ''),
                          // trailing: Text( DateFormat('MMM').format(comment.created!).toUpperCase()),
                          trailing: Text(
                            timeago.format(comment.created!, locale: 'id'),
                            style: const TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: Container(
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: _messageController,
                        style: const TextStyle(height: 0.5, color: Colors.black),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Pesan komentar",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          child: const Icon(Icons.send),
                          onPressed: () async {
                            final bol = await saveComment(context, widget.data.id.toString(), _messageController.text.toString());
                            if (bol) {
                              await getComments(context, widget.data.id.toString());
                              _messageController.clear;
                              setState(() {});
                            }
                          },
                        ))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
