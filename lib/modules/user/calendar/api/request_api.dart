import 'dart:convert';

import 'package:benix/modules/user/history/bloc/main_bloc.dart';
import 'package:benix/modules/user/history/bloc/model.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart' show RESTAPI, RequestApiHelperConfigData, RequestData;

Future<void> getUpcomming(context) async {
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'transactions',
    data: RequestData(
      body: {
        'status': 'ongoing',
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      
      onSuccess: (data) {
        print("DATA KALENDER $data");
        BlocHistoryEvent.initEvent(data);
      },
    ),
  );
}

Future<bool> updateHadir({required context, required HistoryEvent data}) async {
  bool status = false;
  Map body = {
   'id' : data.id,
   'is_checkin':data.isCheckin
  };

  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'transactions/update-status',
    data: RequestData(
      rawJson: json.encode(body),
    ),
    changeConfig: RequestApiHelperConfigData(
      successMessage: 'default',
      onSuccess: (data) async {
        await getUpcomming(context);
        status = true;
      },
    ),
  );

  return status;
}