import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:benix/main_library.dart';
import 'package:benix/theme.dart';

class Forms {
  static normal({
    TextEditingController? controller,
    String? hintText,
    String? title,
    TextInputType? keyboardType,
    TextAlign? textAlign,
    FocusNode? focusNode,
    bool? enabled,
    ValueChanged<String>? onChanged,
    Function? onSubmited,
    VoidCallback? onEditingComplete,
    GestureTapCallback? onTap,
    FormFieldValidator<String>? validator,
    Widget? prefixIcon,
    bool? suffixIcon,
    Widget? customSuffixIcon,
    bool? obsecureText,
    Color? color,
    Color? fillColor,
    Color? allColor,
    int? maxLength,
    int? height,
    BoxShadow? boxShadow,
    BorderRadius? borderRadius,
    BorderSide? border,
    String? counterText,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title == null
              ? const SizedBox()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: allColor ?? color ?? Theme.of(context).textTheme.bodyText2!.color,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: allColor ?? color ?? Theme.of(context).textTheme.bodyText2!.color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            textAlign: textAlign ?? TextAlign.left,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: hintText ?? '',
              counterText: counterText,
              hintStyle: TextStyle(
                fontFamily: 'Roboto',
                color: allColor ?? color ?? Colors.black26,
                fontSize: 14,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: customSuffixIcon ?? (suffixIcon != null && suffixIcon ? (controller != null && controller.text != '' ? Icon(Icons.check, color: Theme.of(context).textTheme.bodyText1!.color) : null) : null),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: true,
              fillColor: fillColor ?? allColor ?? Theme.of(context).cardColor,
              // focusColor: Colors.transparent,
              // hoverColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(5),
                borderSide: border ??
                    BorderSide(
                      color: allColor ?? Colors.transparent,
                      width: 1,
                    ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(5),
                borderSide: border ??
                    BorderSide(
                      color: allColor ?? Colors.transparent,
                      width: 1,
                    ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(5),
                borderSide: border ??
                    BorderSide(
                      color: allColor ?? Colors.black26,
                      width: 1,
                    ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(5),
                borderSide: border ??
                    BorderSide(
                      color: allColor ?? color ?? const Color(0xffe45a4f),
                      width: 1,
                    ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(5),
                borderSide: border ??
                    BorderSide(
                      color: allColor ?? color ?? Colors.black26,
                      width: 1,
                    ),
              ),
            ),
            enabled: enabled,
            onChanged: onChanged,
            validator: validator,
            maxLines: height ?? 1,
            maxLength: maxLength,
            onEditingComplete: () {
              final FocusScopeNode currentScope = FocusScope.of(context);
              if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
              SystemChrome.restoreSystemUIOverlays();
              if (onEditingComplete != null) {
                onEditingComplete();
              }
            },
            obscureText: obsecureText ?? false,
            onTap: onTap,
          ),
        ],
      ),
    );
  }

  static border({
    TextEditingController? controller,
    String? hintText,
    String? label,
    String? title,
    bool isfloat = false,
    TextInputType? keyboardType,
    TextAlign? textAlign,
    FocusNode? focusNode,
    bool? enabled,
    ValueChanged<String>? onChanged,
    Function? onSubmited,
    VoidCallback? onEditingComplete,
    GestureTapCallback? onTap,
    FormFieldValidator<String>? validator,
    Widget? prefixIcon,
    bool? suffixIcon,
    Widget? customSuffixIcon,
    bool? obsecureText,
    Color? color,
    Color? allColor,
    int? maxLength,
    int? height,
    Color? fillColor,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? const SizedBox()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: allColor ?? color ?? Theme.of(context).textTheme.bodyText2!.color,
                        fontWeight: FontWeight.w600,
                        fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(
            color: allColor ?? color ?? Theme.of(context).textTheme.bodyText2!.color,
            fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
          ),
          textAlign: textAlign ?? TextAlign.left,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hintText ?? '',
            counterText: "",
            labelText: label,
            floatingLabelBehavior: isfloat ? FloatingLabelBehavior.always : FloatingLabelBehavior.never,
            hintStyle: TextStyle(
              color: allColor ?? color ?? Theme.of(context).textTheme.bodyText2!.color!.withOpacity(0.7),
              fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: customSuffixIcon ?? (suffixIcon != null && suffixIcon == true ? (controller != null && controller.text != '' ? Icon(Icons.check, color: Theme.of(context).textTheme.bodyText1!.color) : null) : null),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: fillColor ?? Theme.of(context).scaffoldBackgroundColor,
            // focusColor: Colors.transparent,
            // hoverColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: allColor ?? Theme.of(context).textTheme.bodyText2!.color!.withOpacity(0.7),
                width: 1.4,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: allColor ?? Theme.of(context).textTheme.bodyText2!.color!.withOpacity(0.4),
                width: 1.4,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: allColor ?? Theme.of(context).textTheme.bodyText2!.color!.withOpacity(0.7),
                width: 1.4,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: allColor ?? color ?? const Color(0xffe45a4f),
                width: 1.4,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: allColor ?? color ?? Theme.of(context).primaryColor,
                width: 1.4,
              ),
            ),
          ),
          enabled: enabled,
          onChanged: onChanged,
          validator: validator,
          maxLines: height ?? 1,
          maxLength: maxLength,
          onEditingComplete: () {
            final FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
            SystemChrome.restoreSystemUIOverlays();
            if (onEditingComplete != null) {
              onEditingComplete();
            }
          },
          obscureText: obsecureText ?? false,
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100), () {
              // SystemChrome.restoreSystemUIOverlays();
              // SystemChrome.restoreSystemUIOverlays();
            });
            if (onTap != null) onTap();
          },
        ),
      ],
    );
  }

  static select({
    String? title,
    Color? allColor,
    Color? color,
    Color? backgroundColor,
    Color? borderColor,
    double? borderRadius,
    String? hintText,
    String? text,
    Function? onTap,
    bool? required,
    String? errorText,
    EdgeInsetsGeometry? padding,
    bool alignCenter = false,
    double? iconSize,
    required context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 8),
                child: Text(
                  title,
                  style: TextStyle(
                    color: allColor ?? color ?? Theme.of(context).textTheme.bodyText2!.color,
                    fontWeight: FontWeight.w600,
                    fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
                  ),
                ),
              ),
        GestureDetector(
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
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: (required ?? false) && text == null ? Theme.of(context).errorColor : borderColor ?? allColor ?? color ?? Theme.of(context).textTheme.bodyText2!.color!,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
              color: backgroundColor ?? allColor ?? color ?? Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                mainAxisAlignment: alignCenter ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                children: [
                  text == null
                      ? Text(
                          hintText ?? '',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.caption!.color,
                          ),
                        )
                      : Text(text),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_downward_outlined,
                    color: allColor ?? color ?? Theme.of(context).textTheme.bodyText2!.color,
                    size: iconSize,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        (required ?? false) && text == null
            ? Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 8),
                child: Text(
                  errorText ?? 'Harus Dipilih',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  static verification({
    required int numberOfInput,
    TextInputType? keyboardType,
    required Function(String) onChanged,
    required context,
  }) {
    List generated = [];
    for (int i = 0; i < numberOfInput; i++) {
      dynamic focusNode = FocusNode();
      if (i == 0) {
        generated.add({
          'value': null,
          'focusNode': focusNode,
          'onNext': null,
          'next': true,
          'type': 'start',
        });
      } else if (i == numberOfInput - 1) {
        generated[i - 1]['onNext'] = focusNode;
        generated.add({
          'value': null,
          'focusNode': focusNode,
          'next': false,
          'back': true,
          'onBack': generated[i - 1]['focusNode'],
          'type': 'end',
        });
      } else {
        generated[i - 1]['onNext'] = focusNode;
        generated.add({
          'value': null,
          'focusNode': focusNode,
          'next': true,
          'back': true,
          'onBack': generated[i - 1]['focusNode'],
          'onNext': null,
          'type': null,
        });
      }
    }

    return Row(
      children: generated.map<Widget>((val) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.5),
            child: Row(
              children: [
                Expanded(
                  child: normal(
                    context: context,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    focusNode: val['focusNode'],
                    keyboardType: keyboardType ?? TextInputType.number,
                    counterText: '',
                    onChanged: (data) {
                      val['value'] = data;
                      String values = '';
                      for (var i in generated) {
                        values += (i['value'] ?? '');
                      }
                      onChanged(values);
                      if (val['next'] && data.isNotEmpty) {
                        FocusScope.of(context).requestFocus(val['onNext']);
                      } else if (val['back'] && data.isEmpty) {
                        FocusScope.of(context).requestFocus(val['onBack']);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

Widget bottom({
  child,
  Widget? customChild,
  double? maxHeight,
  String? title,
  bool full = false,
  required BuildContext context,
}) {
  final keyboard = MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom;
  return GestureDetector(
    onTap: () {
      final FocusScopeNode currentScope = FocusScope.of(context);
      if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
        FocusManager.instance.primaryFocus!.unfocus();
      }
      SystemChrome.restoreSystemUIOverlays();
    },
    child: Padding(
      padding: EdgeInsets.only(bottom: keyboard),
      child: Material(
        color: Colors.transparent,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * (maxHeight ?? 0.8),
          ),
          child: Container(
            decoration: title == null
                ? null
                : BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
            child: Column(
              mainAxisSize: full ? MainAxisSize.max : MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(title, style: TextStyle(color: BaseColor.theme?.textButtonColor)),
                      ),
                !full
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color: isDarkTheme ? Theme.of(context).backgroundColor : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * ((maxHeight ?? 0.8) - 0.15) - MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: SingleChildScrollView(
                            physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Divider(
                                    thickness: 2,
                                    indent: getMaxWidth * 0.35,
                                    endIndent: getMaxWidth * 0.35,
                                  ),
                                  child ?? const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                            color: isDarkTheme ? Theme.of(context).backgroundColor : Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height * ((maxHeight ?? 0.8) - 0.15) - MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: customChild ??
                                SingleChildScrollView(
                                  physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Divider(
                                          thickness: 2,
                                          indent: getMaxWidth * 0.35,
                                          endIndent: getMaxWidth * 0.35,
                                        ),
                                        child ?? const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
