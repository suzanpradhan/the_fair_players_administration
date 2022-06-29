import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_colors.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/routes/app_routes.dart';
import '../bloc/user_authentication/user_authentication_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<UserAuthenticationBloc>(),
      child: BlocListener<UserAuthenticationBloc, UserAuthenticationState>(
        listener: (context, state) {
          log(state.user.toString(), name: "loginScreen");
          if (state.user != null) {
            if (context.vRouter.queryParameters.containsKey("redirect")) {
              log("fromQueryParams");
              context.vRouter.to(context.vRouter.queryParameters["redirect"]!,
                  isReplacement: true);
            } else {
              context.vRouter.to(ANALYTICS_ROUTE, isReplacement: true);
            }
          } else {
            context.vRouter.to(LOGIN_SCREEN_ROUTE, isReplacement: true);
          }
        },
        child: Container(
          color: AppColors.whitePrimary,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 120,
                height: 120,
              ),
              const SizedBox(
                height: 42,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const SizedBox(
                  width: 80,
                  child: LinearProgressIndicator(
                    backgroundColor: AppColors.whiteShade,
                    color: AppColors.greenPrimary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
