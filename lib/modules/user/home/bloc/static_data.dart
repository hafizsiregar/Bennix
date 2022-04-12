import 'package:benix/main_route.dart';
import 'package:benix/modules/user/contact/view/main_view.dart';
import 'package:benix/modules/user/cource/dashboard/view/main_view.dart';
import 'package:benix/modules/user/help/view/main_view.dart';
import 'package:benix/modules/user/home/bloc/model.dart';
import 'package:benix/modules/user/paket/view/main_view.dart';
import 'package:benix/modules/user/profile/view/profile_ecource.dart';
import 'package:benix/modules/user/setting/view/main_view.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../../main_library.dart' show Icons;

List<DrawerMenu> listDrawer = [
  DrawerMenu(
    title: 'Profile Saya',
    icon: Icons.person_outline,
    navigate: const ProfileEcource(),
    needLogin: true,
  ),
  DrawerMenu(
    title: 'Manajemen Acara',
    icon: Icons.manage_search_sharp,
    navigate: const AdminEventView(),
    isRemoved: true,
    needLogin: true,
  ),
  // DrawerMenu(
  //   title: 'Premium',
  //   icon: Icons.star_outline,
  //   navigate: const PaketView(),
  // ),
  // DrawerMenu(
  //   title: 'Message',
  //   icon: Icons.chat_bubble_outline,
  //   navigate: null,
  // ),
  DrawerMenu(
    title: 'E-Course',
    icon: Icons.play_arrow_outlined,
    navigate: const DashboardCourceView(),
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
