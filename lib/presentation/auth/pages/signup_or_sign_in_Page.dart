import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/helpers/is_dark.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/common/widgets/buttons/app_button.dart';
import 'package:spotify_clone/core/assets/app_images.dart';
import 'package:spotify_clone/core/assets/app_vectors.dart';


class SignupOrSignInPage extends StatelessWidget {
  const SignupOrSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(

     children: [
       BasicAppBar(),
       Align(
         alignment: Alignment.topRight,
         child: SvgPicture.asset(AppVectors.top_pattern),
       ),
       Align(
         alignment: Alignment.bottomRight,
         child: SvgPicture.asset(AppVectors.bottom_pattern),
       ),
       Align(
         alignment: Alignment.bottomLeft,
         child: Image.asset(AppImages.authBG),
       ),
       Align(
         alignment: Alignment.center,
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 14),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SvgPicture.asset(AppVectors.logo),
               SizedBox(height: 55,),
               Text(
                 "Enjoy Listening To Music",
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 26,
                 ),
               ),
               SizedBox(height: 21,),
               Text(
                 textAlign: TextAlign.center,
                 "Spotify is a proprietary Swedish audio",
                 style: TextStyle(
                   fontWeight: FontWeight.w400,
                   fontSize: 17,
                   color: Colors.grey
                 ),
               ),
               Text(
                 textAlign: TextAlign.center,
                 "streaming and media services provider",
                 style: TextStyle(
                     fontWeight: FontWeight.w400,
                     fontSize: 17,
                     color: Colors.grey
                 ),
               ),
               SizedBox(
                 height: 30,
               ),
               Row(
                 children: [
                   Expanded(
                       child:AppButton(
                         onPressed: (){
                           Navigator.pushNamed(context, "/signup");
                         },
                         text: "Register",
                       )
                   ),
                   SizedBox(width: 20,),
                   Expanded(
                     child: TextButton(
                         style: TextButton.styleFrom(
                           overlayColor: Colors.transparent, // 👈 Hover effect disable
                         ),

                         onPressed: (){
                           Navigator.pushNamed(context, "/login");
                         }, child: Text("Sign In",
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 16,
                         color:context.isDarkMode?Colors.white:Colors.black
                       ),
                     )),
                   )
                 ],
               )

             ],
           ),
         ),
       ),
     ],
   ),
    );
  }
}
