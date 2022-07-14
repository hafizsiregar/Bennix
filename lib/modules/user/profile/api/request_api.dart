import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:benix/modules/user/login/bloc/model.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';

saveProfileImage({required context, required image, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'auth/update-photo-profile',
    replacementId: 6,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'photo_profile': image,
      },
      onSuccess: (data) {
        UserBloc.save(data['data']);
        onSuccess();
      },
    ),
  );
}

saveProfile({required context, required name, required gender, required date, required phone, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'auth/update',
    replacementId: 7,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'name': name,
        'gender': gender,
        'date_of_birth': date,
        'phone': phone,
      },
      onSuccess: (data) {
        UserBloc.update(
          User(
            email: UserBloc.user.email,
            expiredDateCourse: UserBloc.user.expiredDateCourse,
            gender: gender,
            id: UserBloc.user.id,
            name: name,
            photoProfile: UserBloc.user.photoProfile,
            tanggalLahir: date,
            type: UserBloc.user.type,
            typeCourse: UserBloc.user.typeCourse,
            phone: phone,
          ),
        );
        onSuccess();
      },
    ),
  );
}

updatePassword({required context, required p, required pp, required ppk, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'auth/update-password',
    replacementId: 8,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'password': p,
        'old_password': pp,
        'confirm_password': ppk,
      },
      onSuccess: (data) {
        onSuccess();
      },
    ),
  );
}
