import 'package:benix/main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main_library.dart';
import 'claim_reward.dart';

Widget progressMision() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    decoration: BoxDecoration(
      border: Border.all(width: 1.5, color: Colors.black12),
      borderRadius: const BorderRadius.all(
        Radius.circular(14),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ayo selesaikan misi official!',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Tinggal beberapa langkah lagi, kamu akan menyelasaikan misi ini',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '4',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  '/5',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 60,
              child: LinearProgressIndicator(
                value: (1 / 5) * 4,
                backgroundColor: Colors.black12,
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget doneMission() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    decoration: BoxDecoration(
      border: Border.all(width: 1.5, color: Colors.black12),
      borderRadius: const BorderRadius.all(
        Radius.circular(14),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.purple,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ayo selesaikan misi official!',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Button.flat(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  context: navigatorKey.currentContext!,
                  title: 'Klaim reward kamu',
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  onTap: () {
                    claimReward();
                  },
                )
              ],
            ),
          ),
        ),
        Column(
          children: [
            Text(
              'Selesai',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.green),
            ),
            const Icon(
              Icons.check,
              color: Colors.green,
            )
          ],
        )
      ],
    ),
  );
}

Widget missionWithAction() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    decoration: BoxDecoration(
      border: Border.all(width: 1.5, color: Colors.black12),
      borderRadius: const BorderRadius.all(
        Radius.circular(14),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bagikan aplikasi ini ke tekman!',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'ayo segera bagikan aplikasi ini ke teman kamu, agar kamu bisa mendapatkan poin',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 60,
          child: Button.flat(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            context: navigatorKey.currentContext!,
            title: 'Mulai',
            padding: const EdgeInsets.symmetric(vertical: 8),
            onTap: () {},
          ),
        )
      ],
    ),
  );
}
