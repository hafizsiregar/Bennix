import 'package:benix/modules/admin/dashboard/bloc/main_bloc.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';

getDataDashboard(id, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'events/$id/dashboard',
    replacementId: 41,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        DashboardAdminBloc.parseFromResponse(data['data']);
        onSuccess();
      },
    ),
  );
}

getDetailPeserta(id, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'events/$id/peserta',
    replacementId: 42,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        DashboardAdminBloc.parsePesertaFromResponse(data);
        onSuccess();
      },
    ),
  );
}
