import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/buttons/app_button.dart';
import '../../../core/assets/app_vectors.dart';
import '../../../data/models/auth/user_model.dart';
import '../../../domain/usecases/auth/sign_in_usecase.dart';
import '../../../service_locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscure = true;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 50),
            _emailField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, "/forgot");
                  },
                  child: Text(
                    'Reset Password?',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],),
            const SizedBox(height: 25),
            AppButton(onPressed: () async{
              var result = await sl<SignInUseCase>().call(
                params: UserModel(
                  email: _email.text,
                  password: _password.text,
                ),
              );
              result.fold(
                    (l) {
                  var snackBar = SnackBar(content: Text(l));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                    (r) {
                  var snackBar = SnackBar(content: Text(r));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pushReplacementNamed(context, "/home");
                },
              );
            }, text: "Sign In"),
            const SizedBox(height: 40),
            _siginText(context),
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }


  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: 'Enter Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      controller: _password,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          ),
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
        ),
        hintText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _siginText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member? ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/signup");
            },
            child: Text(
              'Register Now',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
