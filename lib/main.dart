
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_clone/core/utils/theme/app_theme.dart';
import 'package:spotify_clone/presentation/auth/pages/login_page.dart';
import 'package:spotify_clone/presentation/auth/pages/reset_password_page.dart';
import 'package:spotify_clone/presentation/auth/pages/sign_up_page.dart';
import 'package:spotify_clone/presentation/auth/pages/signup_or_sign_in_Page.dart';
import 'package:spotify_clone/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotify_clone/presentation/choose_mode/pages/choose_mode_page.dart';
import 'package:spotify_clone/presentation/home/pages/home_page.dart';
import 'package:spotify_clone/presentation/intro/pages/get_started_page.dart';
import 'package:spotify_clone/presentation/profile/pages/profile_page.dart';
import 'package:spotify_clone/presentation/song_player/pages/song_player_page.dart';
import 'package:spotify_clone/presentation/splash/pages/splash_page.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify_clone/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:HydratedStorageDirectory(
            (await getTemporaryDirectory()).path,
          ), // ✅ use comma not semicolon
  );
  await Firebase.initializeApp();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the home of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>ThemeCubit())
      ],
      child: BlocBuilder<ThemeCubit,ThemeMode>(
        builder:(context,mode){
          return  MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: mode,
            initialRoute: "/splash",
            debugShowCheckedModeBanner: false,
            routes: {
              "/splash": (context) => SplashPage(),
              "/getStarted": (context) => GetStartedPage(),
              "/chooseMode": (context) => ChooseModePage(),
              "/signupOrSignIn":(context)=>SignupOrSignInPage(),
              "/signup":(context)=>SignUpPage(),
              "/login":(context)=>LoginPage(),
              "/forgot":(context)=>ResetPasswordPage(),
              "/home":(context)=>HomePage(),
              "/songPlayer":(context)=>SongPlayerPage(),
              "/profile":(context)=>ProfilePage()
            },
          );
        }
      ),
    );
  }
}
