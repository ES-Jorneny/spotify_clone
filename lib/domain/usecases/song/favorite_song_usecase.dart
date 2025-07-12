import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/song/song_repository.dart';


class FavoriteSongUseCase implements UseCase<Either,String>{
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongRepository>().favoriteSongs(params!);
  }





}