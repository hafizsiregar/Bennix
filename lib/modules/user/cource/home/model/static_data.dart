import 'package:benix/modules/admin/cource/view/list.dart';
import 'package:benix/modules/user/contact/view/main_view.dart';
import 'package:benix/modules/user/dashboard/view/main_view.dart';
import 'package:benix/modules/user/help/view/main_view.dart';
import 'package:benix/modules/user/home/bloc/model.dart';
import 'package:benix/modules/user/login/view/main_view.dart';
import 'package:benix/modules/user/paket/view/main_view.dart';
import 'package:benix/modules/user/profile/view/profile_ecource.dart';
import 'package:benix/modules/user/setting/view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

List<DrawerMenu> listDrawer = [
  DrawerMenu(
    title: 'Profile Saya',
    icon: Icons.person_outline,
    navigate: const ProfileEcource(),
    needLogin: true,
  ),
  DrawerMenu(
    title: 'Manajemen E-course',
    icon: Icons.manage_search_sharp,
    navigate: const AdminListEcourceView(),
    isRemoved: true,
    needLogin: true,
  ),
  DrawerMenu(
    title: 'Paket E-Course',
    icon: Icons.star_outline,
    navigate: const PaketView(),
  ),
  // DrawerMenu(
  //   title: 'Message',
  //   icon: Icons.chat_bubble_outline,
  //   navigate: null,
  // ),
  DrawerMenu(
    title: 'Acara',
    icon: Icons.calendar_today,
    navigate: const DashboardView(),
  ),
  DrawerMenu(
    title: 'Pengaturan',
    icon: FeatherIcons.settings,
    navigate: const SettingView(),
  ),
  DrawerMenu(
    title: 'Kontak Kami',
    icon: Icons.mail_outline,
    navigate: const ContactView(),
  ),
  DrawerMenu(
    title: 'Bantuan & FAQs',
    icon: Icons.help_outline,
    navigate: const HelpView(),
  ),
  DrawerMenu(
    title: 'Masuk',
    icon: Icons.logout,
    navigate: const LoginView(),
  ),
];
