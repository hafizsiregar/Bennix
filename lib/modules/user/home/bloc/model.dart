import 'package:benix/main_library.dart' show IconData, Widget;

class DrawerMenu {
  String? title;
  IconData? icon;
  Function? onTap, customFunction;
  Widget? navigate;
  bool? locked, isRemoved, needLogin;

  DrawerMenu({this.icon, this.locked, this.onTap, this.title, this.customFunction, this.navigate, this.isRemoved, this.needLogin});
}

class FilterDataEvent {
  String? category, name, startPrice, locationCity, tomorrow, today, week, calender;

  FilterDataEvent({this.category, this.name, this.startPrice, this.locationCity, this.tomorrow, this.today, this.week, this.calender});
}
