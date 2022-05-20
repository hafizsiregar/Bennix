import 'package:benix/modules/user/paket/model/bloc.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart' show Api, RESTAPI, RequestApiHelper, RequestApiHelperConfigData, RequestData;

upgradePaket(context, value, {required Function(String) onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'auth/upgrade',
    replacementId: 9,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        "package_id": value,
      },
      onSuccess: (data) {
        onSuccess(data['data']['snap_url']);
      },
    ),
  );
}

Future<void> getPaket(context, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'packages/ecourse',
    replacementId: 10,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        await PackagesBloc.init(data['data']);
        onSuccess();
      },
    ),
  );
}
