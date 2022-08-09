import 'package:flutter/material.dart';

class GlobalTextFormField extends StatelessWidget {
  const GlobalTextFormField({
    Key? key,
    required this.labelText,
    this.hintText,
    this.obscureText,
    this.enabled,
    this.controller,
    this.textInputAction,
    this.validator,
    this.onEditingComplete,
    this.maxLines,
    this.keyboardType,
    this.onFieldSubmitted,
  }) : super(key: key);

  final String labelText;
  final String? hintText;
  final bool? obscureText;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;

  final void Function()? onEditingComplete;
  final int? maxLines;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) => TextFormField(
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          labelText: labelText,
          // labelStyle: GlobalsStyles.textFormLableTextStyles,
          hintText: hintText,
          fillColor: Colors.grey.shade100,
          filled: true,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.indigoAccent)),
        ),
        // style: GlobalsStyles.textFormInputTextStyles,
        obscureText: obscureText ?? false,
        enabled: enabled,
        controller: controller,
        textInputAction: textInputAction,
        validator: validator,
        onEditingComplete: onEditingComplete,
        keyboardType: keyboardType,
        onFieldSubmitted: onFieldSubmitted,
      );
}
