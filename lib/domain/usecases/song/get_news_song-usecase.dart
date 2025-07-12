import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/song/song_repository.dart';


class GetNewsSongUseCase implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({params})async {
    return await sl<SongRepository>().getNewsSongs();
  }



}