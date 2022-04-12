import 'dart:convert';
import 'dart:io';

import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:benix/modules/user/profile/api/request_api.dart';
import 'package:benix/widget/image_picker.dart';
import 'package:flutter/material.dart';

_getImage(context) async {
  final image = await getImage(context);
  final images = base64.encode(File(image!).readAsBytesSync());
  await saveProfileImage(
    context: context,
    image: images,
  );
  Navigator.of(context).pop();
}

Widget profileWidget({required context}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    child: Material(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                await _getImage(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                    image: UserBloc.user.photoProfile == null ? null : DecorationImage(image: NetworkImage(UserBloc.user.photoProfile!), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(UserBloc.user.name ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(UserBloc.user.email ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(UserBloc.user.type ?? ''),
            ),
          ],
        ),
      ),
    ),
  );
}
