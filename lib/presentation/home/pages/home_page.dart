import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/helpers/is_dark.dart';
import 'package:spotify_clone/core/usecase/no_params.dart';
import 'package:spotify_clone/domain/usecases/auth/log_out_usecase.dart';
import 'package:spotify_clone/presentation/home/widgets/news_songs.dart';
import 'package:spotify_clone/presentation/home/widgets/playlist.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../core/assets/app_images.dart';
import '../../../core/assets/app_vectors.dart';
import '../../../core/utils/theme/app_colors.dart';
import '../../../service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  BasicAppBar(
        hideBack: true,
   action: PopupMenuButton(
       onSelected: (value) async{
         if(value=="Logout"){
           await sl<LogOutUseCase>().call();
           Navigator.pushReplacementNamed(context, "/getStarted");
         }else if(value=="Profile"){
           Navigator.pushNamed(context, "/profile");
         }

       },
       itemBuilder: (context)=>[
         PopupMenuItem(
           value: 'Profile',
           child: Text('Profile'),
         ),
         PopupMenuItem(
           value: 'Settings',
           child: Text('Settings'),
         ),
         PopupMenuItem(
           value: 'Logout',
           child: Text('Logout'),
         ),
       ]),
    title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),

    ),
  body:SingleChildScrollView(
    child: Column(

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _homeTopCard(),
        _tabs(),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: _tabController,
              children: [
                NewsSongs(),
                Container(),
                Container(),
                Container(),

              ]
          ),
        ),

        Playlist()

      ],
    ),
  )
    );
  }
  Widget _homeTopCard(){
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                  AppVectors.home_top_card
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 60
                ),
                child: Image.asset(
                    AppImages.homeArtist
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(
          vertical: 40,
      ),
      indicatorSize: TabBarIndicatorSize.tab,


      tabs: const [
        Text(
          'News',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
        ),
        Text(
          'Videos',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
        ),
        Text(
          'Artists',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
        ),
        Text(
          'Podcasts',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
        )
      ],
    );
  }
}
