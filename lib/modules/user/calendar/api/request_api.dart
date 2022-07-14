import 'dart:convert';

import 'package:benix/modules/user/history/bloc/main_bloc.dart';
import 'package:benix/modules/user/history/bloc/model.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';

Future<void> getUpcomming(context, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'transactions',
    replacementId: 19,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'status': 'ongoing',
      },
      onSuccess: (data) async {
        BlocHistoryEvent.initEvent(data);
        onSuccess();
      },
    ),
  );
}

updateHadir({required context, required HistoryEvent data, required Function onSuccess}) async {
  Map<String, dynamic> body = {'id': data.id, 'is_checkin': data.isCheckin};

  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'transactions/update-status',
    replacementId: 20,
    withLoading: true,
    config: RequestApiHelperData(
      body: body,
      bodyIsJson: true,
      onSuccess: (data) async {
        await getUpcomming(context, onSuccess: () {
          onSuccess();
        });
      },
    ),
  );
}
