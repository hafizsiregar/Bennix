import 'package:benix/modules/user/register/bloc/model.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart' show RESTAPI, RequestApiHelperConfigData, RequestData;

Future<bool> register({required context, required InputRegister data}) async {
  bool status = false;
  await req.send(
    name: 'auth/register',
    type: RESTAPI.post,
    context: context,
    data: RequestData(
      body: {
        'name': data.name,
        'email': data.email,
        'password': data.password,
        'confirm_password': data.confirmPassword,
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      logResponse: true,
      exception: true,
      successMessage: 'default',
      onSuccess: (data) {
        status = true;
      },
    ),
  );
  return status;
}
