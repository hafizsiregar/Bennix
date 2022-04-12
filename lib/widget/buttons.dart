import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';

class Button {
  static Widget flat({
    Function? onTap,
    double? width,
    double? height,
    required BuildContext context,
    Color? color,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    Widget? child,
    Color? textColor,
    String? title,
    bool isCircle = false,
    double? elevation,
    TextStyle? textStyle,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        elevation: elevation ?? 0,
        type: isCircle ? MaterialType.circle : MaterialType.canvas,
        borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(12)),
        color: color ?? BaseColor.theme?.primaryColor,
        child: InkWell(
          onTap: () {
            final FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
            SystemChrome.restoreSystemUIOverlays();
            if (onTap != null) {
              onTap();
            }
          },
          borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(12)),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: Center(
              child: child ??
                  Text(
                    title ?? '',
                    style: textStyle ??
                        TextStyle(
                          color: textColor ?? BaseColor.theme?.textButtonColor,
                          fontSize: Theme.of(context).textTheme.button?.fontSize,
                        ),
                  ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget option({Function? onTap, double? width, double? height, required BuildContext context, Color? color, EdgeInsetsGeometry? padding, BorderRadius? borderRadius, Widget? child, String? title, bool isCircle = false, bool selected = false, Color? borderColor, Color? textColor}) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(12)),
          color: Colors.transparent,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          border: Border.all(
            color: borderColor ?? color ?? BaseColor.theme!.primaryColor!,
            width: 1,
          ),
        ),
        child: Material(
          color: !selected ? (color ?? Colors.transparent) : color ?? BaseColor.theme?.primaryColor,
          borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(12)),
          child: InkWell(
            splashColor: borderColor ?? BaseColor.theme?.primaryColor,
            onTap: () {
              final FocusScopeNode currentScope = FocusScope.of(context);
              if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
              SystemChrome.restoreSystemUIOverlays();
              if (onTap != null) {
                onTap();
              }
            },
            borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(12)),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16),
              child: Center(
                child: child ??
                    Text(
                      title ?? '',
                      style: TextStyle(
                        color: textColor ?? BaseColor.theme?.captionColor,
                        fontWeight: Theme.of(context).textTheme.button?.fontWeight,
                        fontSize: Theme.of(context).textTheme.button?.fontSize,
                      ),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
