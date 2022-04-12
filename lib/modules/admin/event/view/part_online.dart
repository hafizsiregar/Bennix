part of 'add_event.dart';

Widget onlineLocation(context, control) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: TextFormField(
          // focusNode: myFocusNode,
          controller: control,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelStyle: const TextStyle(
                fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                color: Colors.grey),
            labelText: 'URL Stream',
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
          validator: (data) {
            if (data!.isEmpty) {
              return 'Tidak Boleh Kosong!';
            }
          },
        ),
      ),
    ],
  );
}

Widget offlineLocation(context, TextEditingController alamat,TextEditingController kota,TextEditingController tempat) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: TextFormField(
          // focusNode: myFocusNode,
          controller: alamat,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelStyle: const TextStyle(
                fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                color: Colors.grey),
            labelText: 'Alamat',
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
          validator: (data) {
            if (data!.isEmpty) {
              return 'Tidak Boleh Kosong!';
            }
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: TextFormField(
          // focusNode: myFocusNode,
          controller: tempat,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelStyle: const TextStyle(
                fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                color: Colors.grey),
            labelText: 'Nama Tempat',
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
          validator: (data) {
            if (data!.isEmpty) {
              return 'Tidak Boleh Kosong!';
            }
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: TextFormField(
          // focusNode: myFocusNode,
          controller: kota,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelStyle: const TextStyle(
                fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                color: Colors.grey),
            labelText: 'Kota',
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
          validator: (data) {
            if (data!.isEmpty) {
              return 'Tidak Boleh Kosong!';
            }
          },
        ),
      ),
    ],
  );
}
