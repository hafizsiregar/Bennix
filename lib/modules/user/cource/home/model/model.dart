class Cource {
  int? id, jumlahModule, jumlahVideo;
  String? trainerName, name, description, status, userId, videoType, bannerUrl, certificateUrl, isExternal, avgRate, kategori, episodeMin, episodeMax, dipelajari, cocokUntuk, jam, menit;
  DateTime? startDate, endDate;

  Cource({
    this.episodeMin,
    this.episodeMax,
    this.bannerUrl,
    this.certificateUrl,
    this.description,
    this.id,
    this.jumlahModule,
    this.jumlahVideo,
    this.name,
    this.status,
    this.trainerName,
    this.userId,
    this.videoType,
    this.endDate,
    this.startDate,
    this.isExternal,
    this.avgRate,
    this.kategori,
    this.cocokUntuk,
    this.dipelajari,
    this.jam,
    this.menit,
  });
}

class DetailCource {
  String? videoType, avgRate, totalRate, rate1, rate2, rate3, rate4, rate5;
  List<CourceVideo>? videos;
  List<CourceModules>? modules;
  DetailCource({
    this.avgRate,
    this.modules,
    this.rate1,
    this.rate2,
    this.rate3,
    this.rate4,
    this.rate5,
    this.totalRate,
    this.videoType,
    this.videos,
  });
}

class Comment {
  String? name, courseId, userId, chat;
  int? id;
  DateTime? created;
  Comment({
    this.id,
    this.name,
    this.courseId,
    this.userId,
    this.chat,
    this.created,
  });
}

class CourceVideo {
  int? id;
  String? courceId, name, episode, description, isFree, videoUrl, thumnail;

  CourceVideo({this.courceId, this.description, this.episode, this.id, this.isFree, this.name, this.videoUrl, this.thumnail});
}

class CourceModules {
  int? id;
  String? courceId, name, episode, description, moduleUrl;

  CourceModules({this.courceId, this.description, this.episode, this.id, this.moduleUrl, this.name});
}
