import 'package:benix/modules/admin/cource/model/model.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:benix/widget/model/select_model.dart';

class AddVideoBloc {
  // static AddVideo _data = AddVideo();
  static final List<VideoData> _videoData = [];
  static final List<ModulData> _moduleData = [];
  static final List<SelectData> _kategori = [];

  // static AddVideo get data => _data;
  static List<VideoData> get videoData => _videoData;
  static List<ModulData> get moduleData => _moduleData;
  static List<SelectData> get ketegori => _kategori;

  static addModule(ModulData data) {
    _moduleData.add(data);
  }

  static add(VideoData data) {
    _videoData.add(data);
  }

  static addKategori(data) {
    _kategori.clear();
    for (var i in data['data'] ?? []) {
      _kategori.add(
        SelectData(
          id: i['id'].toString(),
          title: i['name'],
        ),
      );
    }
  }

  static init() {
    _videoData.clear();
    _moduleData.clear();
  }

  static delete(index) {
    _videoData.removeAt(index);
  }

  static deleteModul(index) {
    _moduleData.removeAt(index);
  }
}

class AdminCourceBloc {
  static final List<Cource> _data = [];
  static Cource _edit = Cource();
  static List<Cource> get data => _data;
  static Cource get edit => _edit;
  static final List<VideoEditData> _videoEditData = [];
  static final List<ModulEditData> _moduleEditData = [];
  static List<VideoEditData> get videoData => _videoEditData;
  static List<ModulEditData> get moduleData => _moduleEditData;
  static List<CourseCategories> _courseCategories = [];
  static List<CourseCategories> get courseCategories => _courseCategories;

  static List<Cource> getList({String? filter}) {
    return data.where((element) => element.name!.toUpperCase().contains((filter ?? '').toUpperCase())).toList();
  }

  static init(data) {
    _data.clear();
    for (var i in data['data'] ?? []) {
      add(Cource(
        bannerUrl: i['banner_url'],
        certificateUrl: i['certificate_url'],
        description: i['description'],
        id: i['id'],
        jumlahModule: i['jumlah_module'],
        jumlahVideo: i['jumlah_video'],
        name: i['name'],
        status: i['status'],
        trainerName: i['trainer_name'],
        userId: i['user_id'],
        videoType: i['video_type'],
        endDate: DateTime.parse(i['end_date']),
        startDate: DateTime.parse(i['start_date']),
        kategori: i['category_id'].toString(),
      ));
    }
  }

  static addCategories(data) {
    _courseCategories.clear();
    for (var i in data) {
      _courseCategories.add(
        CourseCategories(
          id: i['id'],
          name: i['name'],
          icon: i['icon_path'],
        ),
      );
    }
  }

  static selectCategories(id) {
    List<CourseCategories> categories = _courseCategories.where((element) => element.selected!).toList();
    if (categories.isNotEmpty) {
      categories[0].selected = false;
    }
    List<CourseCategories> select = _courseCategories.where((element) => element.id == id).toList();
    if (select.isNotEmpty) {
      select[0].selected = true;
    }
  }

  static initEdit(data) {
    var i = data['data'];
    _edit = Cource(
      bannerUrl: i['banner_url'],
      certificateUrl: i['certificate_url'],
      description: i['description'],
      id: i['id'],
      jumlahModule: i['jumlah_module'],
      jumlahVideo: i['jumlah_video'],
      name: i['name'],
      status: i['status'],
      trainerName: i['trainer_name'],
      userId: i['user_id'],
      videoType: i['video_type'],
      endDate: DateTime.parse(i['end_date']),
      startDate: DateTime.parse(i['start_date']),
      isExternal: i['video_type'],
      kategori: i['category_id'].toString(),
    );

    for (var j in i['course_videos'] ?? []) {
      _videoEditData.add(
        VideoEditData(
          name: j['name'],
          desc: j['description'],
          episode: j['episode'],
          isfree: j['is_free'] == '0' ? false : true,
          videoPath: j['video_url'],
          id: j['id'].toString(),
        ),
      );
    }

    for (var j in i['course_modules'] ?? []) {
      _moduleEditData.add(
        ModulEditData(
          name: j['name'],
          desc: j['description'],
          modulPath: j['_url'],
          id: j['id'].toString(),
        ),
      );
    }
  }

  static add(Cource data) {
    _data.add(data);
  }

  static delete(index) {
    _videoEditData.removeAt(index);
  }

  static deleteModul(index) {
    _moduleEditData.removeAt(index);
  }

  static clean() {
    _data.clear();
  }

  static cleanEdit() {
    _videoEditData.clear();
    _moduleEditData.clear();
  }
}
