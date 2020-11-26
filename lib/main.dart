import 'package:firebase_admob/firebase_admob.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/theme-controller.dart';
import 'app/translations/app_translations.dart';
import 'app/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: "ca-app-pub-5970556520110458~2410288769");
  await GetStorage.init();
  Get.lazyPut<ThemeController>(() => ThemeController());
  ThemeController.to.getThemeMode();
  runApp(GetMaterialApp(
    builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
        background: Container(color: Color(0xFFF5F5F5))),
    debugShowCheckedModeBanner: false,
    initialBinding: AppBinding(),
    initialRoute: Routes.SPLASH,
    //Rota inicial
    theme: ThemeData.light().copyWith(primaryColor: Colors.red),
    darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.black),
    themeMode: ThemeController.to.themeMode,
    defaultTransition: Transition.fade,
    // Transição de telas padrão
    getPages: AppPages.pages,
    // Seu array de navegação contendo as rotas e suas pages
    locale: Locale('pt', 'BR'),
    // Língua padrão
    translationsKeys:
        AppTranslation.translations, // Suas chaves contendo as traduções<map>
  ));
}
