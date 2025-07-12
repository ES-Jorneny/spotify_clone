


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/song/get_playlist_usecase.dart';
import 'package:spotify_clone/presentation/home/bloc/playlist_state.dart';

import '../../../service_locator.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit():super(PlaylistLoading());

  Future<void> getPlaylist() async {
    var returnedSongs = await sl<GetPlaylistUsecase>().call();

    returnedSongs.fold(
          (l) {
        print("❌ Failure state emitted"); // 👈 You’re here
        emit(PlaylistLoadFailure());
      },
          (data) {
        print("✅ Loaded ${data.length} songs");
        emit(PlaylistLoaded(songs: data));
      },
    );
  }
}
