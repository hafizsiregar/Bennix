import 'package:benix/modules/admin/event/bloc/model.dart';

class HistoryEvent {
  EventData? event;
  String? orderNumber, status, paymentMethod;
  int? total, id;
  DateTime? date, dueDate;

  HistoryEvent({this.id, this.event, this.date, this.dueDate, this.orderNumber, this.paymentMethod, this.status, this.total});
}

class DetailHistory {
  String? orderNumber, status, paymentMethod, buyerName, buyerEmail, buyerPhone, eventName, eventPlace, eventdate, invoicedate;
  int? total;
  DateTime? dueDate;
  List<DetailTicket>? detailTicket;

  DetailHistory({this.detailTicket, this.invoicedate, this.dueDate, this.orderNumber, this.paymentMethod, this.status, this.total, this.buyerName, this.buyerEmail, this.buyerPhone, this.eventName, this.eventPlace, this.eventdate});
}

class DetailTicket {
  String? ticketName, downloadUrl,fileName,nameEncrypt;
  int? price, qty, subTotal;

  DetailTicket({this.ticketName, this.price, this.qty, this.subTotal, this.downloadUrl,this.fileName,this.nameEncrypt});
}
