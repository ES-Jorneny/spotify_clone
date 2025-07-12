import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/domain/usecases/auth/reset_password_usecase.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/buttons/app_button.dart';
import '../../../core/assets/app_vectors.dart';
import '../../../service_locator.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _email = TextEditingController();


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

            const SizedBox(height: 25),
            AppButton(onPressed: ()async {
             var result= await sl<ResetPasswordUseCase>().call(params: _email.text);
             result.fold(
                   (l) {
                 var snackBar = SnackBar(content: Text(l));
                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
               },
                   (r) {
                 var snackBar = SnackBar(content: Text(r));
                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
               },
             );
            }, text: "Reset Password Link"),

          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Reset Password',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }


  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: 'Enter your Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

}
