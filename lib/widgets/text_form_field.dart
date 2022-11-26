import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    this.enabled,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon,
    this.prefix,
    this.maxLines,
    this.verticalPadding,
    this.controller,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
  }) : super(key: key);

  final bool? enabled;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final Widget? prefix;
  final int? maxLines;
  final double? verticalPadding;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;
  final void Function(String value)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      onChanged: onChanged,
      initialValue: initialValue,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.outline,
            ),
        labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.outline,
            ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 12, vertical: verticalPadding ?? 0),
        suffixIcon: suffixIcon,
        prefix: prefix,
      ),
    );
  }
}
