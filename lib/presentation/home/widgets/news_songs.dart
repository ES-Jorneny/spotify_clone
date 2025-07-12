import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark.dart';
import 'package:spotify_clone/core/utils/theme/app_colors.dart';

import 'package:spotify_clone/domain/entities/songs/song_entity.dart';
import 'package:spotify_clone/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_clone/presentation/home/bloc/news_songs_state.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_)=>NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit,NewsSongsState>(
          builder: (BuildContext context, NewsSongsState state) {
            if(state is NewsSongsLoading){
              return Center(
                child: CircularProgressIndicator(color: context.isDarkMode?Colors.white:Colors.black,),
              );
            }
            if(state is NewsSongsLoaded){
              print("✅ Songs Loaded: ${state.songs.length}"); // 👈 Add th
              return   _songs(state.songs);
            }
            return Text("state not match");
          },

        ),
      ),
    );
  }
  Widget _songs(List<SongEntity> songs){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/songPlayer",arguments: songs[index]);
              },
              child: SizedBox(
                width: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(

                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                                image: NetworkImage(songs[index].coverPage ?? 'https://via.placeholder.com/150')
                            )
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 40,
                              width: 40,
                              child: Icon(Icons.play_arrow_rounded,color: context.isDarkMode?Color(0xff959595):Color(0xff555555),),
                              transform: Matrix4.translationValues(10, 10, 0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:context.isDarkMode? AppColors.darkGrey:Color(0xffe6e6e6)
                              ),
                            ),
                          ),

                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(songs[index].title,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),),
                      SizedBox(height: 5,),
                      Text(songs[index].artist,style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12
                      ),),
                    ],
                  )),
            );

          },
          separatorBuilder:(context,index){
         return SizedBox(width: 14,);
          },
          itemCount:songs.length ),
    );

  }
}
