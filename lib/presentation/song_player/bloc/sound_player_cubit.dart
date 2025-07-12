import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/presentation/song_player/bloc/sound_player_state.dart';

class SoundPlayerCubit extends Cubit<SoundPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SoundPlayerCubit() : super(SoundPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSoundPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
      }
    });
  }

  void updateSoundPlayer() {
    emit(SoundPlayerLoaded());
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      emit(SoundPlayerLoaded());
    } catch (e) {
      emit(SoundPlayerLoadFailure());
    }
  }

  void playOrPause() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    emit(SoundPlayerLoaded());
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
    emit(SoundPlayerLoaded());
  }

  void seekForward() {
    final newPosition = songPosition + Duration(seconds: 10);
    if (newPosition < songDuration) {
      audioPlayer.seek(newPosition);
    } else {
      audioPlayer.seek(songDuration);
    }
    emit(SoundPlayerLoaded());
  }

  void seekBackward() {
    final newPosition = songPosition - Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      audioPlayer.seek(newPosition);
    } else {
      audioPlayer.seek(Duration.zero);
    }
    emit(SoundPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
