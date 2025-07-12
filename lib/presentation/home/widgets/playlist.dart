import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark.dart';
import 'package:spotify_clone/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify_clone/domain/entities/songs/song_entity.dart';
import 'package:spotify_clone/presentation/home/bloc/playlist_cubit.dart';
import 'package:spotify_clone/presentation/home/bloc/playlist_state.dart';

import '../../../core/utils/theme/app_colors.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaylistCubit()..getPlaylist(),
      child: BlocBuilder<PlaylistCubit, PlaylistState>(
        builder: (context, state) {
          if (state is PlaylistLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            );
          }
          if (state is PlaylistLoaded) {
            print("✅ playlist Loaded: ${state.songs.length}"); // 👈 Add th
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Playlist",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "See More",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: context.isDarkMode
                              ? Color(0xffc6c6c6)
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _playlist(state.songs),
                ],
              ),
            );
          }
          return Text("state not match");
        },
      ),
    );
  }

  Widget _playlist(List<SongEntity> songs) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              "/songPlayer",
              arguments: songs[index],
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: context.isDarkMode
                          ? Color(0xff959595)
                          : Color(0xff555555),
                    ),
                    transform: Matrix4.translationValues(10, 10, 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode
                          ? AppColors.darkGrey
                          : Color(0xffe6e6e6),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songs[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        songs[index].artist,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    songs[index].duration.toString().replaceAll(".", ":"),
                  ),
                  SizedBox(width: 20),
                 FavoriteButton(songEntity: songs[index])
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 15);
      },
      itemCount: songs.length,
    );
  }
}
