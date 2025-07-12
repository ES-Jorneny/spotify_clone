import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/entities/songs/song_entity.dart';
import 'package:spotify_clone/domain/usecases/song/get_favorite_song_usecase.dart';
import 'package:spotify_clone/presentation/profile/bloc/favorite_song_state.dart';

import '../../../service_locator.dart';

class FavoriteSongCubit extends Cubit<FavoriteSongState>{
  FavoriteSongCubit():super(FavoriteSongLoading());
  List<SongEntity> favoriteSongs=[];
  Future<void> getFavoriteSongs()async{
    var result=await sl<GetFavoriteSongUsecase>().call();
    result.fold((l){
      emit(FavoriteSongLoadFailure());
    },(r){
      favoriteSongs=r;
      emit(FavoriteSongLoaded(favoriteSongs: favoriteSongs));
    } );
  }

  void removeSong(int index) {
    favoriteSongs.removeAt(index);
    emit(
        FavoriteSongLoaded(favoriteSongs: favoriteSongs)
    );
  }

}