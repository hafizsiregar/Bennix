import 'package:benix/modules/admin/cource/api/request_api.dart';
import 'package:benix/modules/admin/cource/model/main_bloc.dart';
import 'package:benix/modules/admin/cource/model/static_data.dart';
import 'package:benix/modules/admin/cource/view/main_view.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import '../../../../main_library.dart' show AnimateTransition, Animation, AnimationController, BaseBackground, BaseColor, BorderRadius, BouncingScrollPhysics, BoxDecoration, BuildContext, Column, Container, CrossAxisAlignment, CurvedAnimation, Curves, DecorationImage, DrawerBack, EdgeInsets, Expanded, GestureDetector, Icon, Icons, InitControl, InkWell, IntrinsicHeight, Key, ListView, MainAxisAlignment, MainAxisSize, Material, MediaQuery, NetworkImage, Padding, Radius, Row, Scaffold, SizedBox, StatefulWidget, Text, TextStyle, Tween, Widget, getMaxWidth;

class AdminListEcourceView extends StatefulWidget {
  final Animation? animatePosition;
  final AnimationController? animatePositionC;
  const AdminListEcourceView({Key? key, this.animatePosition, this.animatePositionC}) : super(key: key);

  @override
  _AdminListEcourceViewState createState() => _AdminListEcourceViewState();
}

class _AdminListEcourceViewState extends BaseBackground<AdminListEcourceView> {
  Animation? animatePosition;
  AnimationController? animatePositionC;

  getData() async {
    await getCourceAdmin(
        context: context,
        onSuccess: (data) {
          setState(() {});
        });
  }

  @override
  void initState() {
    AdminCourceBloc.clean();
    super.initState();
    animatePositionC = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    Future.delayed(Duration.zero, () {
      animatePosition = Tween(begin: 0.0, end: getMaxWidth * 0.7).animate(CurvedAnimation(parent: animatePositionC!, curve: Curves.easeInOut)
        ..addListener(() {
          setState(() {});
        }));
    });
    getData();
  }

  @override
  void dispose() async {
    AdminCourceBloc.clean();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        doubleClick: true,
        child: Scaffold(
          body: DrawerBack(
            animationController: animatePositionC ?? AnimationController(vsync: this),
            position: animatePosition == null ? 0 : animatePosition!.value,
            navigator: navigator,
            navigatorRemove: navigatorRemove,
            dataMenu: listDrawer,
            child: SizedBox(
              width: getMaxWidth,
              height: MediaQuery.of(context).size.height,
              child: Material(
                child: Column(
                  children: [
                    Material(
                      color: BaseColor.theme?.primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                  onTap: () {
                                    animatePositionC!.forward();
                                  },
                                  child: Icon(
                                    Icons.align_horizontal_left_sharp,
                                    color: BaseColor.theme?.textButtonColor,
                                  ),
                                ),
                                Text(
                                  'Manajemen E-Course',
                                  style: TextStyle(
                                    color: BaseColor.theme?.textButtonColor,
                                  ),
                                ),
                                InkWell(
                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                  onTap: () {
                                    navigator(page: const AddVideoView()).then((value) async {
                                      await getData();
                                    });
                                  },
                                  child: Icon(
                                    FeatherIcons.plus,
                                    color: BaseColor.theme?.textButtonColor,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: GestureDetector(
                                onTap: () async {
                                  await navigator(
                                    page: AddVideoView(
                                      editData: AdminCourceBloc.data[index],
                                    ),
                                  ).then((value) async {
                                    await getData();
                                  });
                                },
                                child: Material(
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                            image: DecorationImage(
                                              image: NetworkImage(AdminCourceBloc.data[index].bannerUrl!),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        DateFormat('d MMM y').format(AdminCourceBloc.data[index].startDate!) + ' - ' + DateFormat('d MMM y').format(AdminCourceBloc.data[index].endDate!),
                                                        style: TextStyle(
                                                          color: BaseColor.theme?.primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(AdminCourceBloc.data[index].name ?? ''),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      FeatherIcons.video,
                                                      size: 16,
                                                      color: BaseColor.theme?.captionColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        (AdminCourceBloc.data[index].jumlahModule.toString()) + ' Modul' + ', ' + AdminCourceBloc.data[index].jumlahVideo.toString() + ' Video',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: BaseColor.theme?.captionColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: AdminCourceBloc.data.length,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
