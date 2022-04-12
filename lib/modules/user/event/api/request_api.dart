import 'dart:convert';

import 'package:benix/main_library.dart';
import 'package:benix/main_route.dart';
// import 'package:benix/widget/webview.dart';
// import 'package:flutter/cupertino.dart' show Navigator;
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart' show RESTAPI, RequestApiHelperConfigData, RequestData;

Future<bool> checkout({required context, data, required Function navigator}) async {
  bool status = false;

  await req.send(
    type: RESTAPI.post,
    name: 'transactions/store',
    context: context,
    data: RequestData(
      rawJson: json.encode(data),
    ),
    changeConfig: RequestApiHelperConfigData(
      successMessage: 'default',
      onSuccess: (data) {
        if (data['data']['snap_url'] == null || data['data']['snap_url'] == '') {
          Navigator.pushAndRemoveUntil(
              context,
              fadeIn(
                  page: const DashboardView(
                selectedPage: 1,
              )),
              (route) => false);
          return;
        } else {
          navigator(
            page: WebView(
              url: data['data']['snap_url'],
            ),
          );
        }
        status = true;
      },
    ),
  );

  return status;
}
