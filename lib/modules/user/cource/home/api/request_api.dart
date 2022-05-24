import 'package:benix/modules/user/cource/home/model/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';

Future<void> getEcource(context, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'courses',
    replacementId: 19,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'order_by': 'new',
      },
      onSuccess: (data) async {
        print(data);
        CourceBloc.init(data);
        onSuccess();
      },
    ),
  );
}

Future<void> getEcourceClose(context, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'courses',
    replacementId: 20,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'order_by': 'terdekat',
      },
      onSuccess: (data) async {
        print(data);
        CourceBloc.initCloseData(data);
        onSuccess();
      },
    ),
  );
}

Future<void> getDetailEcource(context, id, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'courses/$id',
    replacementId: 21,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        await DetailEcourceBloc.init(data['data']);
        onSuccess();
      },
    ),
  );
}

Future<void> getComments(context, id, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'chats',
    replacementId: 22,
    withLoading: true,
    config: RequestApiHelperData(
      body: {'course_id': id},
      onSuccess: (data) async {
        await CommentsBloc.init(data['data']);
        onSuccess();
      },
    ),
  );
}

saveComment(context, id, value, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'chats',
    replacementId: 23,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        "chat": value,
        "course_id": id,
      },
      onSuccess: (data) async {
        await CommentsBloc.init(data['data']);
        onSuccess();
      },
    ),
  );
}

rating(context, id, value, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'courses/rating',
    replacementId: 24,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        "chat": value,
        "course_id": id,
      },
      onSuccess: (data) async {
        Fluttertoast.showToast(msg: 'Berhasil Memberi Rating');
        await CommentsBloc.init(data['data']);
        onSuccess();
      },
    ),
  );
}
