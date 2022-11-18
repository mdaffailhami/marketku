import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketku/widgets/marketku_logotype.dart';
import 'package:marketku/widgets/text_form_field.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key});

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  var nama = '';
  var email = '';
  var password = '';

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
                        child: Column(
                          children: [
                            Divider(),
                            MyTextFormField(
                              labelText: 'Nama',
                              hintText: 'Masukkan nama anda',
                              onChanged: (String value) => nama = value,
                            ),
                            SizedBox(height: 10),
                            MyTextFormField(
                              labelText: 'Email',
                              hintText: 'Masukkan alamat email anda',
                              onChanged: (String value) => email = value,
                            ),
                            SizedBox(height: 10),
                            MyTextFormField(
                              labelText: 'Password',
                              hintText: 'Masukkan password yang kuat!',
                              obscureText: true,
                              onChanged: (String value) => password = value,
                            ),
                            SizedBox(height: 12),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                    : Theme.of(context).colorScheme.primary,
                                foregroundColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                    : Theme.of(context).colorScheme.onPrimary,
                                fixedSize: Size.fromWidth(
                                    MediaQuery.of(context).size.width),
                              ),
                              child: Text('Daftar'),
                            ),
                            // SizedBox(height: 2),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Divider(indent: 5, endIndent: 10.0),
                            //     ),
                            //     Text(
                            //       "ATAU",
                            //       style: TextStyle(
                            //           color: Theme.of(context).brightness ==
                            //                   Brightness.dark
                            //               ? Theme.of(context)
                            //                   .colorScheme
                            //                   .outline
                            //               : Colors.grey,
                            //           fontSize: 12),
                            //     ),
                            //     Expanded(
                            //       child: Divider(indent: 10.0, endIndent: 5),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 2),
                            // TextButton(
                            //   onPressed: () {},
                            //   style: TextButton.styleFrom(
                            //     backgroundColor: Theme.of(context)
                            //         .colorScheme
                            //         .surfaceVariant
                            //         .withOpacity(0.7),
                            //     foregroundColor: Theme.of(context)
                            //         .colorScheme
                            //         .onSurfaceVariant,
                            //     fixedSize: Size.fromWidth(
                            //         MediaQuery.of(context).size.width),
                            //   ),
                            //   child: Stack(
                            //     alignment: Alignment.centerLeft,
                            //     children: [
                            //       SizedBox(
                            //         width: double.infinity,
                            //         child: Text(
                            //           'Daftar dengan Google',
                            //           textAlign: TextAlign.center,
                            //           style: TextStyle(
                            //             color: Theme.of(context)
                            //                 .colorScheme
                            //                 .primary,
                            //           ),
                            //         ),
                            //       ),
                            //       SvgPicture.asset('assets/google.svg',
                            //           width: 26),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: 16),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.outline),
                                children: [
                                  TextSpan(text: 'Sudah punya akun? '),
                                  TextSpan(
                                    text: 'Masuk',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => print('MASUK'),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
