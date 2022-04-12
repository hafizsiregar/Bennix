import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:benix/modules/user/login/bloc/model.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart' show RESTAPI, RequestApiHelperConfigData, RequestData;

Future<bool> saveProfileImage({required context, required image}) async {
  bool status = false;
  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'auth/update-photo-profile',
    data: RequestData(
      body: {
        'photo_profile': image,
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      successMessage: 'default',
      onSuccess: (data) async {
        UserBloc.save(data['data']);
        status = true;
      },
    ),
  );
  return status;
}

Future<bool> saveProfile({required context, required name, required gender, required date, required phone}) async {
  bool status = false;
  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'auth/update',
    data: RequestData(
      body: {
        'name': name,
        'gender': gender,
        'date_of_birth': date,
        'phone': phone,
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      successMessage: 'default',
      onSuccess: (data) async {
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
        status = true;
      },
    ),
  );
  return status;
}

Future<bool> updatePassword({required context, required p, required pp, required ppk}) async {
  bool status = false;
  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'auth/update-password',
    data: RequestData(
      body: {
        'password': p,
        'old_password': pp,
        'confirm_password': ppk,
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      successMessage: 'default',
      onSuccess: (data) async {
        status = true;
      },
    ),
  );
  return status;
}
