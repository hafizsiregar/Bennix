import 'package:benix/modules/admin/event/bloc/model.dart';
import 'package:benix/modules/user/history/bloc/model.dart';
import 'package:benix/widget/bloc.dart';
import 'package:intl/intl.dart';

class BlocHistoryEvent extends Bloc {
  static final List<HistoryEvent> _listEvent = [];

  static List<HistoryEvent> get listEvent => _listEvent;

  static initEvent(data) {
    _listEvent.clear();
    if (data['data'] != null) {
      for (var i in data['data']) {
        _listEvent.add(HistoryEvent(
            date: DateTime.parse(i['date']),
            dueDate:
                i['due_date'] == null ? null : DateTime.parse(i['due_date']),
            orderNumber: i['order_number'],
            paymentMethod: i['payment_method'],
            status: i['status'],
            isCheckin: i['is_checkin'],
            total: int.parse(i['total_net'].replaceAll('.00', '')),
            event: addEvent(i['event']),
            id: i['id']));
      }
    }
  }

  static EventData addEvent(data) {
    if (data != null) {
      return EventData(
        banner: data['banner_url'],
        certificate: data['download_certificate'],
        description: data['description'],
        endDate: DateTime.parse(data['end_date']),
        id: data['id'],
        locationAddress: data['location_address'],
        locationCity: data['location_city'],
        locationLat: data['location_lat'],
        locationLong: data['location_long'],
        locationType: data['location_type'],
        maxBuyTicket: int.tryParse(data['max_buy_ticket']),
        name: data['name'],
        organizerImg: data['organizer_img_url'],
        organizerName: data['organizer_name'],
        startDate: DateTime.parse(data['start_date']),
        type: data['type'],
        uniqueEmailTransaction: int.parse(data['uniqe_email_transaction']),
        userId: int.parse(data['user_id']),
        locationName: data['location_name'],
      );
    } else {
      return EventData();
    }
  }

  @override
  clean() {
    _listEvent.clear();
  }
}

class DetailHistoryBloc {
  static DetailHistory _data = DetailHistory();

  static DetailHistory get data => _data;

  static Future<void> init(data) async {
    
    List<DetailTicket> tickets = [];
    //  _data = DetailHistory();
    print("dataa ${_data.eventName}");
    for (var i in data['details'] ?? []) {
    
      tickets.add(
        DetailTicket(
          ticketName: i['ticket']['name'],
          qty: int.parse(i['qty'].toString()),
          price: int.parse(i['price'].replaceAll('.00', '')),
          subTotal: int.parse(i['total'].replaceAll('.00', '')),
          downloadUrl: i['ticket']['certificate_url'],
          fileName: i['ticket']['certificate'],
          nameEncrypt: i['name_encryption'],
        ),
      );
    }
   
    _data = DetailHistory(
      detailTicket: tickets,
      buyerEmail: data['buyer_user']['email'],
      buyerName: data['buyer_user']['name'],
      buyerPhone: data['buyer_user']['phone'] == null ||
              data['buyer_user']['phone'] == 'null'
          ? '-'
          : data['buyer_user']['phone'],
      eventName: data['event']['name'],
      eventPlace: data['event']['location_address'],
      eventdate: DateFormat('yyyy-MM-dd hh:mm')
          .format(DateTime.parse(data['event']['start_date'].toString()))
          .toString(),
      invoicedate: DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(data['date'].toString()))
          .toString(),
      orderNumber: data['order_number'],
      paymentMethod:
          data['payment_method'] == null || data['payment_method'] == 'null'
              ? '-'
              : data['payment_method'],
      status: data['status'],
      billNumber: data['bill_number'],
      billCode: data['bill_code'],
      isCheckin: data['is_checkin'],
      total: int.parse(
        data['total_net'].replaceAll('.00', ''),
      ),
    );
  }

  static clear() {
    _data = DetailHistory();
  }
}
