import 'dart:convert';
import 'dart:io';

import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:benix/modules/user/profile/api/request_api.dart';
import 'package:benix/modules/user/profile/view/update_password.dart';
import 'package:benix/modules/user/profile/view/update_profile.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../../main_library.dart' show AnimateTransition, BaseBackground, BaseColor, BorderRadius, BoxDecoration, BoxFit, BoxShape, BuildContext, Colors, Column, Container, CrossAxisAlignment, DecorationImage, EdgeInsets, Expanded, GestureDetector, Icon, Image, InitControl, InkWell, IntrinsicHeight, Key, ListView, MainAxisAlignment, MainAxisSize, Material, MediaQuery, Navigator, NetworkImage, Padding, Radius, Responsive, Row, Scaffold, SizedBox, StatefulWidget, Switch, Text, TextStyle, Theme, Widget, getImage;

class ProfileEcource extends StatefulWidget {
  const ProfileEcource({Key? key}) : super(key: key);

  @override
  _ProfileEcourceState createState() => _ProfileEcourceState();
}

class _ProfileEcourceState extends BaseBackground<ProfileEcource> {
  _getImage(context) async {
    final image = await getImage(context);
    final images = base64.encode(File(image!).readAsBytesSync());
    await saveProfileImage(
      context: context,
      image: images,
      onSuccess: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        child: Scaffold(
          body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _getImage(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, image: UserBloc.user.photoProfile == null ? null : DecorationImage(image: NetworkImage(UserBloc.user.photoProfile!), fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        UserBloc.user.name ?? '',
                        style: TextStyle(
                          color: BaseColor.theme?.textButtonColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: BaseColor.theme?.borderColor,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    'PROFIL SAYA',
                    style: TextStyle(
                      color: BaseColor.theme?.captionColor,
                    ),
                  ),
                ),
                InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    navigator(page: const UpdateProfileView());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Perbarui Profile',
                          style: TextStyle(
                            color: BaseColor.theme?.captionColor,
                          ),
                        ),
                        const Icon(FeatherIcons.chevronRight),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    navigator(page: const UpdatePasswordView());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Perbarui Password',
                          style: TextStyle(
                            color: BaseColor.theme?.captionColor,
                          ),
                        ),
                        const Icon(FeatherIcons.chevronRight),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jenis Kelamin',
                        style: TextStyle(
                          color: BaseColor.theme?.captionColor,
                        ),
                      ),
                      Text(
                        UserBloc.user.gender ?? 'Tidak Diketahui',
                        style: TextStyle(
                          color: BaseColor.theme?.captionColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
