import 'package:benix/modules/user/paket/model/bloc.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart' show RESTAPI, RequestApiHelperConfigData, RequestData;

Future<String> upgradePaket(context,value) async {
  var stat = '';
  await req.send(
    type: RESTAPI.post,
    name: 'auth/upgrade',
     data: RequestData(
      body: {
        "package_id": value,
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      
      onSuccess: (data) async {
        stat = data['data']['snap_url'];
      },
    ),
  );

  return stat;
}

Future<void> getPaket(context) async {
  await req.send(
    type: RESTAPI.get,
    name: 'packages/ecourse',
    changeConfig: RequestApiHelperConfigData(
      logResponse: true,
      onSuccess: (data) async {
        await PackagesBloc.init(data['data']);
      },
    ),
  );
}
