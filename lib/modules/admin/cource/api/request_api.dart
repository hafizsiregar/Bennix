import 'dart:convert';
import 'dart:io';

import 'package:benix/modules/admin/cource/model/main_bloc.dart';
import 'package:benix/modules/admin/cource/model/model.dart';
import 'package:benix/modules/user/cource/home/api/request_api.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:benix/widget/upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:request_api_helper/request.dart' as req;
import 'package:request_api_helper/request_api_helper.dart' show BackDark, RESTAPI, Redirects, RequestApiHelperConfigData, RequestData, RequestFileData;
import 'package:intl/intl.dart';
import 'package:request_api_helper/response.dart';

Future<bool> createEcource({required context, required AddVideo data}) async {
  int progress = 0;
  bool status = false;
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
    BackDark(
      view: Redirects(
        widget: UploadProgress(
          progress: () => progress,
          requestBack: true,
        ),
      ),
    ).dialog(context);
  }

  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'courses',
    data: RequestData(
      body: body,
      // rawJson: json.encode(body),
      file: fileUpload[0].isEmpty
          ? null
          : RequestFileData(
              filePath: fileUpload[0],
              fileRequestName: fileUpload[1],
            ),
    ),
    onUploadProgress: fileUpload[0].isEmpty
        ? null
        : (progress, max) {
            progress = 100 - (((max - progress) / max) * 100).round() > 90 ? 90 : 100 - (((max - progress) / max) * 100).round();
          },
    changeConfig: RequestApiHelperConfigData(
      // logResponse: true,
      withLoading: Redirects(toogle: fileUpload[0].isEmpty ? true : false),
      timeout: const Duration(hours: 1),
      successMessage: 'default',
      onSuccess: (data) async {
        // print("STATUS ${data['status']}");
        if (data['status'] == 'ok') {
          status = true;
        }
        progress = 100;
        // status = true;
        await getEcource(context);
        if (fileUpload[0].isEmpty) Navigator.of(context).pop();
      },
    ),
  );

  return status;
}

Future<String?> getCourceAdmin({required context}) async {
  print("USERID ${UserBloc.user.email.toString()}");
  String? url;
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'courses',
    data: RequestData(
      body: {
        'user_id': UserBloc.user.id.toString(),
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      logResponse: true,
      onSuccess: (data) {
        url = data['next_page_url'];
        AdminCourceBloc.init(data);
      },
    ),
  );
  return url;
}

Future<void> detailCourceAdmin({required context, id}) async {
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'courses/$id',
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        AdminCourceBloc.initEdit(data);
      },
    ),
  );
}

Future<void> category({required context}) async {
  await req.send(
    type: RESTAPI.get,
    context: context,
    name: 'misc/categories/ecourse',
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        AddVideoBloc.addKategori(data);
      },
    ),
  );
}

Future<void> deleteCource({required context, id}) async {
  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'courses/$id',
    data: RequestData(
      body: {
        '_method': 'DELETE',
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {
        Navigator.pop(context);
      },
    ),
  );
}

Future<void> deleteCourceVideo({required context, id}) async {
  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'courses/videos/$id',
    data: RequestData(
      body: {
        '_method': 'DELETE',
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {},
    ),
  );
}

Future<void> deleteCourceModule({required context, id}) async {
  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'courses/modules/$id',
    data: RequestData(
      body: {
        '_method': 'DELETE',
      },
    ),
    changeConfig: RequestApiHelperConfigData(
      onSuccess: (data) {},
    ),
  );
}

Future<bool> updateEcource({required context, required Cource data, List<VideoData>? video, List<ModulData>? modul, List<VideoEditData>? videoOld, List<ModulEditData>? modulOld}) async {
  int progress = 0;
  bool status = false;
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

  Response.start(body);
  // Response.start(fileUpload[0]);
  // Response.start(fileUpload[1]);

  BackDark(
    view: Redirects(
      widget: UploadProgress(
        progress: () => progress,
        requestBack: true,
      ),
    ),
  ).dialog(context);

  await req.send(
    type: RESTAPI.post,
    context: context,
    name: 'courses/${data.id}',
    data: RequestData(
      body: body,
      // rawJson: json.encode(body),
      file: fileUpload[0].isEmpty
          ? null
          : RequestFileData(
              filePath: fileUpload[0],
              fileRequestName: fileUpload[1],
            ),
    ),
    onUploadProgress: fileUpload[0].isEmpty
        ? null
        : (progress, max) {
            progress = 100 - (((max - progress) / max) * 100).round() > 90 ? 90 : 100 - (((max - progress) / max) * 100).round();
            print(progress);
          },
    changeConfig: RequestApiHelperConfigData(
      logResponse: true,
      withLoading: Redirects(toogle: false),
      timeout: const Duration(hours: 1),
      successMessage: 'default',
      onSuccess: (data) async {
        print("Data RESP ${data}");
        progress = 100;
        status = true;
        await getEcource(context);
      },
    ),
  );

  return status;
}
