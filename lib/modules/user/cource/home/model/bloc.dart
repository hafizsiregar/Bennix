import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../../widget/model/select_model.dart';

class CourceBloc {
  static final List<Cource> _data = [];
  static final List<Cource> _closeData = [];
  static List<Cource> get data => _data;
  static List<Cource> get closeData => _closeData;
  static final List<Cource> filterData = [];
  static List<SelectData> category = [];

  static List<Cource> getList({String? filter}) {
    return data.where((element) => element.name!.toUpperCase().contains((filter ?? '').toUpperCase())).toList();
  }

  static List<Cource> getListClose({String? filter}) {
    return closeData.where((element) => element.name!.toUpperCase().contains((filter ?? '').toUpperCase())).toList();
  }

  static parseFilterCategoryFromResponse(data) {
    filterData.clear();
    for (var i in data['data'] ?? []) {
      filterData.add(Cource(
        episodeMin: i['episode_min'].toString(),
        episodeMax: i['episode_max'].toString(),
        bannerUrl: i['banner_url'],
        certificateUrl: i['certificate_url'],
        description: i['description'],
        id: i['id'],
        jumlahModule: i['jumlah_module'],
        jumlahVideo: i['jumlah_video'],
        name: i['name'],
        status: i['status'],
        trainerName: i['trainer_name'],
        userId: i['user_id'].toString(),
        videoType: i['video_type'],
        endDate: DateTime.parse(i['end_date']),
        startDate: DateTime.parse(i['start_date']),
        avgRate: i['avg_rate'].toString() != 'null' ? i['avg_rate'].toString()[0] : null,
        isExternal: i['video_type'],
      ));
    }
  }

  static init(data) {
    _data.clear();
    for (var i in data['data'] ?? []) {
      add(Cource(
        episodeMin: i['episode_min'].toString(),
        episodeMax: i['episode_max'].toString(),
        bannerUrl: i['banner_url'],
        certificateUrl: i['certificate_url'],
        description: i['description'],
        id: i['id'],
        jumlahModule: i['jumlah_module'],
        jumlahVideo: i['jumlah_video'],
        name: i['name'],
        status: i['status'],
        trainerName: i['trainer_name'],
        userId: i['user_id'].toString(),
        videoType: i['video_type'],
        endDate: DateTime.parse(i['end_date']),
        startDate: DateTime.parse(i['start_date']),
        avgRate: i['avg_rate'].toString() != 'null' ? i['avg_rate'].toString()[0] : null,
        isExternal: i['video_type'],
      ));
    }
  }

  static add(Cource data) {
    _data.add(data);
  }

  static initCloseData(data) {
    _closeData.clear();
    for (var i in data['data'] ?? []) {
      addCloseData(Cource(
        episodeMin: i['episode_min'].toString(),
        episodeMax: i['episode_max'].toString(),
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
        avgRate: i['avg_rate'].toString() != 'null' ? i['avg_rate'].toString()[0] : null,
        isExternal: i['video_type'],
      ));
    }
  }

  static addCloseData(Cource data) {
    _closeData.add(data);
  }
}

class DetailEcourceBloc {
  static DetailCource _data = DetailCource();

  static DetailCource get data => _data;

  static Future<void> init(data) async {
    List<CourceVideo> videos = [];
    List<CourceModules> modules = [];
    for (var i in data['course_videos'] ?? []) {
      String? fileName;
      try {
        fileName = await VideoThumbnail.thumbnailFile(
          video: i['video_url'],
          thumbnailPath: (await getTemporaryDirectory()).path,
          timeMs: 0,
          imageFormat: ImageFormat.JPEG,
          maxHeight: 180,
          quality: 100,
        );
      } catch (_) {}

      videos.add(
        CourceVideo(
          courceId: i['course_id'],
          description: i['description'],
          episode: i['episode'],
          id: i['id'],
          isFree: i['is_free'],
          name: i['name'],
          videoUrl: i['video_url'],
          thumnail: fileName,
        ),
      );
    }

    for (var i in data['course_modules'] ?? []) {
      modules.add(
        CourceModules(
          courceId: i['course_id'],
          description: i['description'],
          episode: i['episode'],
          id: i['id'],
          moduleUrl: i['module_url'],
          name: i['name'],
        ),
      );
    }

    _data = DetailCource(
      avgRate: data['avg_rate'].toString() != 'null' ? data['avg_rate'].toString()[0] : null,
      modules: modules,
      rate1: data['rate_1'],
      rate2: data['rate_2'],
      rate3: data['rate_3'],
      rate4: data['rate_4'],
      rate5: data['rate_5'],
      totalRate: data['total_rate'],
      videoType: data['video_type'],
      videos: videos,
    );
  }

  static clear() {
    _data = DetailCource();
  }
}

class CommentsBloc {
  static final List<Comment> _dataComment = [];
  static List<Comment> get data => _dataComment;

  static List<Comment> getList() {
    return data.where((element) => element.chat!.toUpperCase().contains(('').toUpperCase())).toList();
  }

  static init(data) {
    _dataComment.clear();
    // ignore: avoid_print
    for (var i in data['data'] ?? []) {
      add(Comment(id: i['id'], name: i['user']['name'], courseId: i['course_id'], userId: i['user_id'], chat: i['chat'], created: DateTime.parse(i['created_at'])));
    }
  }

  static add(Comment data) {
    _dataComment.add(data);
  }
}
