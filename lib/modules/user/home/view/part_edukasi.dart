part of 'main_view.dart';

Widget cardEdukasi({required Function navigator, setState}) {
  return SizedBox(
    width: double.infinity,
    height: 215,
    child: ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: CourceBloc.data.length.clamp(0, 5),
      itemBuilder: (context, index) {
        Cource e = CourceBloc.data[index];
        return Padding(
          padding: const EdgeInsets.only(right: 18),
          child: GestureDetector(
            onTap: () {
              navigator(
                  page: DetailEcourceView(
                data: e,
              )).then(() {
                setState(() {});
              });
            },
            child: Container(
              width: 270,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(0),
                    width: double.infinity,
                    height: 155,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(e.bannerUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GlassmorphicContainer(
                          alignment: Alignment.center,
                          width: 100,
                          height: 30,
                          padding: EdgeInsets.all(5),
                          blur: 20,
                          border: 1,
                          borderRadius: 5,
                          linearGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 19, 12, 12).withOpacity(0.1),
                                Color.fromARGB(255, 68, 60, 60).withOpacity(0.05),
                              ],
                              stops: const [
                                0.1,
                                1,
                              ]),
                          borderGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFffffff).withOpacity(0.5),
                              const Color((0xFFFFFFFF)).withOpacity(0.5),
                            ],
                          ),
                          child: Text("${e.episodeMin} - ${e.episodeMax} Episode",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  Text(e.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  SizedBox(height: 5),
                  Text(e.trainerName!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ), // ),
        );
      },
    ),
  );
}
