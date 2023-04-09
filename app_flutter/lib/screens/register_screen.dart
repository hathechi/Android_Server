import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sever/Screens/login_screen.dart';
import 'package:flutter_sever/configDB/config.dart';
import 'package:flutter_sever/tools/hide_key.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isShow = false;
  bool checkbox = false;
  final _controllerUserName = TextEditingController();
  final _controllerPass = TextEditingController();
  final _controllerCFPass = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerDate = TextEditingController();

  void register() async {
    hideKeyboard();
    final data = {
      "username": _controllerUserName.text,
      "pass": _controllerPass.text,
      "role": 'user',
      "email": _controllerEmail.text,
    };
    print((data));

    var response = await http.post(
      Uri.parse(configRegister),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    var jsonRes = jsonDecode(response.body);
    print(jsonRes['status']);
    if (jsonRes['status']) {
      // ignore: use_build_context_synchronously
      snackBar(message: jsonRes['message'], context: context);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
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
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: const Text(
            'Register',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Text(
                            "Register for free !",
                            style: GoogleFonts.comfortaa(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: (70),
                              backgroundColor:
                                  const Color.fromARGB(255, 222, 222, 222),
                              child: ClipRRect(
                                borderRadius: const BorderRadiusDirectional.all(
                                    Radius.circular(100)),
                                child: Image.asset(
                                  "assets/images/choose.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 10,
                              right: 10,
                              child: Icon(
                                FontAwesomeIcons.camera,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                          child: TextFormField(
                            controller: _controllerUserName,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(25),
                            ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Không Bỏ Trống Tên";
                              }
                              // if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                              //   return "Tên Không Chứa Ký Tự Đặc Biệt Hoặc Số";
                              // }
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
                                labelText: 'USERNAME',
                                labelStyle: TextStyle(fontSize: 12)),
                          )),
                      // password,
                      inputPassword(),
                      // Repassword,
                      reInputPassword(),
                      inputEmail(),
                      // DOB,
                      dayOfBirth(),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        alignment: Alignment.centerLeft,
                        child: CheckboxListTile(
                          onChanged: (value) {
                            setState(() {
                              checkbox = value!;
                              print(checkbox);
                            });
                          },
                          value: checkbox,
                          title: const Text(
                            'Accept the terms of service',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          activeColor: Colors.black,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
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
                                if (!checkbox) {
                                  // showToast(
                                  //     'Bạn Phải Chấp Nhận Các Điều Khoản Dịch Vụ !',
                                  //     Colors.red);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Bạn Phải Chấp Nhận Các Điều Khoản Dịch Vụ !')));
                                } else {
                                  // hideKeyboard();
                                  // onClickSignUp();
                                  register();
                                }
                              }
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            " SIGN IN NOW! ",
                            style: GoogleFonts.comfortaa(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dayOfBirth() => Container(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        onTap: () async {
          DateTime? pickDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1970),
              lastDate: DateTime(2100));
          if (pickDate != null) {
            setState(() {
              _controllerDate.text = DateFormat('dd/MM/yyyy').format(pickDate);
            });
          }
        },
        controller: _controllerDate,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return "Không Bỏ Trống Ngày Sinh";
          }

          return null;
        },
        decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 245, 245, 245),
            prefixIcon: Icon(
              FontAwesomeIcons.calendarDays,
              size: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            labelText: 'BIRTH DAY',
            labelStyle: TextStyle(fontSize: 12)),
      ));
  Widget inputEmail() => Container(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _controllerEmail,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
              Icons.email_outlined,
              size: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            labelText: 'EMAIL',
            labelStyle: TextStyle(fontSize: 12)),
      ));
  Widget reInputPassword() => Container(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return "Không Bỏ Trống Xác Nhận Mật Khẩu";
          }
          if (value.length < 6) {
            return "Xác Nhận Mật Khẩu Phải Hơn 6 Ký Tự";
          }
          if (value != _controllerPass.text) {
            return "Hai Mật Khẩu Phải Giống Nhau";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _controllerCFPass,
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
            labelText: 'COMFIRM PASSWORD',
            labelStyle: const TextStyle(fontSize: 12)),
      ));
  Widget inputPassword() => TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return "Không Bỏ Trống Mật Khẩu";
          }
          if (value.length < 6) {
            return "Mật Khẩu Phải Hơn 6 Ký Tự";
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
      );
  void _clickShowPass() {
    setState(() {
      _isShow = !_isShow;
    });
  }
}
