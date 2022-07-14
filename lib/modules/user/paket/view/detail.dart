import 'package:benix/main_library.dart';
import 'package:benix/modules/user/login/bloc/main_bloc.dart';
import 'package:benix/modules/user/paket/model/model.dart';

class PaketDetailView extends StatefulWidget {
  final Paket data;
  const PaketDetailView({Key? key, required this.data}) : super(key: key);

  @override
  _PaketDetailViewState createState() => _PaketDetailViewState();
}

class _PaketDetailViewState extends BaseBackground<PaketDetailView> {
  @override
  void initState() {
    super.initState();
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
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                          decoration: const BoxDecoration(
                            // gradient: LinearGradient(
                            //   // colors: widget.data.color,
                            //   begin: Alignment.center,
                            //   end: Alignment.bottomRight,
                            // ),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Text(
                                  widget.data.title ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.data.detail!.length,
                                  itemBuilder: (context, index) {
                                    final data = widget.data.detail![index];
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
                                            data,
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
                              // Button.flat(
                              //   context: context,
                              //   title: '${widget.data.bulan} Bulan - ${widget.data.title} Rp ' +
                              //       intToCurrency(
                              //         // widget.data.harga!.floor(),
                              //       ),
                              //   color: const Color(0xffFFBDAE),
                              //   textColor: Colors.black,
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Button.flat(
                              context: context,
                              elevation: 6,
                              title: 'Beli',
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Color(0xffF8754F),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              width: 150,
                              color: const Color(0xffFFEA79),
                              textColor: const Color(0xffF8754F),
                            ),
                          ],
                        )
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
