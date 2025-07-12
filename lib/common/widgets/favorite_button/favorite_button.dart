import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_clone/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify_clone/common/helpers/is_dark.dart';
import 'package:spotify_clone/domain/entities/songs/song_entity.dart';

import '../../../core/utils/theme/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
final Function ? function;
  const FavoriteButton({super.key, required this.songEntity,this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () async{
                if(function!=null){
                  function!();
                }
               await context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                  songEntity.songId!,
                );
              },
              icon: Icon(
                songEntity.isFavorite == false
                    ?  Icons.favorite_outline:Icons.favorite,
                color: songEntity.isFavorite == false
                    ? (context.isDarkMode ? AppColors.darkGrey : AppColors.grey)
                    : AppColors.primary,
                size: 25,
              ),
            );
          }
          if (state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                  songEntity.songId!,
                );
              },
              icon: Icon(
                state.isFavorite == false
                    ?  Icons.favorite_outline:Icons.favorite,
                color: state.isFavorite == false
                    ? (context.isDarkMode ? AppColors.darkGrey : AppColors.grey)
                    : AppColors.primary,
                size: 25,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
