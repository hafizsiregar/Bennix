import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';
import 'package:request_api_helper/session.dart';

login({required context, required email, required password, required Function onSuccess}) async {
  String? firebaseMessagingToken = await FirebaseMessaging.instance.getToken();
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'auth/login',
    replacementId: 11,
    withLoading: true,
    config: RequestApiHelperData(
      onAuthError: (context) {},
      body: {'email': email, 'password': password, 'notification_token': firebaseMessagingToken},
      onSuccess: (data) async {
        await UserBloc.save(data['data']);
        await Session.save(header: 'token', stringData: 'Bearer ' + data['credential']);
        onSuccess();
      },
    ),
  );
}

loginGoogle({required context, required email, required member, required Function onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'auth/login/social',
    replacementId: 12,
    withLoading: true,
    config: RequestApiHelperData(
      onAuthError: (context) {},
      body: {
        'email': email,
        'name': member,
      },
      onSuccess: (data) async {
        await UserBloc.save(data['data']);
        await Session.save(header: 'token', stringData: 'Bearer ' + data['credential']);
        onSuccess();
      },
    ),
  );
}

class GoogleService {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}
