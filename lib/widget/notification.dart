import 'package:benix/widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:benix/theme.dart';
import 'package:benix/widget/buttons.dart';

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
              border: Border.all(
                color: Theme.of(context).textTheme.bodyText1!.color!,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: const Center(),
          ),
          Transform.rotate(
            angle: -0.1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const Center(),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        icon ?? 'assets/icon/blocked.gif',
                        width: 70,
                      ),
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

confirmation({required context, required String message, required String title, required Function onTap, required String buttonText}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return notification(
          context: context,
          icon: isDarkTheme ? 'assets/icon/edit_dark.gif' : 'assets/icon/edit_light.gif',
          height: 300,
          customBody: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button.flat(
                    context: context,
                    color: Colors.transparent,
                    child: const Text(
                      'Batal',
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Button.flat(
                    padding: const EdgeInsets.all(10),
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
        );
      });
}
