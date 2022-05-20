part of 'main_view.dart';

Widget category({counter, bool? selected, required context, state, Function(String)? onTap, ifSearch = false, navigator}) {
  List<EventCategories> limit = BlocEvent.listCategories.take(7).toList();
  limit.add(
    EventCategories(
      name: 'Lainnya',
      id: 99999,
      icon: 'https://raw.githubusercontent.com/afandiyusuf/clone-tokopedia-ui-tutorial/master/assets/category-icon/lihat-semua.png',
    ),
  );

  return SizedBox(
    width: double.infinity,
    height: 180.0,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: limit.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              if (limit[index].id == 99999) {
                await showAllCategory(context, navigator);
                index;
                state(() {});
                return;
              }

              if (!ifSearch) {
                await filterEvent(
                    context,
                    FilterDataEvent(
                      calender: '',
                      category: limit[index].id.toString(),
                      locationCity: '',
                      name: '',
                      startPrice: '',
                      today: '',
                      tomorrow: '',
                      week: '',
                    ),
                    onSuccess: () {});
              } else {
                for (var i in BlocEvent.listCategories.where((element) => element.selected == true).toList()) {
                  i.selected = false;
                }
                limit[index].selected = true;
              }
              if (onTap != null) {
                onTap(limit[index].name!);
              }
              index;
              state(() {});
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Image.network(
                    limit[index].icon!,
                    width: 35,
                    height: 35,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    limit[index].name!,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 10.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

Future showAllCategory(context, navigator) async {
  int counter = 0;
  List<EventCategories> limit = BlocEvent.listCategories.where((element) => element.id != 99999).toList();
  return await showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Semua Kategori',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: limit.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (limit[index].id == 99999) {
                          return;
                        }
                        await filterEvent(
                            context,
                            FilterDataEvent(
                              calender: '',
                              category: limit[index].id.toString(),
                              locationCity: '',
                              name: '',
                              startPrice: '',
                              today: '',
                              tomorrow: '',
                              week: '',
                            ),
                            onSuccess: () {});
                        Navigator.pop(context);
                        resultSearch(limit[index].name, context, navigator);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Image.network(
                              limit[index].icon ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm1N8tGE9JE-BAn4GgYgG6MHCngMqXZKpZYzAUaI8kaPywl-kM_-9Zk8OnNOhmdt1sBjQ&usqp=CAU',
                              width: 35,
                              height: 35,
                              color: Colors.blue,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              limit[index].name!,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 10.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void resultSearch(title, context, navigator) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) => bottom(
      full: true,
      maxHeight: 0.95,
      context: context,
      customChild: StatefulBuilder(
        builder: (context, setState) => Center(child: searchCard(context: context, navigator: navigator, title: title)),
      ),
    ),
  );
}
