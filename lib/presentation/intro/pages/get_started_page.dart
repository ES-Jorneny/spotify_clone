import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/widgets/buttons/app_button.dart';
import 'package:spotify_clone/core/assets/app_images.dart';
import 'package:spotify_clone/core/assets/app_vectors.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(

            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.introBG),
              ),
            ),

          ),
          Container(color: Colors.black.withOpacity(0.15),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(AppVectors.logo),
              ),
              Spacer(),
              Text(
                "Enjoy Listening To Music",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 21),
              Text(
                textAlign: TextAlign.center,
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 25),
              AppButton(onPressed: () {
                Navigator.pushReplacementNamed(context, "/chooseMode");
              }, text: "Get Started"),
              SizedBox(height: 35),
            ],
          ),),
        ],
      ),
    );
  }
}
