import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:benix/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart' show RESTAPI, Redirects, RequestApiHelperConfigData, RequestData, Session;

Future<bool> login({required context, required email, required password}) async {
  bool status = false;
  String? firebaseMessagingToken = await FirebaseMessaging.instance.getToken();

  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'auth/login',
    data: RequestData(
      body: {
        'email': email,
        'password': password,
        'notification_token':firebaseMessagingToken
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      successMessage: 'default',
      authErrorRedirect: Redirects(
        widget: null,
      ),
      onSuccess: (data) async {
        await UserBloc.save(data['data']);
        await Session.save('token', 'Bearer ' + data['credential']);
        status = true;
      },
    ),
  );
  return status;
}

Future<bool> loginGoogle({required context, required email, required member}) async {
  bool status = false;
  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'auth/login/social',
    data: RequestData(
      body: {
        'email': email,
        'name': member,
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      successMessage: 'default',
      
      authErrorRedirect: Redirects(
        widget: null,
      ),
      onSuccess: (data) async {
        await UserBloc.save(data['data']);
        await Session.save('token', 'Bearer ' + data['credential']);
        status = true;
      },
    ),
  );
  return status;
}

class GoogleService {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();

}