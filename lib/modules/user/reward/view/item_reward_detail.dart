import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main_library.dart';

class ItemRewardDetailView extends StatefulWidget {
  final int id;
  const ItemRewardDetailView({Key? key, required this.id}) : super(key: key);

  @override
  State<ItemRewardDetailView> createState() => _ItemRewardDetailViewState();
}

class _ItemRewardDetailViewState extends State<ItemRewardDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: CachedNetworkImageProvider('https://images.tokopedia.net/img/cache/500-square/VqbcmM/2020/9/18/3f28c181-1702-47b0-b9e1-f57d4b34408d.jpg'),
                    fit: BoxFit.cover,
                  )),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height - 260,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 20,
                    offset: Offset(0, -10),
                  )
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Asus ROG Strix',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                '600 ',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Image.asset('assets/icons/coin.png'),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '''Dapatkan Tas Polo Denim di aplikasi Bennix
dengan poin sebanyak 400. Ayo buruan sebelum
kehabisan!''',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Syarat & Ketentuan',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '●  ',
                                      style: TextStyle(
                                        fontSize: 9,
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                      'Anda hanya dapat menukarkan dengan jumlah poin yang sudah ditentukan',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '●  ',
                                      style: TextStyle(
                                        fontSize: 9,
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                      'Kerjakan misi dan kumpulkan poin untuk ditukarkan Tas Polo Denim',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '●  ',
                                    style: TextStyle(
                                      fontSize: 9,
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                    'Tas akan dikirimkan melalui alamat yang kamu sediakan maks. 1 hari kerja',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Button.flat(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    context: context,
                    title: 'Tukarkan Poin',
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    onTap: () {
                      confirmation(
                        buttonText: 'Yakin',
                        context: context,
                        message: 'Apakah kamu yakin menukarkan poin dengan ',
                        item: 'Asus Rog Strix?',
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(FeatherIcons.alertCircle),
                                    Text(
                                      '   Poin anda tidak cukup!',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                          );
                        },
                        title: 'Konfirmasi Penukaran',
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
