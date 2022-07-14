import 'package:benix/main_library.dart';
import 'package:benix/modules/user/cource/home/model/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';

Future<void> getEcource(context, {required Function onSuccess, withloading = true}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'courses',
    replacementId: 19,
    withLoading: withloading,
    config: RequestApiHelperData(
      body: {
        'order_by': 'new',
      },
      onSuccess: (data) async {
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

Future<void> getDetailVideo(id, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'courses/videos/detail/$id',
    replacementId: 45,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        await CourceBloc.parseDetailVideo(data);
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
        print(data);
        await CommentsBloc.init(data['data']);
        onSuccess();
      },
    ),
  );
}

saveComment(context, id, value, {required Function onSuccess}) async {
  try {
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
          // await CommentsBloc.init(data['data']);
          onSuccess();
        },
        onError: (data) async {},
        onAuthError: (context) {},
      ),
    );
  } catch (_) {
    print(_);
  }
}

rating(context, id, value, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'courses/rating',
    replacementId: 24,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        "value": value,
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

Future<void> getCategoryEcource({required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'misc/categories/ecourse',
    replacementId: 43,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        CourceBloc.category.clear();
        for (var i in data['data']) {
          CourceBloc.category.add(SelectData(
            id: i['id'].toString(),
            title: i['name'],
            objectData: {
              'icon': i['icon_path'],
            },
          ));
        }
        onSuccess();
      },
    ),
  );
}

Future<void> filterCategoryEcource(id, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'courses',
    replacementId: 44,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'category_id': id,
      },
      onSuccess: (data) async {
        CourceBloc.parseFilterCategoryFromResponse(data);
        onSuccess();
      },
    ),
  );
}
