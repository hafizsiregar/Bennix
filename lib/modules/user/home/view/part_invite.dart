part of 'main_view.dart';

Widget cardInvite(context) {
  return Material(
    color: BaseColor.theme?.primaryColor?.withOpacity(0.2),
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    child: IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Undang Teman Anda',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // const Text(
                  //   'Get \$20 for Ticket',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.black54,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button.flat(
                    width: 100,
                    context: context,
                    title: 'Undang',
                    color: BaseColor.theme?.primaryColor,
                    padding: const EdgeInsets.all(6),
                    textColor: BaseColor.theme?.textButtonColor,
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 150,
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage('assets/images/invite.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
