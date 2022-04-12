part of 'main_view.dart';

Widget cardHome({required Function navigator, required List<Cource> dataList, setState}) {
  return SizedBox(
    width: double.infinity,
    height: 240,
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
