import 'package:benix/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main_library.dart';
import 'item_reward_detail.dart';

Widget itemReward({setState}) {
  return Wrap(
    children: [
      for (int i = 0; i < 3; i++)
        GestureDetector(
          onTap: () {
            Navigator.push(
              navigatorKey.currentContext!,
              MaterialPageRoute(
                builder: (context) => const ItemRewardDetailView(
                  id: 1,
                ),
              ),
            );
          },
          child: Container(
            width: (MediaQuery.of(navigatorKey.currentContext!).size.width * 0.5) - 20,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2020/9/18/3f28c181-1702-47b0-b9e1-f57d4b34408d.jpg',
                  ),
                  Text(
                    'Asus ROG Strix',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text(
                        '600 ',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Image.asset('assets/icons/coin.png'),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
    ],
  );
}
