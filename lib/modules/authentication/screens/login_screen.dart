import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_fair_players_administration/modules/authentication/services/firebase_authentication_service.dart';
import 'package:the_fair_players_administration/modules/core/routes/app_routes.dart';
import 'package:the_fair_players_administration/modules/core/widgets/loader_widger.dart';
import 'package:vrouter/vrouter.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/user_authentication/user_authentication_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
              firebaseAuthenticationService:
                  context.read<FirebaseAuthenticationService>()),
        ),
        BlocProvider.value(
          value: context.read<UserAuthenticationBloc>(),
        ),
      ],
      child: BlocListener<UserAuthenticationBloc, UserAuthenticationState>(
        listener: (context, state) {
          log(state.user.toString(), name: "loginScreen");
          if (state.user != null) {
            context.vRouter.to(ANALYTICS_ROUTE, isReplacement: true);
          }
        },
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false, physics: const BouncingScrollPhysics()),
          child: Scaffold(
              backgroundColor: const Color(0xff257261),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Container(
                      constraints:
                          const BoxConstraints(minWidth: 240, maxWidth: 400),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 32),
                      decoration: BoxDecoration(
                          color: const Color(0xffFFB618),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/icons/logo.svg',
                              width: 120,
                              height: 120,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text("Email",
                              style: TextStyle(fontFamily: "Poppins")),
                          const SizedBox(
                            height: 12,
                          ),
                          TextField(
                            cursorColor: const Color(0xffFFB618),
                            controller: _emailController,
                            style: const TextStyle(
                                color: Colors.black, fontFamily: "Poppins"),
                            decoration: InputDecoration(
                                hintText: "someone@example.com",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                        color: Color(0xff257261), width: 2)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Text("Password",
                              style: TextStyle(fontFamily: "Poppins")),
                          const SizedBox(
                            height: 12,
                          ),
                          TextField(
                            cursorColor: const Color(0xffFFB618),
                            controller: _passwordController,
                            style: const TextStyle(
                                color: Colors.black, fontFamily: "Poppins"),
                            obscureText: !isVisible,
                            obscuringCharacter: "•",
                            decoration: InputDecoration(
                                hintText: "•••••••••",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                        color: Color(0xff257261), width: 2)),
                                fillColor: Colors.white,
                                suffixIcon: IconButton(
                                  padding: const EdgeInsets.only(right: 14),
                                  onPressed: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  icon: Icon(
                                    isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black54,
                                  ),
                                ),
                                filled: true),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state is LoginSuccessState) {
                                context
                                    .read<UserAuthenticationBloc>()
                                    .add(const UserAuthenticationEvent());
                              }
                            },
                            builder: (context, state) {
                              return Material(
                                color: const Color(0xff257261),
                                borderRadius: BorderRadius.circular(5),
                                child: InkWell(
                                  onTap: () {
                                    context.read<LoginBloc>().add(
                                        LoginAttemptEvent(
                                            email: _emailController.text,
                                            password:
                                                _passwordController.text));
                                  },
                                  borderRadius: BorderRadius.circular(5),
                                  splashColor:
                                      const Color(0xffFFB618).withOpacity(0.2),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(32)),
                                    child: Center(
                                        child: (state is LoginLoadingState)
                                            ? const LoaderWidget()
                                            : const Text(
                                                "Sign In",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins"),
                                              )),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {},
                              child: const Text(
                                "Forget Password?",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Poppins"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
