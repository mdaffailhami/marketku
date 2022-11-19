import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketku/models/akun.dart';
import 'package:marketku/widgets/text_form_field.dart';

class MyResetPasswordDialog extends StatefulWidget {
  const MyResetPasswordDialog({super.key});

  @override
  State<MyResetPasswordDialog> createState() => _MyResetPasswordDialogState();
}

class _MyResetPasswordDialogState extends State<MyResetPasswordDialog> {
  final formKey = GlobalKey<FormState>();
  var isUserNotFound = false;
  var alamatEmail = '';

  void resetPassword() {
    final isValidForm = formKey.currentState!.validate();

    if (isValidForm) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Kirim email verifikasi'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () async {
                  final kirim = await Akun.resetPassword(alamatEmail);

                  if (kirim.sukses) {
                    popDialog();
                    popDialog();
                    showSnackBar(text: kirim.pesan);
                  } else {
                    if (kirim.pesan == 'user-not-found' ||
                        kirim.pesan == 'invalid-email') {
                      isUserNotFound = true;
                    } else {
                      showSnackBar(
                        text:
                            'Gagal mengirim email verifikasi! (${kirim.pesan})',
                      );
                    }

                    popDialog();
                    formKey.currentState!.validate();
                  }
                },
                child: Text('Kirim'),
              ),
            ],
            content: Text(
              'Kami akan mengirimkan email verifikasi ke alamat email yang telah anda masukkan!',
            ),
          );
        },
      );
    }
  }

  void popDialog() => Navigator.of(context).pop();

  void showSnackBar({required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Reset password'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Batal'),
        ),
        TextButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              resetPassword();
            },
            child: Text('Reset')),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Masukkan alamat email yang ingin direset passwordnya'),
          SizedBox(height: 8),
          Form(
            key: formKey,
            child: MyTextFormField(
              labelText: 'Email',
              hintText: 'Masukkan alamat email',
              textInputAction: TextInputAction.send,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Alamat Email tidak boleh kosong!';
                } else if (isUserNotFound) {
                  isUserNotFound = false; // Dibalikin lagi
                  return 'Alamat Email tidak terdaftar!';
                } else {
                  return null;
                }
              },
              onChanged: (String value) => alamatEmail = value,
              onFieldSubmitted: (_) => resetPassword(),
            ),
          ),
        ],
      ),
    );
  }
}
