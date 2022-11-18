import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  final void Function(String value)? onChanged;
  final String? labelText;
  final String? hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextFormField(
        onChanged: onChanged,
        obscureText: obscureText,
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
      ),
    );
  }
}