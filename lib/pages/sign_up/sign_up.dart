import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marketku/models/akun.dart';
import 'package:marketku/models/respon.dart';
import 'package:marketku/pages/sign_in/sign_in.dart';
import 'package:marketku/widgets/marketku_logotype.dart';
import 'package:marketku/widgets/text_form_field.dart';
import 'package:validators/validators.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key});

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  final formKey = GlobalKey<FormState>();
  var isEmailAlreadyInUse = false;
  var isLoading = false;
  var isPasswordVisible = false;

  var nama = '';
  var alamatEmail = '';
  var kataSandi = '';

  void daftarkanAkun() async {
    setState(() => isLoading = true);

    final isValidForm = formKey.currentState!.validate();
    if (isValidForm) {
      final akun = Akun(
        nama: nama,
        alamatEmail: alamatEmail,
        kataSandi: kataSandi,
      );

      final Respon addAkun = await Akun.add(akun);

      if (addAkun.sukses) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Akun berhasil didaftarkan!')),
        );

        gantiKeHalamanSignIn();
      } else {
        if (addAkun.pesan == 'email-already-in-use') {
          isEmailAlreadyInUse = true;
          formKey.currentState!.validate();
        }
      }
    }

    setState(() => isLoading = false);
  }

  void gantiKeHalamanSignIn() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MySignInPage(),
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
                      Text('Yuk Gabung !',
                          style: Theme.of(context).textTheme.displaySmall),
                      Image.asset(
                        'assets/sign_up.png',
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const Divider(),
                              MyTextFormField(
                                labelText: 'Nama',
                                hintText: 'Masukkan nama anda',
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Nama minimal 1 karakter';
                                  } else if (value.length > 30) {
                                    return 'Nama tidak boleh lebih dari 30 karakter!';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (String value) => nama = value,
                              ),
                              const SizedBox(height: 10),
                              MyTextFormField(
                                labelText: 'Email',
                                hintText: 'Masukkan alamat email anda',
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (!isEmail(value ?? '')) {
                                    return 'Email tidak valid!';
                                  } else if (isEmailAlreadyInUse) {
                                    isEmailAlreadyInUse =
                                        false; // dibalikin lagi
                                    return 'Email sudah terdaftar!';
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
                                hintText: 'Masukkan password yang kuat!',
                                obscureText: !isPasswordVisible,
                                textInputAction: TextInputAction.send,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() =>
                                        isPasswordVisible = !isPasswordVisible);
                                  },
                                  icon: isPasswordVisible
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                                onFieldSubmitted: (_) => daftarkanAkun(),
                                validator: (value) => value!.length < 6
                                    ? 'Password minimal 6 karakter!'
                                    : null,
                                onChanged: (String value) => kataSandi = value,
                              ),
                              isLoading
                                  ? const Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 6, top: 12),
                                      child: LinearProgressIndicator(),
                                    )
                                  : const SizedBox(height: 12),
                              TextButton(
                                onPressed: () => daftarkanAkun(),
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
                                child: const Text('Daftar'),
                              ),
                              const SizedBox(height: 16),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outline),
                                  children: [
                                    const TextSpan(text: 'Sudah punya akun? '),
                                    TextSpan(
                                      text: 'Masuk',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => gantiKeHalamanSignIn(),
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
