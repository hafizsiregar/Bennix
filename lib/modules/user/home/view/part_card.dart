part of 'main_view.dart';

Widget cardHome({required Function navigator}) {
  return SizedBox(
    width: double.infinity,
    height: 215,
    child: ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: BlocEvent.listEvent.length.clamp(0, 5),
      itemBuilder: (context, index) {
        EventData e = BlocEvent.listEvent[index];
        return Padding(
          padding: const EdgeInsets.only(right: 18),
          child: GestureDetector(
            onTap: () {
              BlocEvent.selectEvent(e.id);
              navigator(page: const EventView());
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
                        image: NetworkImage(e.banner!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GlassmorphicContainer(
                              alignment: Alignment.center,
                              width: 50,
                              height: 20,
                              padding: EdgeInsets.all(5),
                              blur: 20,
                              border: 1,
                              borderRadius: 5,
                              linearGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFFffffff).withOpacity(0.1),
                                    const Color(0xFFFFFFFF).withOpacity(0.05),
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
                              child: Text(
                                e.locationType == 'offline'
                                    ? (e.locationAddress ?? '')
                                    : 'Online',
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
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
                  Row(
                    children: <Widget>[
                      Text(
                        (e.startDate == null
                                ? 'Undefined'
                                : DateFormat('d MMM HH:mm')
                                    .format(e.startDate!)) +
                            ' - ' +
                            (e.endDate == null
                                ? 'Undefined'
                                : DateFormat('d MMM HH:mm').format(e.endDate!)),
                        style: GoogleFonts.poppins(
                            fontSize: 12, 
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ), // ),
        );
      },
    ),
  );
}
