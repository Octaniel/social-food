import 'package:get/get.dart';
import 'package:socialfood/app/modules/auth/auth_binding.dart';
import 'package:socialfood/app/modules/auth/pages/login_page.dart';
import 'package:socialfood/app/modules/auth/pages/registro_page.dart';
import 'package:socialfood/app/modules/configuracao/configuracao_binding.dart';
import 'package:socialfood/app/modules/configuracao/pages/configuracao_page.dart';
import 'package:socialfood/app/modules/favoritos/favorito_binding.dart';
import 'package:socialfood/app/modules/favoritos/pages/favorito_page.dart';
import 'package:socialfood/app/modules/home/home_binding.dart';
import 'package:socialfood/app/modules/home/pages/add_video_page.dart';
import 'package:socialfood/app/modules/home/pages/feed-view.dart';
import 'package:socialfood/app/modules/home/pages/home-view.dart';
import 'package:socialfood/app/modules/home/pages/splash_page.dart';
import 'package:socialfood/app/modules/home/pages/users_page.dart';
import 'package:socialfood/app/modules/perfil/pages/perfil_page.dart';
import 'package:socialfood/app/modules/perfil/perfil_binding.dart';

import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.LOGIN, page: () => LoginPage(), binding: AuthBinding()),
    GetPage(
        name: Routes.REGISTRAR,
        page: () => RegistroPage(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.CONFIGURACAO,
        page: () => ConfiguracaoPage(),
        binding: ConfiguracaoBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Routes.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.FEED,
        page: () => FeedView(),
        binding: HomeBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.USERS,
        page: () => UsersPage(),
        binding: HomeBinding(),
        transition: Transition.downToUp),
    // GetPage(name: Routes.MYMATERIALAPP, page: () => MyMaterialApp(), binding: HomeBinding(), transition: Transition.downToUp),
    GetPage(
        name: Routes.ADDVIDEOWEB,
        page: () => AddVideoWebPage(),
        binding: HomeBinding(),
        transition: Transition.downToUp),
    GetPage(name: Routes.SPLASH, page: () => SplashPage()),
    GetPage(
        name: Routes.FAVORITO,
        page: () => FavoritoPage(),
        binding: FavoritoBinding(),
        transition: Transition.upToDown),
    GetPage(
        name: Routes.PERFIL,
        page: () => PerfilPage(),
        binding: PerfilBinding(),
        transition: Transition.zoom),
  ];
}
