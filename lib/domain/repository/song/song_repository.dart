import 'package:dartz/dartz.dart';

abstract class SongRepository{
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> favoriteSongs(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSong();
}