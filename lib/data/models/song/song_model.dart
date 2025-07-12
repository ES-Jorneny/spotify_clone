import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_clone/domain/entities/songs/song_entity.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  String? publicId;
  String? songUrl;
  Timestamp? releaseDate;
  String? coverPage;
  bool? isFavorite;
  String? songId;

  SongModel(this.title,
      this.artist,
      this.duration,
      this.publicId,
      this.songUrl,
      this.releaseDate,
      this.coverPage,
      this.isFavorite,
      this.songId
      );

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data["title"];
    artist = data["artist"];
    duration = data["duration"];
    publicId = data["publicId"];
    songUrl = data["songUrl"];
    releaseDate = data["releaseDate"];
    coverPage=data["coverPage"];
    print("🧾 Parsed Song: title=$title, artist=$artist, duration=$duration, releaseDate=$releaseDate");
  }
}


extension SongModelX on SongModel{
  SongEntity toEntity() {
    return SongEntity(
        title!,
        artist!,
        duration!,
        publicId,
        songUrl,
        releaseDate!,
        coverPage!,
      isFavorite,
      songId
    );
  }
}