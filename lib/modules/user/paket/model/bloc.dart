
import 'package:benix/modules/user/paket/model/model.dart';

class PackagesBloc {
  
  static final List<Paket> _dataPaket = [];
  static List<Paket> get data => _dataPaket;

  static List<Paket> getList() {
    return data.where((element) => element.title!.toUpperCase().contains(( '').toUpperCase())).toList();
  }

  static init(data) {
    _dataPaket.clear();
    // ignore: avoid_print
    for (var i in data ?? []) {
    print(i['desc']);
      add(Paket(
        id: i['id'],
        title: i['name'],
        bulan: int.parse(i['period']),
        harga: double.parse(i['price']),
       detail: ['Dapat tiket berbayar atau gratis', 'Nonton video gratis']
      ));
    }
  }

  static add(Paket data) {
    _dataPaket.add(data);
  }
}



