import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      validator: validator,
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
      ),
    );
  }
}
