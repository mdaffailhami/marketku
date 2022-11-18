import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.textInputAction,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;
  final void Function(String value)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      validator: validator,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
