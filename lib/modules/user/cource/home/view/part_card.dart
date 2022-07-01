part of 'main_view.dart';

Widget cardHome({required Function navigator, required List<Cource> dataList, setState}) {
  return SizedBox(
    width: double.infinity,
    height: 300,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: dataList.length.clamp(0, 5),
      itemBuilder: (context, index) {
        Cource e = dataList[index];
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () {
              navigator(
                  page: DetailEcourceView(
                data: e,
              )).then((z) {
                setState(() {});
              });
            },
            child: SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 180,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      image: e.bannerUrl == null
                          ? null
                          : DecorationImage(
                              image: NetworkImage(e.bannerUrl!),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    e.name ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    e.trainerName ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        (e.avgRate ?? '') == '0' ? '' : (e.avgRate ?? ''),
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      for (int i = 0; i < (double.parse(e.avgRate.toString()).floor()); i++)
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.orange,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget card2({required Function navigator, required List<Cource> dataList, setState}) {
  return SizedBox(
    width: double.infinity,
    height: 240,
    child: dataList.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Icon(FeatherIcons.layers),
                ),
                Text('Tidak Ada Data Ecource'),
              ],
            ),
          )
        : ListView.builder(
            itemCount: dataList.length.clamp(0, 5),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Cource e = dataList[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    navigator(
                        page: DetailEcourceView(
                      data: e,
                    )).then(() {
                      setState(() {});
                    });
                  },
                  child: SizedBox(
                    width: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 140,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            image: e.bannerUrl == null
                                ? null
                                : DecorationImage(
                                    image: NetworkImage(e.bannerUrl!),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          // child: Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.all(6),
                          //       child: Container(
                          //         decoration: const BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.all(Radius.circular(10)),
                          //         ),
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(6.0),
                          //           child: Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: [
                          //               Text(
                          //                 e.startDate!.day.toString(),
                          //                 style: TextStyle(
                          //                   fontSize: 20,
                          //                   fontWeight: FontWeight.w900,
                          //                   color: BaseColor.theme?.primaryColor,
                          //                 ),
                          //               ),
                          //               Text(
                          //                 DateFormat('MMM').format(e.startDate!),
                          //                 style: TextStyle(
                          //                   fontSize: 11,
                          //                   fontWeight: FontWeight.w500,
                          //                   color: BaseColor.theme?.primaryColor,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding: const EdgeInsets.all(6),
                          //       child: Container(
                          //         decoration: const BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.all(Radius.circular(10)),
                          //         ),
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(6.0),
                          //           child: Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: [
                          //               Image.asset('assets/icons/mark.png'),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          e.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // const SizedBox(
                        //   height: 6,
                        // ),
                        // Row(
                        //   children: [
                        //     for (int i = 0; i < double.parse(e.avgRate ?? '0').floor(); i++)
                        //       Icon(
                        //         Icons.star_purple500_sharp,
                        //         color: Colors.yellow[700],
                        //         size: 20,
                        //       ),
                        //     for (int i = 0 + double.parse(e.avgRate ?? '0').floor(); i < 5; i++)
                        //       const Icon(
                        //         Icons.star_purple500_sharp,
                        //         color: Colors.black26,
                        //         size: 20,
                        //       ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     SingleChildScrollView(
                        //       scrollDirection: Axis.horizontal,
                        //       child: Text(
                        //         (e.jumlahModule.toString()) + ' Modul' + ', ' + e.jumlahVideo.toString() + ' Video' + ', ' + e.episodeMin.toString() + '-' + e.episodeMax.toString() + ' Eps',
                        //         style: TextStyle(
                        //           fontSize: 12,
                        //           color: BaseColor.theme?.captionColor,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
  );
}

Widget cardMMentor({required Function navigator}) {
  return SizedBox(
    width: double.infinity,
    height: 270,
    child: ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 18),
          child: GestureDetector(
            onTap: () {
              // navigator(page: const EventView());
            },
            child: SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.orange[800],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        height: 180,
                        child: CachedNetworkImage(
                          imageUrl: 'https://www.seekpng.com/png/full/76-760594_man-transparent-resolution-smile-man-png.png',
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Mentor Developer',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ),
                  const Text('Programmer'),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
