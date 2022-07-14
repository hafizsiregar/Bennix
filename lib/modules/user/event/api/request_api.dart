import 'dart:convert';

import 'package:benix/main_library.dart';
import 'package:benix/main_route.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';

checkout({required context, data, required Function navigator, required Function(bool) onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'transactions/store',
    replacementId: 19,
    withLoading: true,
    config: RequestApiHelperData(
      body: data,
      bodyIsJson: true,
      onSuccess: (data) async {
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
              id: data['data']['transaction']['id'].toString(),
            ),
          );
        }
        onSuccess(true);
      },
    ),
  );
}
