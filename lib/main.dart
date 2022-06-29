import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_fair_players_administration/modules/authentication/services/firebase_authentication_service.dart';
import 'package:the_fair_players_administration/modules/club/repositories/club_repository.dart';
import 'package:the_fair_players_administration/modules/competition/repositories/competitions_repository.dart';
import 'package:the_fair_players_administration/modules/core/routes/app_routes.dart';
import 'package:the_fair_players_administration/modules/core/routes/route_builder.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_theme.dart';
import 'package:the_fair_players_administration/modules/lestplay/repositories/lets_play_repository.dart';
import 'package:the_fair_players_administration/modules/team/repositories/team_repository.dart';
import 'package:vrouter/vrouter.dart';
import 'dart:developer';

import './firebase_options.dart';
import 'modules/authentication/bloc/user_authentication/user_authentication_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(425, 868),
      builder: (context, widget) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => FirebaseAuthenticationService(),
            ),
            RepositoryProvider(
              create: (context) => TeamRepository(),
            ),
            RepositoryProvider(create: (context) => ClubRepository()),
            RepositoryProvider(create: (context) => CompetitionsRepository()),
            RepositoryProvider(create: (context) => LetsPlayRepository())
          ],
          child: BlocProvider(
            lazy: false,
            create: (context) => UserAuthenticationBloc(
                context.read<FirebaseAuthenticationService>())
              ..add(const UserAuthenticationEvent()),
            child:
                BlocConsumer<UserAuthenticationBloc, UserAuthenticationState>(
              listener: (context, state) {
                log(
                  state.user.toString(),
                  name: 'firebaseuser',
                );
              },
              builder: (context, state) {
                return VRouter(
                  scrollBehavior: MyCustomScrollBehavior(),
                  title: 'The Fair Players Administration',
                  themeMode: ThemeMode.light,
                  theme: AppTheme.lightTheme,
                  mode: VRouterMode.history,
                  initialUrl: SPLASH_SCREEN,
                  routes: buildRoutes(context),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
