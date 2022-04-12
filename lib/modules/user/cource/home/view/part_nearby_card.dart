part of 'main_view.dart';

Widget cardNearby(context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Nearby You'),
          Row(
            children: const [
              Text('Lihat Semua'),
              Icon(Icons.arrow_right),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Material(
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
                          const Icon(
                            FeatherIcons.bookmark,
                            size: 16,
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
      )
    ],
  );
}
