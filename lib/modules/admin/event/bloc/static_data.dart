import 'package:benix/main_library.dart' show Icons;
import 'package:benix/main_route.dart';
import 'package:benix/modules/user/home/bloc/model.dart';

List<DrawerMenu> listDrawer = [
  // DrawerMenu(
  //   title: 'My Profile',
  //   icon: Icons.person_outline,
  //   navigate: null,
  // ),
  // DrawerMenu(
  //   title: 'Premium',
  //   icon: Icons.star_outline,
  //   navigate: null,
  // ),
  // DrawerMenu(
  //   title: 'Message',
  //   icon: Icons.chat_bubble_outline,
  //   navigate: null,
  // ),
  // DrawerMenu(
  //   title: 'History',
  //   icon: Icons.mail_outline,
  //   navigate: null,
  // ),
  // DrawerMenu(
  //   title: 'Transaction',
  //   icon: Icons.help_outline,
  //   navigate: null,
  // ),
  // DrawerMenu(
  //   title: 'Withdraw',
  //   icon: Icons.help_outline,
  //   navigate: null,
  // ),
  DrawerMenu(
    title: 'Kembali Ke Beranda',
    icon: Icons.home,
    navigate: const DashboardView(),
    isRemoved: true,
  ),
];
