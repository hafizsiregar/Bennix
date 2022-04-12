import 'package:benix/modules/admin/event/bloc/main_bloc.dart';
import 'package:benix/modules/user/home/bloc/model.dart';
import 'package:flutter/widgets.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart' show RESTAPI, Redirects, RequestApiHelperConfigData, RequestData;
import 'package:url_launcher/url_launcher.dart';

Future<void> filterEvent(context, FilterDataEvent data) async {
  Map<String, dynamic> body = {
    'category': data.category,
    'name': data.name,
    'start_price': data.startPrice,
    'location_city': data.locationCity,
    'tomorrow': data.tomorrow,
    'today': data.today,
    'this_week': data.week,
    'from_calender': data.calender,
  };

  await req.send(
    name: 'events',
    context: context,
    type: RESTAPI.get,
    data: RequestData(
      body: body,
    ),
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        BlocEvent.initEventFilter(data['data']);
      },
    ),
  );
}

Future<void> popularEvent(context) async {
  Map<String, dynamic> body = {
    'order_by': 'popular',
  };

  await req.send(
    name: 'events',
    context: context,
    type: RESTAPI.get,
    data: RequestData(
      body: body,
    ),
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        BlocEvent.initEvent(data['data']);
      },
    ),
  );
}

Future<void> newEvent(context) async {
  Map<String, dynamic> body = {
    'order_by': 'new',
  };

  await req.send(
    name: 'events',
    context: context,
    type: RESTAPI.get,
    data: RequestData(
      body: body,
    ),
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        BlocEvent.initNewEvent(data['data']);
      },
    ),
  );
}

Future<List<Widget>> getBanner(context) async {
  final List<Widget> res = [];
  await req.send(
    name: 'misc/banner',
    context: context,
    type: RESTAPI.get,
    changeConfig: RequestApiHelperConfigData(
      withLoading: Redirects(toogle: false),
      onSuccess: (data) {
        for (var i in data['data']) {
          res.add(
            GestureDetector(
              onTap: () {
                launch(i['path']);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    child: Image.network(i['path'],
                        fit: BoxFit.cover, width: double.infinity),
                  ),
                )
              ),
            ),
          );
        }
      },
    ),
  );
  return res;
}
