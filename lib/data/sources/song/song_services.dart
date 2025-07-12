import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/data/models/song/song_model.dart';
import 'package:spotify_clone/domain/entities/songs/song_entity.dart';
import 'package:spotify_clone/domain/usecases/song/is_favorite_song_usecase.dart';

import '../../../service_locator.dart';

abstract class SongService {
  Future<Either> getNewsSongs();

  Future<Either> getPlaylist();

  Future<Either> favoriteSongs(String songId);

  Future<bool> isFavoriteSong(String songId);

  Future<Either> getUserFavoriteSong();
}

class SongServiceImpl implements SongService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection("songs")
          .orderBy("releaseDate", descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var raw = element.data();
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUsecase>().call(
          params: element.reference.id,
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs); // ✅ if all good
    } catch (e) {
      print("🔥 Firestore error: $e"); // 👈 Add this!
      return Left("An error occurred, please try again");
    }
  }

  @override
  Future<Either> getPlaylist() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection("songs")
          .orderBy("releaseDate", descending: true)
          .get();

      for (var element in data.docs) {
        var raw = element.data();

        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUsecase>().call(
          params: element.reference.id,
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs); // ✅ if all good
    } catch (e) {
      print("🔥 Firestore error: $e"); // 👈 Add this!
      return Left("An error occurred, please try again");
    }
  }

  @override
  Future<Either> favoriteSongs(String songId) async {
    try {
      late bool isFavorite;
      QuerySnapshot favoriteSongs = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("favorites")
          .where("songId", isEqualTo: songId)
          .get();
      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("favorites")
            .add({"songId": songId, "addedDate": Timestamp.now()});
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return Left("An error occurred");
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      QuerySnapshot favoriteSongs = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("favorites")
          .where("songId", isEqualTo: songId)
          .get();
      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSong() async {
    try {
      List<SongEntity> favoriteSongs=[];
      QuerySnapshot favoriteSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("favorites")
          .get();
      for (var element in favoriteSnapshot.docs) {
        String songId = element["songId"];
        var song = await FirebaseFirestore.instance
            .collection('songs')
            .doc(songId)
            .get();
        SongModel songModel=SongModel.fromJson(song.data()!);
        songModel.isFavorite=true;
        songModel.songId=songId;
        favoriteSongs.add(
          songModel.toEntity()
        );

      }
      return Right(favoriteSongs);
    } catch (e) {
      return Left("An error occurred");
    }
  }
}
