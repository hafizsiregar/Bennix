import 'package:benix/modules/user/paket/model/bloc.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart' show RESTAPI, RequestApiHelperConfigData, RequestData;

Future<List> upgradePaket(context,value) async {
  var stat = '';
  List datas = [];
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
        
        datas.add({
          'url':data['data']['snap_url']
        });
        // stat = data['data']['snap_url'];
      },
    ),
  );

  return datas;
}

Future<void> getPaket(context) async {
  await req.send(
    type: RESTAPI.get,
    name: 'packages/ecourse',
    changeConfig: RequestApiHelperConfigData(
      
      onSuccess: (data) async {
        await PackagesBloc.init(data['data']);
      },
    ),
  );
}
