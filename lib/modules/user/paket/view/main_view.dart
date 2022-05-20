import 'package:benix/main_library.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:benix/modules/user/paket/api/request_api.dart';
import 'package:benix/modules/user/paket/model/bloc.dart';
import 'package:benix/modules/user/paket/model/model.dart';

class PaketView extends StatefulWidget {
  const PaketView({Key? key}) : super(key: key);

  @override
  _PaketViewState createState() => _PaketViewState();
}

class _PaketViewState extends BaseBackground<PaketView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getPaket(context, onSuccess: () {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: BaseColor.theme?.primaryColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.chevron_left,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            // decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: UserBloc.user.photoProfile == null ? null : DecorationImage(image: NetworkImage(UserBloc.user.photoProfile!), fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        UserBloc.user.name ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Paket anda saat ini: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            UserBloc.user.typeCourse ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.yellow,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "berakhir pada: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            UserBloc.user.expiredDateCourse ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            'Pilihan Paket',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: PackagesBloc.getList().take(10).toList().length,
                            itemBuilder: (context, index) {
                              List<Paket> dataList = PackagesBloc.getList().take(10).toList();
                              Paket data = dataList[index];

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [const Color(0xff08A03C), const Color(0xff08A03C).withOpacity(0.1)],
                                                begin: Alignment.center,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 12.0),
                                                  child: Text(
                                                    data.title.toString(),
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 22,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 12.0),
                                                  child: Text(
                                                    intToCurrency(
                                                      data.harga!.floor(),
                                                    ),
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 22,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 12.0),
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemCount: data.detail!.length,
                                                    itemBuilder: (context, index) {
                                                      final detail = data.detail![index];
                                                      return Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(right: 16.0),
                                                            child: Container(
                                                              width: 4,
                                                              height: 4,
                                                              decoration: const BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              detail,
                                                              style: const TextStyle(
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Button.flat(
                                                  onTap: () async {
                                                    await upgradePaket(context, data.id.toString(), onSuccess: (data) {
                                                      navigator(
                                                        page: WebView(
                                                          url: data,
                                                        ),
                                                      );
                                                    });
                                                  },
                                                  elevation: 2,
                                                  context: context,
                                                  title: 'Beli Paket',
                                                  color: Colors.yellowAccent,
                                                  textColor: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
