import 'package:benix/main_library.dart';

class InputEventData {
  String? banner, name, type, organizerName, organizerImg, startDate, endDate, locationType, locationAddress, locationCity, locationLat, locationLong, maxBuyTicket, uniqueEmailTransaction, description, locationName, sumPeserta;
  List categories, tags, tickets, buyerDataSettings;
  int? id;

  InputEventData({this.banner, this.name, this.type, this.organizerName, this.organizerImg, this.startDate, this.endDate, this.locationType, this.locationAddress, this.locationCity, this.locationLat, this.locationLong, this.maxBuyTicket, this.uniqueEmailTransaction, this.description, required this.categories, required this.tags, required this.tickets, required this.buyerDataSettings, this.id, this.locationName, this.sumPeserta});
}

class CheckBoxSetting {
  bool isLocked, checked;
  int? id;
  String? name;

  CheckBoxSetting({this.isLocked = false, this.checked = false, this.id, this.name});
}

class TicketData {
  String? name, keterangan, sertifikat;
  TimeOfDay? startTime, endTime;
  DateTime? startDate, endDate;
  int? qty, harga, id;

  TicketData({this.qty, this.harga, this.name, this.keterangan, this.startDate, this.endDate, this.startTime, this.endTime, this.id, this.sertifikat});
}

class EventData {
  int? id, userId, maxBuyTicket, uniqueEmailTransaction;
  String? banner, name, type, organizerName, organizerImg, locationType, locationAddress, locationCity, locationLat, locationLong, description, locationName, sumPeserta;
  DateTime? startDate, endDate;
  bool? certificate;

  EventData({this.id, this.userId, this.maxBuyTicket, this.uniqueEmailTransaction, this.banner, this.name, this.type, this.organizerName, this.organizerImg, this.locationType, this.locationAddress, this.locationCity, this.locationLat, this.locationLong, this.description, this.startDate, this.endDate, this.certificate, this.locationName, this.sumPeserta});
}

class EventCategories {
  String? icon, name;
  int? id;
  bool? selected;

  EventCategories({this.icon, this.id, this.name, this.selected = false});
}
