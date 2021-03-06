import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../services/validator.dart';
import '../widgets/submit_button.dart';
import '../services/api.dart';
import './register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordNotVisible = ValueNotifier(true);
  bool validate() {
    bool status = false;
    final form = formKey.currentState;

    if (form!.validate()) {
      form.save();
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'Selamat datang',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Form(
                key: formKey,
                child: SizedBox(
                  width: size.width * 1,
                  child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return EmailValidator.validate(value);
                        },
                        controller: _emailController,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                            size: 32,
                          ),
                          labelText: 'username',
                          labelStyle: TextStyle(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.4),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          hintText: 'youremail@mail.com',
                          hintStyle: TextStyle(
                            color: Colors.grey[400]!.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _isPasswordNotVisible,
                        builder: (context, bool isPasswordVisible, _) {
                          return TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return PasswordValidator.validate(value);
                            },
                            obscureText: _isPasswordNotVisible.value,
                            controller: _passwordController,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _isPasswordNotVisible.value =
                                      !_isPasswordNotVisible.value;
                                },
                                icon: _isPasswordNotVisible.value
                                    ? const Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Theme.of(context).primaryColor,
                                      ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                                size: 32,
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.4),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              hintText: 'xxxxxxxx',
                              hintStyle: TextStyle(
                                color: Colors.grey[400]!.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    child: const FittedBox(
                      child: Text('Belum punya akun?'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const RegisterScreen()));
                    },
                    child: SizedBox(
                      width: size.width * 0.16,
                      child: FittedBox(
                        child: Text(
                          'Registrasi',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              SubmitButton(
                isForRegister: false,
                future: () => Api.login(
                    username: _emailController.text,
                    password: _passwordController.text),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: size.width * 0.85,
                child: const FittedBox(
                  child: Text(
                    'Checklist App',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
