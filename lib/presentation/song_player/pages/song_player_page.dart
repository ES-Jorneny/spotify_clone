import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/domain/entities/songs/song_entity.dart';
import 'package:spotify_clone/presentation/song_player/bloc/sound_player_cubit.dart';
import 'package:spotify_clone/presentation/song_player/bloc/sound_player_state.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../core/utils/theme/app_colors.dart';

class SongPlayerPage extends StatelessWidget {
  const SongPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    SongEntity songs = ModalRoute.of(context)?.settings.arguments as SongEntity;

    return Scaffold(
      appBar: BasicAppBar(
        title: Text("Now Playing",style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        action: PopupMenuButton(
          onSelected: (value) async {
            if (value == "Logout") {}
          },
          itemBuilder: (context) => [
            PopupMenuItem(value: 'Profile', child: Text('Profile')),
            PopupMenuItem(value: 'Settings', child: Text('Settings')),
            PopupMenuItem(value: 'Logout', child: Text('Logout')),
          ],
        ),
      ),
      body: BlocProvider(
        create: (_) {
          final cubit = SoundPlayerCubit();
          cubit.loadSong(songs.songUrl ?? "");
          return cubit;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 20),
              _songDetail(context),
              const SizedBox(height: 30),
              _songPlayer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    SongEntity songs = ModalRoute.of(context)?.settings.arguments as SongEntity;
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(songs.coverPage ?? ""),
        ),
      ),
    );
  }

  Widget _songDetail(BuildContext context) {
    SongEntity songs = ModalRoute.of(context)?.settings.arguments as SongEntity;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(songs.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(songs.artist, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          ],
        ),

        FavoriteButton(songEntity: songs)
      ],
    );
  }

  Widget _songPlayer() {
    return BlocBuilder<SoundPlayerCubit, SoundPlayerState>(
      builder: (context, state) {
        if (state is SoundPlayerLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          );
        }

        if (state is SoundPlayerLoaded) {
          final cubit = context.read<SoundPlayerCubit>();

          return Column(
            children: [
              Slider(
              activeColor: context.isDarkMode?Colors.white:AppColors.darkGrey,
                value: cubit.songPosition.inSeconds.toDouble(),
                onChanged: (value) {
                  cubit.seekTo(Duration(seconds: value.toInt()));
                },
                max: cubit.songDuration.inSeconds.toDouble(),
                min: 0.0,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(cubit.songPosition)),
                  Text(formatDuration(cubit.songDuration)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      cubit.seekBackward();
                    },
                    icon: const Icon(Icons.replay_10, size: 36),
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      cubit.playOrPause();
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: Icon(
                        cubit.audioPlayer.playing
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                        size: 32,
                        color: Colors.white,

                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  IconButton(
                    onPressed: () {
                      cubit.seekForward();
                    },
                    icon: const Icon(Icons.forward_10, size: 36),
                  ),
                ],
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
