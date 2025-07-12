import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final num? duration;
  final String? publicId;
  final String? songUrl;
  final Timestamp releaseDate;
  final String? coverPage;
  final bool? isFavorite;
  final String? songId;

  SongEntity(
    this.title,
    this.artist,
    this.duration,
    this.publicId,
    this.songUrl,
    this.releaseDate,
    this.coverPage,
    this.isFavorite,
      this.songId
  );
}
