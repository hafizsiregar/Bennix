import 'package:benix/widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:benix/theme.dart';
import 'package:benix/widget/buttons.dart';
import 'package:google_fonts/google_fonts.dart';

Widget notification({required context, String? title, String? message, Widget? customWidget, String? icon, double? height, Widget? customBody}) {
  return SizedBox(
    height: height ?? 250,
    width: getMaxWidth * 0.9,
    child: Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: const Center(),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      customBody ??
                          Column(
                            children: [
                              Text(
                                title ?? '',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: SizedBox(
                                  height: 55,
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Center(
                                      child: Text(
                                        message ?? '',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      customWidget ?? const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

confirmation({required context, required String message, required String title, required Function onTap, required String buttonText, item}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            notification(
              context: context,
              icon: 'assets/images/confirm.png',
              height: 400,
              customBody: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/confirm.png',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: message,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: item ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button.option(
                        context: context,
                        borderColor: Colors.blue,
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                        color: Colors.transparent,
                        textColor: Colors.blue,
                        child: const Text(
                          'Batal',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Button.flat(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                        context: context,
                        title: buttonText,
                        onTap: () async {
                          onTap();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      });
}
