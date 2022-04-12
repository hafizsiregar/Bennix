class VideoData {
  String? name, episode, videoPath, desc;
  bool? isExtern, isfree;

  VideoData({this.episode, this.name, this.videoPath, this.isExtern = false, this.desc, this.isfree});
}

class ModulData {
  String? name, modulePath, desc;

  ModulData({this.modulePath, this.name, this.desc});
}

class AddVideo {
  String? name, trainer, desc, start, end, videoType, bannerPath, certificatePath, kategori;
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
