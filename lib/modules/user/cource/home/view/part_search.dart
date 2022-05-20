part of 'main_view.dart';

enum Waktu { sekarang, besok, mingguini, kosong }

Waktu pilihWaktu = Waktu.sekarang;
DateTime filterDate = DateTime.now();
TextEditingController _price = TextEditingController();
TextEditingController _eventName = TextEditingController();
TextEditingController _lokasi = TextEditingController();

Widget filterCard({required context, Function? onTap, required counter}) {
  return StatefulBuilder(
    builder: (context, setState) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        category(selected: true, context: context),
        const SizedBox(
          height: 26,
        ),
        const Text(
          'Time & Date',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button.option(
                context: context,
                title: 'Sekarang',
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                borderColor: pilihWaktu == Waktu.sekarang ? BaseColor.theme?.borderColor : null,
                color: pilihWaktu == Waktu.sekarang ? BaseColor.theme?.primaryColor : BaseColor.theme?.borderColor,
                textColor: pilihWaktu == Waktu.sekarang ? BaseColor.theme?.textButtonColor : null,
                onTap: () {
                  pilihWaktu = Waktu.sekarang;
                  setState(() {});
                },
              ),
              Button.option(
                context: context,
                title: 'Besok',
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                borderColor: pilihWaktu == Waktu.besok ? BaseColor.theme?.borderColor : null,
                color: pilihWaktu == Waktu.besok ? BaseColor.theme?.primaryColor : BaseColor.theme?.borderColor,
                textColor: pilihWaktu == Waktu.besok ? BaseColor.theme?.textButtonColor : null,
                onTap: () {
                  pilihWaktu = Waktu.besok;
                  setState(() {});
                },
              ),
              Button.option(
                context: context,
                title: 'Minggu ini',
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                borderColor: pilihWaktu == Waktu.mingguini ? BaseColor.theme?.borderColor : null,
                color: pilihWaktu == Waktu.mingguini ? BaseColor.theme?.primaryColor : BaseColor.theme?.borderColor,
                textColor: pilihWaktu == Waktu.mingguini ? BaseColor.theme?.textButtonColor : null,
                onTap: () {
                  pilihWaktu = Waktu.mingguini;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 26),
          child: Button.option(
            context: context,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(
                    FeatherIcons.calendar,
                    color: BaseColor.theme?.captionColor,
                  ),
                ),
                Expanded(
                  child: Text(
                    pilihWaktu != Waktu.kosong ? 'Pilih Tanggal' : DateFormat('d MMM y').format(filterDate),
                    style: TextStyle(
                      color: BaseColor.theme?.captionColor,
                    ),
                  ),
                ),
                Icon(
                  FeatherIcons.chevronRight,
                  color: BaseColor.theme?.captionColor,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            borderColor: BaseColor.theme?.borderColor,
            onTap: () async {
              await showDatePicker(
                context: context,
                firstDate: DateTime(2021),
                initialDate: filterDate,
                lastDate: filterDate.add(const Duration(days: 2000)),
              ).then((value) {
                pilihWaktu = Waktu.kosong;
                if (value != null) filterDate = value;
                setState(() {});
              });
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Location',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            controller: _lokasi,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelStyle: const TextStyle(
                  fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                  color: Colors.grey),
              labelText: 'Cari Lokasi',
              filled: true,
              prefix: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  FeatherIcons.mapPin,
                  size: 14,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Theme.of(context).errorColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: TextFormField(
            // focusNode: myFocusNode,
            keyboardType: TextInputType.number,
            controller: _price,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelStyle: const TextStyle(
                  fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                  color: Colors.grey),
              labelText: 'Dimulai Dari Harga',
              filled: true,
              prefix: const Padding(padding: EdgeInsets.only(right: 8.0), child: Text('Rp')),
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Theme.of(context).errorColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
            style: const TextStyle(color: Colors.black),
            onChanged: (data) {
              if (data.isNotEmpty) {
                currencyFormat(data: data, controller: _price);
                setState(() {});
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            controller: _eventName,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelStyle: const TextStyle(
                  fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                  color: Colors.grey),
              labelText: 'Cari Berdasarkan Nama',
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Theme.of(context).errorColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Button.flat(
          context: context,
          title: 'Cari Event',
          onTap: () async {
            List cat = BlocEvent.listCategories.where((e) => e.selected!).toList();
            await filterEvent(
                context,
                FilterDataEvent(
                  calender: pilihWaktu == Waktu.kosong ? '' : DateFormat('y-MM-dd').format(filterDate),
                  category: cat.isNotEmpty ? cat[0].id.toString() : '',
                  locationCity: _lokasi.text,
                  name: _eventName.text,
                  startPrice: _price.text.replaceAll('.', ''),
                  today: pilihWaktu == Waktu.sekarang ? '1' : '0',
                  tomorrow: pilihWaktu == Waktu.besok ? '1' : '0',
                  week: pilihWaktu == Waktu.mingguini ? '1' : '0',
                ), onSuccess: () {
              Navigator.of(context).pop();
              onTap!();
            });
            // setState(() {});
          },
        ),
      ],
    ),
  );
}

Widget searchCard({required context, required Function navigator, required title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Search Result',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Expanded(
        child: ListView.builder(
          itemCount: BlocEvent.filteredEvent.length,
          itemBuilder: (context, index) {
            final e = BlocEvent.filteredEvent[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () {
                  BlocEvent.selectEvent(e.id);
                  navigator(page: const EventView());
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(14)),
                          image: DecorationImage(
                            image: NetworkImage(e.banner!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              DateFormat('d MMM y HH:mm:ss').format(e.startDate!) + ' - ' + DateFormat('d MMM y HH:mm:ss').format(e.endDate!),
                              style: TextStyle(
                                color: BaseColor.theme?.linkActive,
                              ),
                            ),
                          ),
                          Text(
                            e.name ?? '',
                            style: const TextStyle(
                              fontSize: 19,
                              // color: BaseColor.theme?.linkActive,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      )
    ],
  );
}
