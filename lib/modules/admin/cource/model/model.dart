class VideoData {
  int? id;
  String? name, episode, videoPath, desc, networkPath, thumnail, networkThumnail;
  bool? isExtern, isfree;
  List<VideoData>? detailVideo;

  VideoData({this.episode, this.name, this.videoPath, this.isExtern = false, this.desc, this.isfree, this.detailVideo, this.id, this.networkPath, this.thumnail, this.networkThumnail});
}

class ModulData {
  String? name, modulePath, desc;

  ModulData({this.modulePath, this.name, this.desc});
}

class AddVideo {
  String? name, trainer, desc, start, end, videoType, bannerPath, certificatePath, kategori, dipelajari, cocokUntuk, jam, menit;
  List<VideoData>? video;
  List<ModulData>? modul;

  AddVideo({
    this.bannerPath,
    this.certificatePath,
    this.desc,
    this.end,
    this.name,
    this.start,
    this.trainer,
    this.video,
    this.videoType,
    this.modul,
    this.kategori,
    this.cocokUntuk,
    this.dipelajari,
    this.jam,
    this.menit,
  });
}

class VideoEditData {
  String? name, episode, videoPath, desc, id;
  bool? isfree;

  VideoEditData({this.episode, this.name, this.videoPath, this.desc, this.isfree, this.id});
}

class ModulEditData {
  String? name, episode, modulPath, desc, id;
  bool? isfree;

  ModulEditData({this.episode, this.name, this.modulPath, this.desc, this.id});
}

class CourseCategories {
  String? icon, name;
  int? id;
  bool? selected;

  CourseCategories({this.icon, this.id, this.name, this.selected = false});
}
