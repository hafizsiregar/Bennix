import 'package:benix/main.dart';
import 'package:benix/main_library.dart';
import 'package:benix/modules/user/cource/home/model/model.dart';
import 'package:benix/modules/user/cource/home/view/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class NewCourse extends StatelessWidget {
  String title;
  List<Cource> list;
  NewCourse({Key? key, required this.list, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final data = list[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    navigatorKey.currentContext!,
                    fadeIn(
                      page: DetailEcourceView(
                        data: data,
                      ),
                    ),
                  );
                },
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(data.bannerUrl ?? ''),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.name ?? ''),
                            Text(data.trainerName ?? ''),
                            Row(
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      FeatherIcons.user,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text('200 Penonton'),
                                  ],
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text((data.avgRate ?? '')),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
