import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/core/utils/theme/app_colors.dart';
import 'package:spotify_clone/presentation/profile/bloc/favorite_song_cubit.dart';
import 'package:spotify_clone/presentation/profile/bloc/favorite_song_state.dart';
import 'package:spotify_clone/presentation/profile/bloc/profile_cubit.dart';
import 'package:spotify_clone/presentation/profile/bloc/profile_state.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        backgroundColor: context.isDarkMode ? Color(0xff2c2b2b) : Colors.white,
        title: Text("Profile"),
        action: PopupMenuButton(
          onSelected: (value) async {
            if (value == "Logout") {
            } else if (value == "Profile") {}
          },
          itemBuilder: (context) => [
            PopupMenuItem(value: 'Profile', child: Text('Profile')),
            PopupMenuItem(value: 'Settings', child: Text('Settings')),
            PopupMenuItem(value: 'Logout', child: Text('Logout')),
          ],
        ),
      ),
      body: Column(
        children: [
          _profileInfo(context),
          SizedBox(height: 20),
          _favoriteSongs(),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: context.isDarkMode ? Color(0xff2c2b2b) : Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              );
            }
            if (state is ProfileLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: context.isDarkMode
                        ? Colors.white
                        : Colors.black,
                    backgroundImage:
                        (state.userEntity.imageUrl != null &&
                            state.userEntity.imageUrl!.isNotEmpty)
                        ? NetworkImage(state.userEntity.imageUrl!)
                        : null,
                    child:
                        (state.userEntity.imageUrl == null ||
                            state.userEntity.imageUrl!.isEmpty)
                        ? Icon(
                            CupertinoIcons.person_fill,
                            size: 40,
                            color: context.isDarkMode
                                ? AppColors.darkGrey
                                : AppColors.grey,
                          )
                        : null,
                  ),
                  SizedBox(height: 15),
                  Text(
                    state.userEntity.username!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(state.userEntity.email!),
                ],
              );
            }
            return Text("Please try again");
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (_) => FavoriteSongCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "FAVORITE SONGS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            BlocBuilder<FavoriteSongCubit, FavoriteSongState>(
              builder: (context, state) {
                if (state is FavoriteSongLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: context.isDarkMode ? Colors.white : Colors.black,
                    ),
                  );
                }
                if (state is FavoriteSongLoadFailure) {
                  return Text("error");
                }
                if (state is FavoriteSongLoaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/songPlayer",
                            arguments: state.favoriteSongs[index],
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        state.favoriteSongs[index].coverPage ??
                                            "",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.favoriteSongs[index].title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      state.favoriteSongs[index].artist,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  state.favoriteSongs[index].duration
                                      .toString()
                                      .replaceAll(".", ":"),
                                ),
                                SizedBox(width: 20),
                                FavoriteButton(
                                  songEntity: state.favoriteSongs[index],

                                  function: () {
                                    context
                                        .read<FavoriteSongCubit>()
                                        .removeSong(index);
                                  },
                                  key: UniqueKey(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                    itemCount: state.favoriteSongs.length,
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
