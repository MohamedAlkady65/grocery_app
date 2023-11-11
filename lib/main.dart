import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/firebase_options.dart';
import 'package:grocery_app/helper/countries.dart';
import 'package:grocery_app/logic/connection_cubit/connection_cubit.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/logic/settings_cubit/settings_cubit.dart';
import 'package:grocery_app/presentation/home/home_screen.dart';
import 'package:grocery_app/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: false);
  InfoCubit infoCubit = InfoCubit();
  Counrties.init();
  await infoCubit.init();

  runApp(GroceryApp(
    infoCubit: infoCubit,
  ));
}

class GroceryApp extends StatefulWidget {
  const GroceryApp({super.key, required this.infoCubit});
  final InfoCubit infoCubit;
  @override
  State<GroceryApp> createState() => _GroceryAppState();
}

class _GroceryAppState extends State<GroceryApp> {
  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = SettingsCubit();
    settingsCubit.toggleDarkTheme(false);
    settingsCubit.setLocale("ar");
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsCubit(),
        ),
        BlocProvider(
          create: (context) => widget.infoCubit,
        ),
        BlocProvider(
          create: (context) => settingsCubit,
        ),
        BlocProvider(
          create: (context) => ConnectionCubit()..init(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          MyFontWeights.init(settingsCubit.locale?.languageCode);

          return MaterialApp(
            locale: settingsCubit.locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: settingsCubit.locale?.languageCode == "ar"
                    ? MyFonts.rubik
                    : MyFonts.poppins,
                primarySwatch: myPrimaryColor(),
                brightness: settingsCubit.isDarkTheme ?? false
                    ? Brightness.dark
                    : Brightness.light),
            routes: routes,
            initialRoute: HomeScreen.id,
          );
        },
      ),
    );
  }
}
