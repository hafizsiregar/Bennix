import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';

sendMailReset({required context, required email, required Function(String) onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'auth/forgot-password',
    replacementId: 2,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) {
        onSuccess(data['data']['otp_code'].toString());
      },
    ),
  );
}

checkOtp({required context, required email, required otp, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'auth/validate-otp',
    replacementId: 3,
    withLoading: true,
    config: RequestApiHelperData(
      body: {'email': email, 'otp_code': otp},
      onSuccess: (data) {
        onSuccess();
      },
    ),
  );
}

changePassword({required context, required email, required p, required p2, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'auth/change-password',
    replacementId: 4,
    withLoading: true,
    config: RequestApiHelperData(
      body: {'email': email, 'password': p, 'confirm_password': p2},
      onSuccess: (data) {
        onSuccess();
      },
    ),
  );
}
