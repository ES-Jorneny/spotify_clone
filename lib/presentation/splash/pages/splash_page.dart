import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/core/assets/app_vectors.dart';
import 'package:spotify_clone/domain/usecases/auth/check_login_usecase.dart';

import '../../../core/usecase/no_params.dart';
import '../../../service_locator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final CheckLoginUseCase _checkLoginUseCase = sl<CheckLoginUseCase>();

  @override
  void initState() {

    super.initState();
    redirect();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:SvgPicture.asset(AppVectors.logo),
      ),
    );
  }

  Future<void> redirect()async{
    await Future.delayed(Duration(seconds: 3));
    final isLoggedIn = await _checkLoginUseCase.call(params: const NoParams());
    if(isLoggedIn){
   Navigator.pushReplacementNamed(context, "/home");
    }
    else {
      Navigator.pushReplacementNamed(context, "/getStarted");
    }
  }
}
