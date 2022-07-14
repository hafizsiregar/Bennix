import 'package:benix/main.dart';
import 'package:benix/main_library.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

claimReward() {
  Navigator.push(navigatorKey.currentContext!, fadeIn(page: ClaimRewardView()));
}

class ClaimRewardView extends StatefulWidget {
  const ClaimRewardView({Key? key}) : super(key: key);

  @override
  State<ClaimRewardView> createState() => _ClaimRewardViewState();
}

class _ClaimRewardViewState extends State<ClaimRewardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'Selamat, kamu baru saja menyelesaikan misi ini!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Lengkapi profil mu!',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '+ 1200 poin',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Button.flat(
                    elevation: 5,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    context: navigatorKey.currentContext!,
                    title: 'Klaim Reward',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FeatherIcons.share2,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Share',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
