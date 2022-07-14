import 'package:benix/modules/admin/event/bloc/main_bloc.dart';
import 'package:benix/modules/user/home/bloc/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> filterEvent(context, FilterDataEvent data, {required Function onSuccess}) async {
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

  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'events',
    replacementId: 13,
    config: RequestApiHelperData(
      body: body,
      onSuccess: (data) async {
        BlocEvent.initEventFilter(data['data']);
        onSuccess();
      },
    ),
  );
}

Future<void> popularEvent(context, {required Function onSuccess}) async {
  Map<String, dynamic> body = {
    'order_by': 'populer',
  };

  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'events',
    replacementId: 14,
    withLoading: true,
    config: RequestApiHelperData(
      body: body,
      onSuccess: (data) async {
        BlocEvent.initEvent(data['data']);
        onSuccess();
      },
    ),
  );
}

Future<void> newEvent(context, {required Function onSuccess}) async {
  Map<String, dynamic> body = {
    'order_by': 'new',
  };

  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'events',
    replacementId: 15,
    withLoading: true,
    config: RequestApiHelperData(
      body: body,
      onSuccess: (data) async {
        BlocEvent.initNewEvent(data['data']);
        onSuccess();
      },
    ),
  );
}

Future<void> getBanner(context, {required Function(List<Widget>) onSuccess}) async {
  final List<Widget> res = [];
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'misc/banner',
    replacementId: 16,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        for (var i in data['data']) {
          res.add(
            GestureDetector(
              onTap: () {
                launchUrl(i['path']);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(i['path']),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        // BlocEvent.initNewEvent(data['data']);
        onSuccess(res);
      },
    ),
  );
}
