import 'dart:convert';

import 'package:benix/modules/admin/event/bloc/main_bloc.dart';
import 'package:benix/modules/admin/event/bloc/model.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart'
    show RESTAPI, RequestApiHelperConfigData, RequestData;

Future<void> getFormat({required context}) async {
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'misc/format',
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        BlocEventAdd.addFormat(data['data']);
      },
    ),
  );
}

Future<void> getTopik({required context}) async {
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'misc/topics',
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        BlocEventAdd.addTopik(data['data']);
      },
    ),
  );
}

Future<void> getCategory({required context}) async {
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'misc/topics',
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        BlocEvent.addCategories(data['data']);
      },
    ),
  );
}

Future<void> getSettings({required context}) async {
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'misc/buyer-data-setting',
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        BlocEventAdd.addSetting(data['data']);
      },
    ),
  );
}

Future<bool> createEvent(
    {required context, required InputEventData data}) async {
  bool status = false;
  Map body = {
    'banner': data.banner,
    'name': data.name,
    'type': data.type,
    'organizer_name': data.organizerName,
    'organizer_img': data.organizerImg,
    'start_date': data.startDate,
    'end_date': data.endDate,
    'location_type': data.locationType,
    'location_address': data.locationAddress,
    'location_city': data.locationCity,
    'location_lat': data.locationLat,
    'location_long': data.locationLong,
    'max_buy_ticket': data.maxBuyTicket,
    'uniqe_email_transaction': data.uniqueEmailTransaction,
    'description': data.description,
    'categories': data.categories,
    'tages': data.tages,
    'tags': data.tags,
    'tickets': data.tickets,
    'sk': data.sk,
    'buyer_data_settings': data.buyerDataSettings,
    'location_name': data.locationName,
  };

  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'events',
    data: RequestData(
      rawJson: json.encode(body),
    ),
    changeConfig: RequestApiHelperConfigData(
      successMessage: 'default',
      onSuccess: (data) async {
        await getEventAdmin(context: context);
        status = true;
      },
    ),
  );

  return status;
}

Future<bool> updateEvent(
    {required context, required InputEventData data}) async {
  bool status = false;
  Map body = {
    'name': data.name,
    'type': data.type,
    'organizer_name': data.organizerName,
    'start_date': data.startDate,
    'end_date': data.endDate,
    'location_type': data.locationType,
    'location_address': data.locationAddress,
    'location_city': data.locationCity,
    'location_lat': data.locationLat,
    'location_long': data.locationLong,
    'max_buy_ticket': data.maxBuyTicket,
    'uniqe_email_transaction': data.uniqueEmailTransaction,
    'description': data.description,
    'categories': data.categories,
    'tages': data.tages,
    'tags': data.tags,
    'sk': data.sk,
    'tickets': data.tickets,
    'buyer_data_settings': data.buyerDataSettings,
    'location_name': data.locationName,
  };

  if (data.banner != null) {
    body.addAll({
      'banner': data.banner,
    });
  }

  if (data.organizerImg != null) {
    body.addAll({
      'organizer_img': data.organizerImg,
    });
  }

  await req.send(
    type: RESTAPI.put,
    context: context,
    name: 'events/' + data.id.toString(),
    data: RequestData(
      rawJson: json.encode(body),
    ),
    changeConfig: RequestApiHelperConfigData(
      successMessage: 'default',
      onSuccess: (data) async {
        await getEventAdmin(context: context);
        status = true;
      },
    ),
  );

  return status;
}

Future<bool> deleteEvent({required context, required String id}) async {
  bool status = false;
  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'events/' + id,
    data: RequestData(
      body: {
        '_method': 'DELETE',
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      successMessage: 'default',
      onSuccess: (data) async {
        await getEventAdmin(context: context);
        status = true;
      },
    ),
  );

  return status;
}

Future<List<String>> addTags({required context, required String name}) async {
  List<String> status = [];

  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'misc/add-tags',
    data: RequestData(
      body: {
        'name': name,
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        if (data['data'] != null) {
          status = [data['data']['id'].toString(), data['data']['name']];
        }
      },
    ),
  );

  return status;
}

Future<List<String>> getTags({required context, required String name}) async {
  List<String> status = [];
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'misc/tags',
    data: RequestData(
      body: {
        'name': name,
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        if (data['data'] != null) {
          status = [data['data'][0]['id'].toString(), data['data'][0]['name']];
        }
      },
    ),
  );

  return status;
}

Future<Map> detailEvent({required context, required String id}) async {
  Map response = {};
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'events/' + id,
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        response = data;
      },
    ),
  );
  return response;
}

Future<String?> getEventAdmin({required context}) async {
  String? url;
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'events',
    data: RequestData(body: {
      'user_id': UserBloc.user.id.toString(),
    }),
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        BlocEvent.initEvent(data['data']);
        url = data['next_page_url'];
      },
    ),
  );
  return url;
}

Future<String?> getEvent({required context}) async {
  String? url;
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'events',
    data: RequestData(body: {
      'order_by': 'populer',
    }),
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        BlocEvent.initEvent(data['data']);
        url = data['next_page_url'];
      },
    ),
  );
  return url;
}

Future<void> nextEvent({required context, required String url}) async {
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: url,
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {},
    ),
  );
}
