import 'package:benix/modules/user/history/bloc/main_bloc.dart';
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
      logResponse: true,
      onSuccess: (data) {
        print("DATA KALENDER $data");
        BlocHistoryEvent.initEvent(data);
      },
    ),
  );
}
