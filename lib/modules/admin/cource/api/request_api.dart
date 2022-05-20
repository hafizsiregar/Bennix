import 'dart:convert';
import 'dart:io';

import 'package:benix/main_library.dart';
import 'package:benix/modules/admin/cource/model/main_bloc.dart';
import 'package:benix/modules/admin/cource/model/model.dart';
import 'package:benix/modules/user/cource/home/api/request_api.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:benix/widget/upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';

createEcource({required context, required AddVideo data, required Function onSuccess}) async {
  int progress = 0;
  List<List<String>> fileUpload = [[], []];
  int counter = 0;
  Map<String, String?> body = {
    'name': data.name,
    'trainer_name': data.trainer,
    'description': data.desc,
    'start_date': data.start,
    'end_date': data.end,
    'banner_path': base64Encode(File(data.bannerPath!).readAsBytesSync()),
    'certificate_path': data.certificatePath == null || data.certificatePath == '' ? '' : base64Encode(File(data.certificatePath!).readAsBytesSync()),
    'video_type': data.videoType,
    'category_id': data.kategori,
  };

  for (VideoData i in data.video ?? []) {
    if (!i.isExtern!) {
      fileUpload[0].add(i.videoPath!);
      fileUpload[1].add('videos[$counter]');
      body.addAll({
        'videos_episode[$counter]': i.episode,
        'videos_name[$counter]': i.name,
        'videos_description[$counter]': i.desc,
        'videos_is_free[$counter]': i.isfree! ? '0' : '1',
      });
    } else {
      body.addAll({
        'videos_episode[$counter]': i.episode,
        'videos_name[$counter]': i.name,
        'videos[$counter]': i.videoPath,
        'videos_description[$counter]': i.desc,
        'videos_is_free[$counter]': i.isfree! ? '0' : '1',
      });
    }

    ++counter;
  }
  int counters = 0;
  for (ModulData i in data.modul ?? []) {
    fileUpload[0].add(i.modulePath!);
    fileUpload[1].add('modules[$counters]');
    body.addAll({
      'modules_name[$counters]': i.name,
      'modules_episode[$counters]': '0',
      'modules_description[$counters]': i.desc,
    });

    ++counters;
  }
  if (fileUpload[0].isNotEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return UploadProgress(
          progress: () => progress,
          requestBack: true,
        );
      },
    );
  }

  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'courses',
    replacementId: 34,
    withLoading: true,
    config: RequestApiHelperData(
      body: body,
      file: fileUpload[0].isEmpty
          ? null
          : FileData(
              path: fileUpload[0],
              requestName: fileUpload[1],
            ),
      onSuccess: (data) async {
        progress = 100;
        // status = true;
        getEcource(context, onSuccess: () {});
        if (fileUpload[0].isEmpty) Navigator.of(context).pop();
        onSuccess();
      },
    ),
    onUploadProgress: fileUpload[0].isEmpty
        ? null
        : (progress, max) {
            progress = 100 - (((max - progress) / max) * 100).round() > 90 ? 90 : 100 - (((max - progress) / max) * 100).round();
          },
  );
}

getCourceAdmin({required context, required Function(String) onSuccess}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'courses',
    replacementId: 35,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        'user_id': UserBloc.user.id.toString(),
      },
      onSuccess: (data) async {
        AdminCourceBloc.init(data);
        onSuccess(data['next_page_url']);
      },
    ),
  );
}

Future<void> detailCourceAdmin({required context, id}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'courses/$id',
    replacementId: 36,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        AdminCourceBloc.initEdit(data);
      },
    ),
  );
}

Future<void> category({required context}) async {
  await RequestApiHelper.sendRequest(
    type: Api.get,
    url: 'misc/categories/ecourse',
    replacementId: 37,
    withLoading: true,
    config: RequestApiHelperData(
      onSuccess: (data) async {
        AddVideoBloc.addKategori(data);
      },
    ),
  );
}

Future<void> deleteCource({required context, id}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'courses/$id',
    replacementId: 38,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        '_method': 'DELETE',
      },
      onSuccess: (data) async {
        Navigator.pop(context);
      },
    ),
  );
}

Future<void> deleteCourceVideo({required context, id}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'courses/videos/$id',
    replacementId: 39,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        '_method': 'DELETE',
      },
      onSuccess: (data) async {},
    ),
  );
}

Future<void> deleteCourceModule({required context, id}) async {
  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'courses/modules/$id',
    replacementId: 40,
    withLoading: true,
    config: RequestApiHelperData(
      body: {
        '_method': 'DELETE',
      },
      onSuccess: (data) async {},
    ),
  );
}

updateEcource({required context, required Cource data, List<VideoData>? video, List<ModulData>? modul, List<VideoEditData>? videoOld, List<ModulEditData>? modulOld, required Function onSuccess}) async {
  int progress = 0;
  List<List<String>> fileUpload = [[], []];
  int counter = 0;
  Map<String, String?> body = {
    'name': data.name,
    'trainer_name': data.trainerName,
    'description': data.description,
    'start_date': DateFormat('yyyy-MM-dd').format(data.startDate!),
    'end_date': DateFormat('yyyy-MM-dd').format(data.endDate!),
    'video_type': data.isExternal,
    '_method': 'PUT',
    'category_id': data.kategori,
  };

  if (data.bannerUrl != null) {
    body.addAll({
      'banner_path': base64Encode(File(data.bannerUrl!).readAsBytesSync()),
    });
  }

  if (data.certificateUrl != null) {
    body.addAll({
      'certificate_path': data.certificateUrl == null || data.certificateUrl == '' ? '' : base64Encode(File(data.certificateUrl!).readAsBytesSync()),
    });
  }

  for (VideoData i in video ?? []) {
    if (data.isExternal == 'internal') {
      fileUpload[0].add(i.videoPath!);
      fileUpload[1].add('videos[$counter]');
      body.addAll({
        'videos_episode[$counter]': i.episode,
        'videos_description[$counter]': i.desc,
        'videos_is_free[$counter]': i.isfree! ? '0' : '1',
        'videos_name[$counter]': i.name,
        'videos_id[$counter]': 'null',
      });
    } else {
      body.addAll({
        'videos_episode[$counter]': i.episode,
        'videos_name[$counter]': i.name,
        'videos[$counter]': i.videoPath,
        'videos_description[$counter]': i.desc,
        'videos_is_free[$counter]': i.isfree! ? '0' : '1',
        'videos_id[$counter]': 'null',
      });
    }

    ++counter;
  }
  int counters = 0;
  for (ModulData i in modul ?? []) {
    fileUpload[0].add(i.modulePath!);
    fileUpload[1].add('modules[$counters]');
    body.addAll({
      'modules_name[$counters]': i.name,
      'modules_episode[$counters]': '0',
      'modules_description[$counters]': i.desc,
      'modules_id[$counters]': 'new',
    });

    ++counters;
  }

  for (VideoEditData i in videoOld ?? []) {
    body.addAll({
      'videos_id[$counter]': i.id,
      'videos_episode[$counter]': i.episode,
      'videos_description[$counter]': i.desc,
      'videos_is_free[$counter]': i.isfree! ? '0' : '1',
      'videos_name[$counter]': i.name,
      'videos[$counter]': 'null',
    });

    ++counter;
  }
  for (ModulEditData i in modulOld ?? []) {
    body.addAll({
      'modules_name[$counters]': i.name,
      'modules_episode[$counters]': '0',
      'modules_description[$counters]': i.desc,
      'modules_id[$counters]': i.id,
    });

    ++counters;
  }

  showDialog(
    context: context,
    builder: (context) {
      return UploadProgress(
        progress: () => progress,
        requestBack: true,
      );
    },
  );

  await RequestApiHelper.sendRequest(
    type: Api.post,
    url: 'courses/${data.id}',
    replacementId: 34,
    withLoading: true,
    config: RequestApiHelperData(
      body: body,
      file: fileUpload[0].isEmpty
          ? null
          : FileData(
              path: fileUpload[0],
              requestName: fileUpload[1],
            ),
      onSuccess: (data) async {
        progress = 100;
        // status = true;
        getEcource(context, onSuccess: () {});
        onSuccess();
      },
    ),
    onUploadProgress: fileUpload[0].isEmpty
        ? null
        : (progress, max) {
            progress = 100 - (((max - progress) / max) * 100).round() > 90 ? 90 : 100 - (((max - progress) / max) * 100).round();
          },
  );
}
