import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart' show RESTAPI, Redirects, RequestApiHelperConfigData, RequestData;

Future<String?> sendMailReset({required context, required email}) async {
  String? status;
  await req.send(
    type: RESTAPI.post,
    name: 'auth/forgot-password',
    context: context,
    data: RequestData(body: {
      'email': email,
    }),
    changeConfig: RequestApiHelperConfigData(
      successMessage: 'default',
      onSuccess: (data) {
        status = data['data']['otp_code'].toString();
      },
    ),
  );
  return status;
}

Future<bool> checkOtp({required context, required email, required otp}) async {
  bool status = false;
  await req.send(
    type: RESTAPI.post,
    name: 'auth/validate-otp',
    context: context,
    data: RequestData(body: {'email': email, 'otp_code': otp}),
    changeConfig: RequestApiHelperConfigData(
      withLoading: Redirects(toogle: true),
      successMessage: 'default',
      onSuccess: (data) {
        status = true;
      },
    ),
  );
  return status;
}

Future<bool> changePassword({required context, required email, required p, required p2}) async {
  bool status = false;
  await req.send(
    type: RESTAPI.post,
    name: 'auth/change-password',
    context: context,
    data: RequestData(body: {'email': email, 'password': p, 'confirm_password': p2}),
    changeConfig: RequestApiHelperConfigData(
      withLoading: Redirects(toogle: true),
      successMessage: 'default',
      onSuccess: (data) {
        status = true;
      },
    ),
  );
  return status;
}
