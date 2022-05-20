import 'package:benix/modules/user/register/bloc/model.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';

register({required context, required InputRegister data, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'auth/register',
    replacementId: 5,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'name': data.name,
        'email': data.email,
        'password': data.password,
        'confirm_password': data.confirmPassword,
      },
      onSuccess: (data) {
        onSuccess();
      },
    ),
  );
}
