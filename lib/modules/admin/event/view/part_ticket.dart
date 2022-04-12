part of 'add_ticket.dart';

Widget ticketWidget({title, deskripsi, tanggal, harga, jumlah}) {
  return SizedBox(
    width: double.infinity,
    child: Stack(children: [
      Positioned(
        top: 10,
        left: 30,
        child: Container(
          width: getMaxWidth - (getMaxWidth * 0.3),
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: BaseColor.theme!.captionColor!),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      Positioned(
        left: 10,
        top: 45,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: BaseColor.theme!.captionColor!),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        left: 80,
        top: 0,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: BaseColor.theme!.captionColor!),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        left: 80,
        bottom: 0,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: BaseColor.theme!.captionColor!),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        left: 87,
        top: 25,
        child: SizedBox(
          width: 2,
          height: 85,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  width: 2,
                  height: 10,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 12,
                child: Container(
                  width: 2,
                  height: 10,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 24,
                child: Container(
                  width: 2,
                  height: 10,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 36,
                child: Container(
                  width: 2,
                  height: 10,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 48,
                child: Container(
                  width: 2,
                  height: 10,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 60,
                child: Container(
                  width: 2,
                  height: 10,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 72,
                child: Container(
                  width: 2,
                  height: 10,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 84,
                child: Container(
                  width: 2,
                  height: 10,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 82,
                child: Container(
                  width: 2,
                  height: 10,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        left: 60,
        top: 25,
        child: SizedBox(
          width: 20,
          height: 85,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 5,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 10,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 15,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 20,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 25,
                child: Container(
                  width: 20,
                  height: 5,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 32,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 35,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 40,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 47,
                child: Container(
                  width: 20,
                  height: 5,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 55,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 65,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 70,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 75,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
              Positioned(
                top: 80,
                child: Container(
                  width: 20,
                  height: 3,
                  color: BaseColor.theme?.borderColor,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: getMaxWidth,
        height: 10,
        color: Colors.white,
      ),
      Container(
        width: 30,
        height: 140,
        color: Colors.white,
      ),
      Positioned(
        bottom: 0,
        child: Container(
          width: getMaxWidth,
          height: 10,
          color: Colors.white,
        ),
      ),
      Positioned(
        top: 20,
        left: 100,
        child: SizedBox(
          width: 170,
          height: 100,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Berakhir tanggal $tanggal',
                  style: const TextStyle(
                    fontSize: 8,
                  ),
                ),
                Text(
                  title,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    (harga ?? '') + ' | ' + (jumlah ?? '') + ' Ticket',
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  ),
                ),
                Text(
                  deskripsi,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]),
  );
}
