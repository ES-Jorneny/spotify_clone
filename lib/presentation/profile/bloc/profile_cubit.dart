import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/auth/get_user_usecase.dart';
import 'package:spotify_clone/presentation/profile/bloc/profile_state.dart';

import '../../../service_locator.dart';

class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit():super(ProfileLoading());
  Future<void> getUser()async{
    var user=await sl<GetUserUseCase>().call();
    user.fold((l){
      emit(ProfileFailure());
    }, (userEntity){
      emit(ProfileLoaded(userEntity: userEntity));
    });
  }
}