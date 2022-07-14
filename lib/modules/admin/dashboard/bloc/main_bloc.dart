class DaftarPeserta {
  String? nama, email, hp, status, foto;

  DaftarPeserta({this.email, this.hp, this.nama, this.status, this.foto});
}

class TablePesertaConfig {
  int lastPage, page;
  String? nextUrl;
  List<DaftarPeserta> data = [];

  TablePesertaConfig({this.lastPage = 1, this.page = 1, this.nextUrl});
}

class DashboardData {
  int pesetaBerbayar, pesertaTidakBayar, pesertaHadir, jumlahPeserta, pesertaTidakHadir;
  TablePesertaConfig table = TablePesertaConfig();
  DashboardData({this.jumlahPeserta = 0, this.pesertaHadir = 0, this.pesertaTidakBayar = 0, this.pesertaTidakHadir = 0, this.pesetaBerbayar = 0});
}

class DashboardAdminBloc {
  static DashboardData data = DashboardData();

  static parseFromResponse(datas) {
    data.jumlahPeserta = datas['jumlah_peserta'] ?? 0;
    data.pesertaHadir = datas['peserta_hadir'] ?? 0;
    data.pesertaTidakBayar = datas['peserta_tidak_bayar'] ?? 0;
    data.pesertaTidakHadir = datas['peserta_tidak_hadir'] ?? 0;
    data.pesetaBerbayar = datas['peserta_berbayar'] ?? 0;
  }

  static parsePesertaFromResponse(datas) {
    data.table.lastPage = datas['data']['last_page'];
    data.table.page = datas['data']['current_page'];
    data.table.nextUrl = datas['data']['next_page_url'];
    data.table.data.clear();
    for (var i in datas['data']['data'] ?? []) {
      data.table.data.add(
        DaftarPeserta(
          email: i['email'],
          hp: i['no_hp'],
          nama: i['nama'],
          status: i['status'] == 'paid' ? 'Premium' : 'Free',
          foto: i['photo_url'],
        ),
      );
    }
  }
}
