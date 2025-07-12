import 'package:dartz/dartz.dart';
import 'package:spotify_clone/data/sources/song/song_services.dart';

import 'package:spotify_clone/domain/repository/song/song_repository.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongRepository{
  @override
  Future<Either> getNewsSongs() async{
  return await sl<SongService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async{
    return await sl<SongService>().getPlaylist();
  }

  @override
  Future<Either> favoriteSongs(String songId) async{
    return await sl<SongService>().favoriteSongs(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId)async {
      return await sl<SongService>().isFavoriteSong(songId);
  }

  @override
  Future<Either> getUserFavoriteSong()async {
    return await sl<SongService>().getUserFavoriteSong();
  }

}