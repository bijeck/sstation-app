part of 'router.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) {
      logger.e(state.uri);
      return const PageUnderConstruction();
    },
    debugLogDiagnostics: true,
    initialLocation: '/',
    redirect: (context, state) {
      if (state.fullPath != '/') {
        if (state.fullPath!.contains('verifying') ||
            state.fullPath!.contains('sign-in') ||
            state.fullPath!.contains('sign-up') ||
            state.fullPath!.contains('reset-password') ||
            state.fullPath!.contains('enter-phone')) {
          return null;
        }
        LocalUser? user = context.read<UserProvider>().user;
        var tokenBox = Hive.box('token');
        if (tokenBox.isEmpty || !tokenBox.containsKey('userToken')) {
          return joinRoute(['', SignInScreen.routeName]);
        }
        if (user == null) {
          if (state.fullPath != null) {
            var param = Map<String, String>.from(state.uri.queryParameters);
            logger.d('Param $param');
            param.putIfAbsent(
                'forwardRoute', () => state.fullPath!.replaceAll('/', ''));
            return parseRoute(
                route: '/${StagingScreen.routeName}', queryParameters: param);
          }
          return '/';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          var tokenBox = Hive.box('token');
          if (tokenBox.isNotEmpty && tokenBox.containsKey('userToken')) {
            UserToken token = tokenBox.get('userToken');
            var payload = jwtDecode(token.accessToken).payload;
            // Check if token is expired
            var currentTimestamp = DateTime.now().millisecondsSinceEpoch;
            if (currentTimestamp ~/ 1000 < payload['exp']) {
              return const Dashboard();
            }
          }
          // Move to sign in screen if no token found
          return BlocProvider(
            create: (_) => getIt<AuthBloc>(),
            child: const SignInScreen(),
          );
        },
        routes: [
          GoRoute(
            path: StagingScreen.routeName,
            builder: (context, state) {
              var agrs = state.uri.queryParameters;
              if (agrs.containsKey('forwardRoute')) {
                return BlocProvider(
                  create: (_) => getIt<UserProfileBloc>(),
                  child: StagingScreen(
                    forwardRoute: agrs['forwardRoute'] ?? '',
                    param: agrs,
                  ),
                );
              }
              return BlocProvider(
                create: (_) => getIt<AuthBloc>(),
                child: const SignInScreen(),
              );
            },
          ),
          GoRoute(
            path: SignInScreen.routeName,
            builder: (context, state) => BlocProvider(
              create: (_) => getIt<AuthBloc>(),
              child: const SignInScreen(),
            ),
          ),
          GoRoute(
            path: EnterPhoneScreen.routeName,
            builder: (context, state) => BlocProvider(
              create: (_) => getIt<AuthBloc>(),
              child: EnterPhoneScreen(),
            ),
          ),
          GoRoute(
            path: SignUpScreen.routeName,
            builder: (context, state) {
              var agrs = state.uri.queryParameters;
              return BlocProvider(
                create: (_) => getIt<AuthBloc>(),
                child: SignUpScreen(
                  phoneNumber: agrs['phoneNumber'] as String,
                  token: agrs['accessToken'] as String,
                ),
              );
            },
          ),
          GoRoute(
            path: VerificationScreen.routeName,
            builder: (context, state) {
              var agrs = state.uri.queryParameters;
              return BlocProvider(
                create: (_) => getIt<AuthBloc>(),
                child: VerificationScreen(
                  phoneNumber: agrs['phoneNumber'] as String,
                  routeTo: agrs['routeTo'],
                ),
              );
            },
          ),
          GoRoute(
            path: ResetPasswordScreen.routeName,
            builder: (context, state) {
              var agrs = state.uri.queryParameters;
              return BlocProvider(
                create: (_) => getIt<AuthBloc>(),
                child: ResetPasswordScreen(
                  phoneNumber: agrs['phoneNumber'] as String,
                  token: agrs['accessToken'] as String,
                ),
              );
            },
          ),
          GoRoute(
            path: DepositScreen.routeName,
            builder: (context, state) {
              return BlocProvider(
                create: (context) => getIt<PaymentBloc>(),
                child: const DepositScreen(),
              );
            },
          ),
          GoRoute(
            path: NotificationScreen.routeName,
            builder: (context, state) {
              return BlocProvider(
                create: (context) => getIt<NotificationBloc>(),
                child: const NotificationScreen(),
              );
            },
          ),
          GoRoute(
            path: ResultScreen.routeName,
            builder: (context, state) {
              var agrs = state.uri.queryParameters;
              logger.d(agrs.toString());
              if (agrs.containsKey('isSuccess') && agrs['isSuccess'] != null) {
                return ResultScreen(isSuccess: agrs['isSuccess']!.parseBool());
              }
              return const ResultScreen(isSuccess: false);
            },
          ),
          GoRoute(
            path: Dashboard.routeName,
            builder: (context, state) {
              var agrs = state.uri.queryParameters;
              if (agrs.isNotEmpty && agrs['initIndex'] != null) {
                return Dashboard(
                  initIndex: int.parse(agrs['initIndex']!),
                );
              }
              return const Dashboard();
            },
          ),
          GoRoute(
            path: HomePage.routeName,
            builder: (context, state) {
              return const Dashboard();
            },
          ),
          GoRoute(
            path: UserProfileScreen.routeName,
            builder: (context, state) {
              return const Dashboard(initIndex: 3);
            },
          ),
          GoRoute(
            path: PackageScreen.routeName,
            builder: (context, state) {
              return const Dashboard(initIndex: 1);
            },
          ),
          GoRoute(
            path: TransactionScreen.routeName,
            builder: (context, state) {
              return const Dashboard(initIndex: 2);
            },
          ),
          GoRoute(
            path: ChangePasswordScreen.routeName,
            builder: (context, state) {
              return BlocProvider(
                create: (_) => getIt<UserProfileBloc>(),
                child: const ChangePasswordScreen(),
              );
            },
          ),
          GoRoute(
            path: PackageDetailsScreen.routeName,
            builder: (context, state) {
              var agrs = state.uri.queryParameters;
              String? id;
              Package? package;
              if (agrs.containsKey('id')) id = agrs['id'];
              if (state.extra != null) package = state.extra as Package;
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => getIt<PackageBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<PaymentBloc>(),
                  ),
                ],
                child: PackageDetailsScreen(
                  package: package,
                  id: id,
                ),
              );
            },
          ),
          GoRoute(
            path: TransactionDetailsScreen.routeName,
            builder: (context, state) {
              var agrs = state.uri.queryParameters;
              String? id;
              Transaction? transaction;
              if (agrs.containsKey('id')) id = agrs['id'];
              if (state.extra != null) transaction = state.extra as Transaction;
              return BlocProvider(
                create: (context) => getIt<TransactionBloc>(),
                child: TransactionDetailsScreen(
                  transaction: transaction,
                  id: id,
                ),
              );
            },
          ),
          GoRoute(
            path: UpdateProfileScreen.routeName,
            builder: (context, state) {
              return BlocProvider(
                create: (context) => getIt<UserProfileBloc>(),
                child: const UpdateProfileScreen(),
              );
            },
          ),
          GoRoute(
            path: WithdrawStagingScreen.routeName,
            builder: (context, state) {
              return const WithdrawStagingScreen();
            },
          ),
          GoRoute(
            path: WithdrawScreen.routeName,
            builder: (context, state) {
              var agrs = state.uri.queryParameters;
              PaymentProvider provider =
                  (agrs['provider'] as String).toPaymentProvider();
              return BlocProvider(
                create: (context) => getIt<PaymentBloc>(),
                child: WithdrawScreen(provider: provider),
              );
            },
          ),
        ],
      ),
    ],
  );

  static String parseRoute({
    required String route,
    Map<String, dynamic>? queryParameters,
  }) {
    var uri = Uri(path: route, queryParameters: queryParameters);
    return uri.toString();
  }

  static String joinRoute(List<String> routes) {
    var route = routes.join('/');
    return route;
  }
}
