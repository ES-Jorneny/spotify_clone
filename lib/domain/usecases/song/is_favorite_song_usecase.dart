import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/song/song_repository.dart';


class IsFavoriteSongUsecase implements UseCase<bool,String>{
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongRepository>().isFavoriteSong(params!);
  }





}