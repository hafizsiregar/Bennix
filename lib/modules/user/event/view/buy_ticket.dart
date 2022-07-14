import 'package:benix/main_library.dart' show MainAxisSize, BaseColor, BorderRadius, BorderSide, BoxDecoration, BuildContext, Button, Center, Colors, Column, Container, CrossAxisAlignment, EdgeInsets, InputDecoration, Navigator, OutlineInputBorder, Padding, Radius, SizedBox, StatefulBuilder, Text, TextEditingController, TextFormField, TextInputType, TextStyle, Widget, Wrap, bottom, currencyFormat, getMaxWidth, showModalBottomSheet;
import 'package:benix/modules/admin/event/bloc/model.dart';
import 'package:benix/modules/user/event/view/checkout.dart';
import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget buyTicket(context, List<TicketData> ticket, Function navigator) {
  TextEditingController _buy = TextEditingController();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //     color: BaseColor.theme?.borderColor,
        //     borderRadius: const BorderRadius.all(Radius.circular(16)),
        //   ),
        //   padding: const EdgeInsets.all(20),
        //   child: Column(
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: const [
        //           Text(
        //             'CURRENT IN',
        //             style: TextStyle(
        //               fontSize: 14,
        //             ),
        //           ),
        //           Text(
        //             '355/500',
        //             style: TextStyle(
        //               fontSize: 14,
        //             ),
        //           ),
        //         ],
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       ClipRRect(
        //         borderRadius: BorderRadius.circular(15),
        //         child: SizedBox(
        //           height: 10,
        //           child: SfLinearGauge(
        //             orientation: LinearGaugeOrientation.horizontal,
        //             minimum: 0.0,
        //             maximum: 100.0,
        //             showTicks: false,
        //             showLabels: false,
        //             animateAxis: true,
        //             axisTrackStyle: LinearAxisTrackStyle(
        //               thickness: 10,
        //               edgeStyle: LinearEdgeStyle.bothCurve,
        //               borderWidth: 1,
        //               borderColor: Colors.grey[350],
        //               color: Colors.grey[350],
        //             ),
        //             barPointers: const <LinearBarPointer>[
        //               LinearBarPointer(value: 80, thickness: 10, edgeStyle: LinearEdgeStyle.bothCurve, color: Colors.blue),
        //             ],
        //           ),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Row(
        //         children: [
        //           Expanded(
        //             child: Column(
        //               children: const [
        //                 Text(
        //                   'TOTAL IN',
        //                   style: TextStyle(
        //                     fontSize: 10,
        //                   ),
        //                 ),
        //                 Text(
        //                   '500',
        //                   style: TextStyle(
        //                     fontSize: 20,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Expanded(
        //             child: Column(
        //               children: const [
        //                 Text(
        //                   'TOTAL OUT',
        //                   style: TextStyle(
        //                     fontSize: 10,
        //                   ),
        //                 ),
        //                 Text(
        //                   '500',
        //                   style: TextStyle(
        //                     fontSize: 20,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Expanded(
        //             child: Column(
        //               children: const [
        //                 Text(
        //                   'OPENED ENTRIES',
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                     fontSize: 10,
        //                   ),
        //                 ),
        //                 Text(
        //                   '1',
        //                   style: TextStyle(
        //                     fontSize: 20,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Expanded(
        //             child: Column(
        //               children: const [
        //                 Text(
        //                   'CLOSED ENTRIES',
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                     fontSize: 10,
        //                   ),
        //                 ),
        //                 Text(
        //                   '3',
        //                   style: TextStyle(
        //                     fontSize: 20,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        const Center(),
        const Text(
          'Tiket',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 10,
          children: ticket
              .map(
                (e) => Container(
                  width: (getMaxWidth * 0.5) - 40,
                  decoration: BoxDecoration(
                    color: BaseColor.theme?.borderColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        e.name ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Stock : ' + NumberFormat.simpleCurrency(decimalDigits: 0, name: '').format(e.qty)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        e.harga == 0 ? 'Gratis' : ('Rp. ' + NumberFormat.simpleCurrency(decimalDigits: 0, name: '').format(e.harga)),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Tanggal'),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        DateFormat('d MMM y').format(e.startDate!) + ' - ' + DateFormat('d MMM y').format(e.endDate!),
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Button.flat(
                        onTap: () {
                          _showBottom(
                            context: context,
                            controller: _buy,
                            navigator: navigator,
                            id: e.id,
                            remainingQty: e.qty,
                            price: e.harga,
                          );
                        },
                        context: context,
                        title: 'BELI',
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    ),
  );
}

_showBottom({required context, required TextEditingController controller, required Function navigator, int? id, int? remainingQty, int? price}) async {
  await showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) => bottom(
      title: 'Jumlah Tiket Dibeli',
      maxHeight: 0.95,
      context: context,
      child: StatefulBuilder(
        builder: (context, setState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    // focusNode: myFocusNode,
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelStyle: const TextStyle(
                          fontSize: 14.0, //I believe the size difference here is 6.0 to account padding
                          color: Colors.grey),
                      labelText: 'Jumlah Tiket',
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
                    ),
                    style: const TextStyle(color: Colors.black),
                    onChanged: (data) {
                      if (data.isNotEmpty) {
                        currencyFormat(data: data, controller: controller);
                        setState(() {});
                      }
                    },
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Tidak Boleh Kosong!';
                      }
                    },
                  ),
                ),
                Button.flat(
                  context: context,
                  title: 'Proses Tiket',
                  onTap: () {
                    Navigator.of(context).pop();
                    int qtyTiket = int.parse(controller.text);

                    if (qtyTiket <= remainingQty!) {
                      navigator(
                        page: BuyTicket(
                          buyQty: int.parse(controller.text),
                          id: id,
                          price: price,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
