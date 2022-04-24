import 'package:benix/modules/user/history/bloc/main_bloc.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart' show RESTAPI, RequestApiHelperConfigData, RequestData;

Future<void> getHistory(context) async {
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'transactions',
    data: RequestData(
      body: {},
    ),
    changeConfig: RequestApiHelperConfigData(
      
      onSuccess: (data) {
        BlocHistoryEvent.initEvent(data);
      },
    ),
  );
}

Future<void> getHistoryDetail(context, id) async {
  await req.send(
    name: 'transactions/show/$id',
    context: context,
    type: RESTAPI.get,
    changeConfig: RequestApiHelperConfigData(
      // 
      onSuccess: (data) async {
        await DetailHistoryBloc.clear();
        await DetailHistoryBloc.init(data['data']);
      },
    ),
  );
}
