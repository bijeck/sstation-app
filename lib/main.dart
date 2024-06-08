import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:sstation/core/common/app/providers/hive_provider.dart';
import 'package:sstation/core/common/app/providers/user_provider.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/fonts.dart';
import 'package:sstation/core/services/firebase/firebase_message.dart';
import 'package:sstation/core/services/firebase/firebase_options.dart';
import 'package:sstation/core/services/firebase/local_message.dart';
import 'package:sstation/core/services/injections/injections.dart';
import 'package:sstation/core/services/router/router.dart';
import 'package:sstation/features/auth/data/models/user_token_model.dart';
import 'package:sstation/features/profile/data/entities/device_model.dart';
import 'package:sstation/features/profile/data/entities/user_model.dart';
import 'package:sstation/features/profile/data/entities/wallet_model.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  registerApdapaters();

  await configureDependencies();

  await Hive.openBox('token');

  await Hive.openBox('notification');

  await Hive.openBox('language');

  await LocalMessage().initNotification();

  await FirebaseMessage().initNotification();

  GoRouter.optionURLReflectsImperativeAPIs = true;

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      saveLocale: true,
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      startLocale: HiveProvider.getLocale(),
      useOnlyLangCode: true,
      child: const MyApp(),
    ),
  );
}

void registerApdapaters() {
  Hive.registerAdapter(UserTokenModelAdapter());
  Hive.registerAdapter(LocalUserModelAdapter());
  Hive.registerAdapter(WalletModelAdapter());
  Hive.registerAdapter(DeviceModelAdapter());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'SStation App',
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colours.backgroundColour,
          fontFamily: Fonts.base,
          appBarTheme: const AppBarTheme(
            color: Colours.backgroundColour,
          ),
        ),
        routerConfig: AppRoute.router,
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}
