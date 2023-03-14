import 'package:dumenden/register_page.dart';
import 'package:dumenden/tab_subwidgets/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String email = "deneme@email.com";
  String password = "123";
  bool isVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myPrimaryColor,
        elevation: 0,
        title: const Text(
          "Giriş Yap",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .3, child: LottieBuilder.asset("assets/lottie/lottie_login.json")),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value.toString());
                          return !emailValid ? "Geçerli bir email giriniz" : null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email giriniz",
                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          prefixIcon: const Icon(Icons.email),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: myPrimaryColor)),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // commit
                      TextFormField(
                        obscureText: !isVisibility,
                        obscuringCharacter: "*",
                        validator: (value) {
                          if (password == value) {
                            return null;
                          }
                          return "Lütfen şifreyi doğru girin";
                        },
                        decoration: InputDecoration(
                          hintText: "Şifre giriniz",
                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          prefixIcon: const Icon(Icons.lock),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: myPrimaryColor)),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isVisibility = !isVisibility;
                              });
                            },
                            child: Icon(isVisibility == true ? Icons.visibility : Icons.visibility_off),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 45,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(backgroundColor: myPrimaryColor, shape: const StadiumBorder()),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    duration: Duration(milliseconds: 1500),
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "Lütfen alanlarınızı kontrol ediniz",
                                      style: TextStyle(color: Colors.white),
                                    )));
                                return;
                              }
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  backgroundColor: myPrimaryColor,
                                  content: Text(
                                    "Tebrikler giriş yapıldı",
                                    style: TextStyle(color: Colors.white),
                                  )));
                            },
                            child: const Text(
                              "Giriş Yap",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyRegisterPage()));
                          },
                          child: const Text(
                            "Hesabın yok mu? Kayıt ol",
                            style: TextStyle(color: myPrimaryColor),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

const Color myPrimaryColor = Color.fromRGBO(2, 137, 123, 1);
