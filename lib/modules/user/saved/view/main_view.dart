import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../../main_library.dart' show AnimateTransition, BaseBackground, BaseColor, BorderRadius, BouncingScrollPhysics, BoxDecoration, BuildContext, Column, Container, CrossAxisAlignment, DecorationImage, EdgeInsets, Expanded, Icon, InitControl, IntrinsicHeight, Key, ListView, MainAxisAlignment, Material, NetworkImage, Padding, Radius, Responsive, Row, Scaffold, SizedBox, StatefulWidget, Text, TextStyle, Widget;

class SavedView extends StatefulWidget {
  const SavedView({Key? key}) : super(key: key);

  @override
  _SavedViewState createState() => _SavedViewState();
}

class _SavedViewState extends BaseBackground<SavedView> {
  @override
  Widget build(BuildContext context) {
    return AnimateTransition(
      animation: animationTransition!,
      child: InitControl(
        child: Responsive(
          child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: const [
                      Text(
                        'Saved Event',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      itemCount: 1000,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, counter) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Material(
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(
                                        image: NetworkImage('https://i0.wp.com/www.segalization.com/wp-content/uploads/2016/11/Snow-Miku-2017-Module-Featured.jpg?fit=767%2C654&ssl=1'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '1st May - Sat 2:00 PM',
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
                                          const Text('Snow Miku Is Comming Now November'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                FeatherIcons.mapPin,
                                                size: 16,
                                                color: BaseColor.theme?.captionColor,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Surabaya, Indonesia',
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
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          breakPoint: const [380],
        ),
      ),
    );
  }
}
