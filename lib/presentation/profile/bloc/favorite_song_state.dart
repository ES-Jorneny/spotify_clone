import 'package:spotify_clone/domain/entities/songs/song_entity.dart';

abstract class FavoriteSongState{

}

class FavoriteSongLoading extends FavoriteSongState{

}
class FavoriteSongLoaded extends FavoriteSongState{
  final List<SongEntity> favoriteSongs;

  FavoriteSongLoaded({required this.favoriteSongs});


}
class FavoriteSongLoadFailure extends FavoriteSongState{

}