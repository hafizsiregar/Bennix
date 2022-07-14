import 'package:benix/modules/admin/event/bloc/main_bloc.dart';
import 'package:benix/modules/admin/event/bloc/model.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';

Future<void> getFormat({required context, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'misc/topics',
    replacementId: 21,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        BlocEventAdd.addFormat(data['data']);
        onSuccess();
      },
    ),
  );
}

Future<void> getTopik({required context, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'misc/topics',
    replacementId: 22,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        BlocEventAdd.addTopik(data['data']);
        onSuccess();
      },
    ),
  );
}

Future<void> getCategory({required context, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'misc/topics',
    replacementId: 23,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        BlocEvent.addCategories(data['data']);
        onSuccess();
      },
    ),
  );
}

Future<void> getSettings({required context, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'misc/buyer-data-setting',
    replacementId: 24,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        BlocEventAdd.addSetting(data['data']);
        onSuccess();
      },
    ),
  );
}

createEvent({required context, required InputEventData data, required Function onSuccess}) async {
  Map<String, dynamic> body = {
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

  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'events',
    replacementId: 25,
    withLoading: true,
    config: RequestApiHelperData(
      body: body,
      bodyIsJson: true,
      onSuccess: (data) async {
        await getEventAdmin(onSuccess: (datas) {
          onSuccess();
        });
      },
    ),
  );
}

updateEvent({required context, required InputEventData data, required Function onSuccess}) async {
  Map<String, dynamic> body = {
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

  await RequestApiHelper.sendRequest(
    type: Api.put,
    url: 'events/' + data.id.toString(),
    replacementId: 26,
    withLoading: true,
    config: RequestApiHelperData(
      body: body,
      bodyIsJson: true,
      onSuccess: (data) async {
        await getEventAdmin(onSuccess: (datas) {
          onSuccess();
        });
      },
    ),
  );
}

deleteEvent({required context, required String id, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'events/' + id,
    replacementId: 27,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        '_method': 'DELETE',
      },
      onSuccess: (data) async {
        await getEventAdmin(onSuccess: (datas) {
          onSuccess();
        });
      },
    ),
  );
}

addTags({required context, required String name, required Function(List<String>) onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'misc/add-tags',
    replacementId: 28,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'name': name,
      },
      onSuccess: (data) async {
        if (data['data'] != null) {
          onSuccess([data['data']['id'].toString(), data['data']['name']]);
        }
      },
    ),
  );
}

getTags({required context, required String name, required Function(List<String>) onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'misc/tags',
    replacementId: 29,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'name': name,
      },
      onSuccess: (data) async {
        if (data['data'].isNotEmpty) {
          onSuccess([data['data'][0]['id'].toString(), data['data'][0]['name']]);
        } else {
          onSuccess([]);
        }
      },
    ),
  );
}

detailEvent({required context, required String id, required Function(Map) onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'events/' + id,
    replacementId: 30,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        onSuccess(data);
      },
    ),
  );
}

getEventAdmin({required Function(String?) onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'events',
    replacementId: 31,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'user_id': UserBloc.user.id.toString(),
      },
      onSuccess: (data) async {
        BlocEvent.initEvent(data['data']);
        onSuccess(data['next_page_url']);
      },
    ),
  );
}

getEvent({required Function(String?) onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'events',
    replacementId: 32,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'order_by': 'populer',
      },
      onSuccess: (data) async {
        BlocEvent.initEvent(data['data']);
        onSuccess(data['next_page_url']);
      },
    ),
  );
}

Future<void> nextEvent({required context, required String url, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: '',
    replacementId: 33,
    withLoading: true,
    config: RequestApiHelperData(
      baseUrl: url,
      body: {
        'order_by': 'populer',
      },
      onSuccess: (data) async {
        onSuccess();
      },
    ),
  );
}
