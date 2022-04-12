import 'package:benix/widget/bloc.dart';
import 'package:request_api_helper/session.dart';

import 'model.dart';

class UserBloc extends Bloc {
  static User user = User();

  static Future<void> save(data) async {
    user.name = data['name'];
    user.id = data['id'];
    user.email = data['email'];
    user.tanggalLahir = data['date_of_birth'];
    user.phone = data['phone'];
    try {
      if (data['package_ecourse'].length > 0) {
        user.typeCourse = data['package_ecourse'][0]['type'];
        user.expiredDateCourse = data['package_ecourse'][0]['pivot']['end_date'];
      } else {
        user.typeCourse = 'Gratis';
        user.expiredDateCourse = '-';
      }
      user.type = data['type'];
    } catch (_) {}

    user.gender = data['gender'];
    user.photoProfile = data['photo_url'];
    await Session.save('name', user.name);
    await Session.save('course_type', user.typeCourse);
    await Session.save('id', user.id);
    await Session.save('email', user.email);
    await Session.save('type', user.type);
    await Session.save('course_expired', user.expiredDateCourse);
    await Session.save('gender', user.gender);
    await Session.save('photo_profile', user.photoProfile);
    await Session.save('date_of_birth', user.tanggalLahir);
    await Session.save('phone', user.phone);
  }

  static update(User data) async {
    user = data;
    await Session.save('name', user.name);
    await Session.save('course_type', user.typeCourse);
    await Session.save('id', user.id);
    await Session.save('email', user.email);
    await Session.save('type', user.type);
    await Session.save('course_expired', user.expiredDateCourse);
    await Session.save('gender', user.gender);
    await Session.save('photo_profile', user.photoProfile);
    await Session.save('date_of_birth', user.tanggalLahir);
    await Session.save('phone', user.phone);
  }

  static Future<void> load() async {
    user.name = await Session.load('name');
    user.id = await Session.load('id');
    user.email = await Session.load('email');
    user.type = await Session.load('type');
    user.gender = await Session.load('gender');
    user.typeCourse = await Session.load('course_type');
    user.expiredDateCourse = await Session.load('course_expired');
    user.photoProfile = await Session.load('photo_profile');
    user.tanggalLahir = await Session.load('date_of_birth');
    user.phone = await Session.load('phone');
  }

  @override
  clean() {
    user = User();
  }

  static logout() async {
    user = User();
    await Session.delete(
      nameList: [
        'name',
        'id',
        'email',
        'type',
        'gender',
        'photo_profile',
        'token',
        'course_type',
        'course_expired',
        'date_of_birth',
        'phone',
      ],
    );
  }
}
