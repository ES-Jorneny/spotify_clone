import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/song/get_news_song-usecase.dart';
import 'package:spotify_clone/presentation/home/bloc/news_songs_state.dart';

import '../../../service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit():super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongUseCase>().call();

    returnedSongs.fold(
          (l) {
        print("❌ Failure state emitted"); // 👈 You’re here
        emit(NewsSongsLoadFailure());
      },
          (data) {
        print("✅ Loaded ${data.length} songs");
        emit(NewsSongsLoaded(songs: data));
      },
    );
  }
}
