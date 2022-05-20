import 'package:benix/modules/user/history/bloc/main_bloc.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';

Future<void> getHistory(context, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'transactions',
    replacementId: 17,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        BlocHistoryEvent.initEvent(data);
        onSuccess();
      },
    ),
  );
}

Future<void> getHistoryDetail(context, id, {required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'transactions/show/$id',
    replacementId: 18,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        await DetailHistoryBloc.clear();
        await DetailHistoryBloc.init(data['data']);
        onSuccess();
      },
    ),
  );
}
