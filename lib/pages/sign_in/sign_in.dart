import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marketku/models/akun.dart';
import 'package:marketku/pages/home/home.dart';
import 'package:marketku/pages/sign_up/sign_up.dart';
import 'package:marketku/widgets/marketku_logotype.dart';
import 'package:marketku/widgets/text_form_field.dart';

import 'reset_password_dialog.dart';

class MySignInPage extends StatefulWidget {
  const MySignInPage({super.key});

  @override
  State<MySignInPage> createState() => _MySignInPageState();
}

class _MySignInPageState extends State<MySignInPage> {
  final formKey = GlobalKey<FormState>();
  var isLoading = false;
  var isPasswordVisible = false;
  var isUserNotFound = false;
  var isPasswordWrong = false;

  var alamatEmail = '';
  var kataSandi = '';

  void masuk() async {
    setState(() => isLoading = true);

    final isValidForm = formKey.currentState!.validate();
    if (isValidForm) {
      final masuk = await Akun.masuk(alamatEmail, kataSandi);

      if (masuk.sukses) {
        showSnackBar(text: masuk.pesan);
        gantiKeHalamanHome();
      } else {
        if (masuk.pesan == 'user-not-found' || masuk.pesan == 'invalid-email') {
          isUserNotFound = true;
        } else if (masuk.pesan == 'wrong-password') {
          isPasswordWrong = true;
        } else {
          showSnackBar(
            text: 'Masuk gagal!(${masuk.pesan}',
          );
        }

        formKey.currentState!.validate();
      }
    }

    setState(() => isLoading = false);
  }

  void showSnackBar({required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  void gantiKeHalamanHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MyHomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  flex: 11,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Selamat Datang !',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Image.asset('assets/sign_in.png'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const Divider(),
                              MyTextFormField(
                                labelText: 'Email',
                                hintText: 'Masukkan alamat email anda',
                                textInputAction: TextInputAction.next,
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
                                onChanged: (String value) =>
                                    alamatEmail = value,
                              ),
                              const SizedBox(height: 10),
                              MyTextFormField(
                                labelText: 'Password',
                                hintText: 'Masukkan password anda',
                                textInputAction: TextInputAction.send,
                                obscureText: !isPasswordVisible,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password tidak boleh kosong!';
                                  } else if (isPasswordWrong) {
                                    isPasswordWrong = false; // Dibalikin lagi
                                    return 'Password salah!';
                                  } else {
                                    return null;
                                  }
                                },
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() =>
                                        isPasswordVisible = !isPasswordVisible);
                                  },
                                  icon: isPasswordVisible
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                                onChanged: (String value) => kataSandi = value,
                                onFieldSubmitted: (_) => masuk(),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                child: RichText(
                                  textAlign: TextAlign.right,
                                  text: TextSpan(
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Lupa Password? '),
                                      TextSpan(
                                        text: 'Reset',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  const MyResetPasswordDialog(),
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              isLoading
                                  ? const Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 6, top: 8),
                                      child: LinearProgressIndicator(),
                                    )
                                  : const SizedBox(height: 8),
                              TextButton(
                                onPressed: () => masuk(),
                                style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                              .brightness ==
                                          Brightness.dark
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primaryContainer
                                      : Theme.of(context).colorScheme.primary,
                                  foregroundColor: Theme.of(context)
                                              .brightness ==
                                          Brightness.dark
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer
                                      : Theme.of(context).colorScheme.onPrimary,
                                  fixedSize: Size.fromWidth(
                                      MediaQuery.of(context).size.width),
                                ),
                                child: const Text('Masuk'),
                              ),
                              const SizedBox(height: 16),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Belum punya akun? '),
                                    TextSpan(
                                      text: 'Daftar',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const MySignUpPage(),
                                            ),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Theme.of(context).brightness == Brightness.dark
                      ? MyMarketKuLogotype.light(fontSize: 30)
                      : MyMarketKuLogotype.dark(fontSize: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
