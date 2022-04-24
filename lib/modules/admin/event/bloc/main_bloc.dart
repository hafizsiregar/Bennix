import 'package:benix/main_library.dart';
import 'package:benix/modules/admin/event/bloc/model.dart';
import 'package:benix/widget/bloc.dart';
import 'package:benix/widget/model/select_model.dart';

class BlocEventAdd extends Bloc {
  static final List<SelectData> _listFormat = [];
  static final List<SelectData> _listTopik = [];
  static final List<CheckBoxSetting> _settings = [];
  static final List<TicketData> _listTicket = [];

  static List<SelectData> get listFormat => _listFormat;
  static List<SelectData> get listTopik => _listTopik;
  static List<CheckBoxSetting> get checkboxSetting => _settings;
  static List<TicketData> get listTicket => _listTicket;

  static addFormat(data) {
    _listFormat.clear();
    for (var i in data) {
      _listFormat.add(
        SelectData(
          id: i['id'].toString(),
          title: i['name'],
        ),
      );
    }
  }

  static addTopik(data) {
    _listTopik.clear();
    for (var i in data) {
      _listTopik.add(
        SelectData(
          id: i['id'].toString(),
          title: i['name'],
        ),
      );
    }
  }

  static addSetting(data) {
    _settings.clear();
    for (var i in data) {
      _settings.add(
        CheckBoxSetting(
          id: i['id'],
          isLocked: i['is_mandatory'] == '1' ? true : false,
          name: i['name'],
          checked: i['is_mandatory'] == '1' ? true : false,
        ),
      );
    }
  }

  static addTicket(TicketData data) {
    _listTicket.add(
      TicketData(
        startTime: data.startTime,
        endDate: data.endDate,
        endTime: data.endTime,
        harga: data.harga,
        keterangan: data.keterangan,
        name: data.name,
        qty: data.qty,
        startDate: data.startDate,
        id: data.id,
        sertifikat: data.sertifikat,
      ),
    );
  }

  static editTicket(TicketData data) {
    List edit = _listTicket.where((element) => element.id == data.id).toList();

    for (TicketData i in edit) {
      i.endDate = data.endDate;
      i.endTime = data.endTime;
      i.harga = data.harga;
      i.keterangan = data.keterangan;
      i.name = data.name;
      i.qty = data.qty;
      i.startDate = data.startDate;
      i.startTime = data.startTime;
      i.sertifikat = data.sertifikat;
    }
  }

  static deleteTicket(int id) {
    _listTicket.removeWhere((element) => element.id == id);
  }

  @override
  clean() {
    _listFormat.clear();
    _listTopik.clear();
    _settings.clear();
    _listTicket.clear();
  }
}

class BlocEvent extends Bloc {
  static final List<EventData> _listEvent = [];
  static final List<EventData> _filteredEvent = [];
  static final List<EventData> _listNewEvent = [];
  static final List<EventCategories> _listCategories = [];
  static int? _selectedEventId;

  static List<EventData> get listEvent => _listEvent;
  static List<EventData> get listNewEvent => _listNewEvent;
  static List<EventCategories> get listCategories => _listCategories;
  static int? get selectedEventId => _selectedEventId;
  static List<EventData> get filteredEvent => _filteredEvent;

  static selectEvent(int? id) {
    _selectedEventId = id;
  }

  static addCategories(data) {
    _listCategories.clear();
    for (var i in data) {
      _listCategories.add(
        EventCategories(
          id: i['id'],
          name: i['name'],
          icon: i['icon_path'],
        ),
      );
    }
  }

  static selectCategories(id) {
    List<EventCategories> categories = _listCategories.where((element) => element.selected!).toList();
    if (categories.isNotEmpty) {
      categories[0].selected = false;
    }
    List<EventCategories> select = _listCategories.where((element) => element.id == id).toList();
    if (select.isNotEmpty) {
      select[0].selected = true;
    }
  }

  static initEvent(data) {
    _listEvent.clear();
    if (data['data'] != null) {
      for (var i in data['data']) {
        print(i['name']);
        addEvent(i);
      }
    }
  }

  static addEvent(data) {
    if (data != null) {
      _listEvent.add(
        EventData(
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
          sk: data['sk'],
          tages: data['tages'],
          uniqueEmailTransaction: int.parse(data['uniqe_email_transaction']),
          userId: int.parse(data['user_id']),
          locationName: data['location_name'],
          sumPeserta: data['sum_peserta'],
        ),
      );
    }
  }

  static initNewEvent(data) {
    _listNewEvent.clear();
    if (data['data'] != null) {
      for (var i in data['data']) {
        addNewEvent(i);
      }
    }
  }

  static addNewEvent(data) {
    if (data != null) {
      _listNewEvent.add(
        EventData(
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
          sk: data['sk'],
          uniqueEmailTransaction: int.parse(data['uniqe_email_transaction']),
          userId: int.parse(data['user_id']),
          locationName: data['location_name'],
          sumPeserta: data['sum_peserta'],
        ),
      );
    }
  }

  static initEventFilter(data) {
    _filteredEvent.clear();
    if (data['data'] != null) {
      for (var i in data['data']) {
        addEventFilter(i);
      }
    }
  }

  static addEventFilter(data) {
    if (data != null) {
      _filteredEvent.add(
        EventData(
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
          sk: data['sk'],
          uniqueEmailTransaction: int.parse(data['uniqe_email_transaction']),
          userId: int.parse(data['user_id']),
          locationName: data['location_name'],
          sumPeserta: data['sum_peserta'],
        ),
      );
    }
  }

  @override
  clean() {
    _listEvent.clear();
    _filteredEvent.clear();
  }
}
