import 'package:benix/modules/user/cource/home/model/bloc.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart' show RESTAPI, RequestApiHelperConfigData, RequestData;
import 'package:intl/intl.dart';

Future<void> getEcource(context) async {
  await req.send(
    name: 'courses',
    context: context,
    type: RESTAPI.get,
    data: RequestData(
      body: {
        'order_by': 'new',
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        CourceBloc.init(data);
      },
    ),
  );
}

Future<void> getEcourceClose(context) async {
  await req.send(
    name: 'courses',
    context: context,
    type: RESTAPI.get,
    data: RequestData(
      body: {
        'order_by': 'terdekat',
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      
      onSuccess: (data) {
        CourceBloc.initCloseData(data);
      },
    ),
  );
}

Future<void> getDetailEcource(context, id) async {
  await req.send(
    name: 'courses/$id',
    context: context,
    type: RESTAPI.get,
    changeConfig: RequestApiHelperConfigData(
      
      onSuccess: (data) async {
        await DetailEcourceBloc.init(data['data']);
      },
    ),
  );
}

Future<void> getComments(context, id) async {
  await req.send(
    name: 'chats?course_id=$id',
    context: context,
    type: RESTAPI.get,
    changeConfig: RequestApiHelperConfigData(
      
      onSuccess: (data) async {
        await CommentsBloc.init(data['data']);
      },
    ),
  );
}

Future<bool> saveComment(context, id, value) async {
  bool stat = false;
  await req.send(
    name: 'chats',
    context: context,
    type: RESTAPI.post,
    data: RequestData(
      body: {
        "chat": value,
        "course_id": id,
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      
      // successMessage: 'Berhasil Memberi Rating',
      onSuccess: (data) async {
        stat = true;
      },
    ),
  );

  return stat;
}

Future<bool> rating(context, id, value) async {
  bool stat = false;
  await req.send(
    name: 'courses/rating',
    context: context,
    type: RESTAPI.post,
    data: RequestData(
      body: {
        "value": value,
        "course_id": id,
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      
      successMessage: 'Berhasil Memberi Rating',
      onSuccess: (data) async {
        stat = true;
      },
    ),
  );

  return stat;
}
