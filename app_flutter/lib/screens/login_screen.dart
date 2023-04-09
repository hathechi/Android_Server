import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sever/Screens/forgot_password.dart';
import 'package:flutter_sever/Screens/register_screen.dart';
import 'package:flutter_sever/configDB/config.dart';
import 'package:flutter_sever/screens/home_screen.dart';
import 'package:flutter_sever/tools/hide_key.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isShow = false;
  final _formKey = GlobalKey<FormState>();
  final _controllerEmail = TextEditingController();
  final _controllerPass = TextEditingController();

  void loginServer() async {
    hideKeyboard();
    final data = {
      "email_login": _controllerEmail.text,
      "password_login": _controllerPass.text
    };
    var res = await http.post(
      Uri.parse(configLogin),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    var jsonRes = jsonDecode(res.body);

    if (jsonRes['status']) {
      // ignore: use_build_context_synchronously
      snackBar(
          message: "Hello: " +
              jsonRes['check']['username'] +
              " " +
              jsonRes['check']['role'],
          context: context);

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      snackBar(message: jsonRes['message'], context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Image.asset("assets/images/logo_login.png")),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: Container(
                        child: Text(
                          "Login now to experience",
                          style: GoogleFonts.comfortaa(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 38,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                        child: TextFormField(
                          controller: _controllerEmail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Không Bỏ Trống Email";
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return "Nhập Đúng Định Dạng Email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 245, 245, 245),
                              prefixIcon: Icon(
                                FontAwesomeIcons.user,
                                size: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(fontSize: 12)),
                        )),
                    Container(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Không Bỏ Trống Mật Khẩu";
                        }
                        if (value.length < 6) {
                          return "Mật Khẩu Phải Hơn 5 Ký Tự";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _controllerPass,
                      obscureText: _isShow,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 245, 245, 245),
                          prefixIcon: const Icon(
                            FontAwesomeIcons.lock,
                            size: 16,
                          ),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                _clickShowPass();
                              },
                              child: _isShow
                                  ? const Icon(
                                      Icons.visibility,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                    )),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          labelText: 'PASSWORD',
                          labelStyle: const TextStyle(fontSize: 12)),
                    )),
                    // Container(
                    //   padding: const EdgeInsets.only(top: 10),
                    //   alignment: Alignment.centerLeft,
                    //   child: CheckboxListTile(
                    //     onChanged: (value) {
                    //       setState(() {
                    //         checkbox = value!;
                    //         print(checkbox);
                    //       });
                    //     },
                    //     value: checkbox,
                    //     title: Text(
                    //       'Remember me',
                    //       style: GoogleFonts.comfortaa(
                    //           fontSize: 16, fontWeight: FontWeight.bold),
                    //     ),
                    //     activeColor: Colors.black,
                    //     controlAffinity: ListTileControlAffinity.leading,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              elevation: 8,
                              shape: (RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(130)))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              loginServer();
                            }
                          },
                          child: const Text(
                            'SIGN IN',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '------ or continue with ------',
                        style:
                            GoogleFonts.comfortaa(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 80,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: const Color.fromARGB(255, 199, 198, 198),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.google,
                                size: 40,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: const Color.fromARGB(255, 199, 198, 198),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.facebook,
                                size: 40,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: const Color.fromARGB(255, 199, 198, 198),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.apple,
                                size: 42,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.comfortaa(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: 'NEW USER? ',
                                    ),
                                    TextSpan(
                                      text: 'SIGN UP',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassWord()),
                                );
                              },
                              child: Text(
                                "FORGOT PASSWORD",
                                style: GoogleFonts.comfortaa(
                                  fontSize: 13,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _clickShowPass() {
    setState(() {
      _isShow = !_isShow;
    });
  }
}
