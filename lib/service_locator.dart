import 'package:get_it/get_it.dart';
import 'package:spotify_clone/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify_clone/data/sources/auth/auth_services.dart';
import 'package:spotify_clone/data/sources/song/song_services.dart';
import 'package:spotify_clone/domain/repository/auth/auth_repository.dart';
import 'package:spotify_clone/domain/repository/song/song_repository.dart';
import 'package:spotify_clone/domain/usecases/auth/check_login_usecase.dart';
import 'package:spotify_clone/domain/usecases/auth/get_user_usecase.dart';
import 'package:spotify_clone/domain/usecases/auth/log_out_usecase.dart';
import 'package:spotify_clone/domain/usecases/auth/reset_password_usecase.dart';
import 'package:spotify_clone/domain/usecases/auth/sign_up_usecase.dart';
import 'package:spotify_clone/domain/usecases/song/favorite_song_usecase.dart';
import 'package:spotify_clone/domain/usecases/song/get_favorite_song_usecase.dart';
import 'package:spotify_clone/domain/usecases/song/get_news_song-usecase.dart';
import 'package:spotify_clone/domain/usecases/song/get_playlist_usecase.dart';
import 'package:spotify_clone/domain/usecases/song/is_favorite_song_usecase.dart';
import 'data/repository/song/song_repository_impl.dart';
import 'domain/usecases/auth/sign_in_usecase.dart';

final sl=GetIt.instance;
Future<void> initializeDependencies() async{
  sl.registerSingleton<AuthServices>(
    AuthServiceImplementation()
  );
  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );
  sl.registerSingleton<SignUpUseCase>(
      SignUpUseCase()
  );
  sl.registerSingleton<SignInUseCase>(
      SignInUseCase()
  );
  sl.registerSingleton<LogOutUseCase>(
   LogOutUseCase()
  );
  sl.registerSingleton<CheckLoginUseCase>(
      CheckLoginUseCase()
  );
  sl.registerSingleton<ResetPasswordUseCase>(
      ResetPasswordUseCase()
  );

  sl.registerSingleton<SongService>(
    SongServiceImpl()
  );
  sl.registerSingleton<SongRepository>(
      SongRepositoryImpl()
  );

  sl.registerSingleton<GetNewsSongUseCase>(
      GetNewsSongUseCase()
  );
  sl.registerSingleton<GetPlaylistUsecase>(
      GetPlaylistUsecase()
  );
  sl.registerSingleton<FavoriteSongUseCase>(
      FavoriteSongUseCase()
  );
  sl.registerSingleton<IsFavoriteSongUsecase>(
      IsFavoriteSongUsecase()
  );
  sl.registerSingleton<GetUserUseCase>(
      GetUserUseCase()
  );

  sl.registerSingleton<GetFavoriteSongUsecase>(
      GetFavoriteSongUsecase()
  );
}