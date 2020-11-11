import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';
import 'package:socialfood/app/modules/home/pages/perfil-view.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/theme/theme-controller.dart';
import 'package:socialfood/app/widgets/custom_drawer.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

import '../../../app_controller.dart';
import 'bottom-nav-widget.dart';
import 'feed-view.dart';
import 'inserir-editar-video-view.dart';

class HomeView extends GetView<HomeController> {
  final texteditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: renderAppBar(),
      body: renderBody(),
      drawer: CustomDrawer(),
      // bottomNavigationBar: renderBottomMenu(),
    );
  }

  Widget renderBody() {
    return Container(
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.controller,
        children: [FeedView(), PerfilView(), InserirEditarVideoView()],
      ),
    );
  }

  AppBar renderAppBar() {
    var find = Get.find<AppController>();
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: ()=>Get.toNamed(Routes.PERFIL),
        child: Container(
          margin: EdgeInsets.all(5),
          child: CircleAvatar(
            // radius: 25,
            // child: Icon(Icons.person),
            backgroundImage: NetworkImage(find.usuario.pessoa.fotoUrl),
          ),
        ),
      ),
      // leading: IconButton(
      //     icon: Icon(Icons.restaurant_menu),
      //     onPressed: () {
      //       // _scaffoldKey.currentState.openDrawer();
      //     }),
      title: GetBuilder<HomeController>(
        builder: (_) {
          return !controller.searchBar
              ? TextWidget(
                  text: 'FeedFood',
                )
              : searchBar();
        },
      ),
      actions: [
        // IconButton(
        //     icon: Icon(Icons.lightbulb),
        //     onPressed: () => ThemeController.to.handleThemeChange()),
        // IconButton(
        //     icon: Icon(Icons.filter_list),
        //     onPressed: () => Get.bottomSheet(BottomSheet(
        //         onClosing: () => {},
        //         builder: (context) {
        //           return Container();
        //         }))),
        GetBuilder<HomeController>(
          builder: (_) {
            return !controller.searchBar
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => controller.searchBar = true)
                : Text('');
          },
        ),
        IconButton(
            icon: Icon(Icons.analytics_outlined),
            onPressed: () => Get.toNamed(Routes.MYMATERIALAPP)),
        IconButton(
            icon: Icon(Ionicons.ios_heart_empty),
            onPressed: () {
              Get.offNamed(Routes.FAVORITO);
            }),
        find.usuario.grupo == 'administrador'
            ? IconButton(
                icon: Icon(Icons.video_call),
                onPressed: () {
                  GetPlatform.isWeb?Get.toNamed(Routes.ADDVIDEOWEB):Get.toNamed(Routes.INSERIRVIDEO);
                })
            : Text(''),
      ],
    );
  }

  Widget renderMenu() {
    return Drawer();
  }

  Widget renderBottomMenu() {
    return BottomNavWidget();
  }

  Widget searchBar() {
    return Container(
      width: Get.width * .75,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: Get.isDarkMode
              ? Colors.grey[900]
              : Colors.redAccent.withOpacity(.8),
          borderRadius: BorderRadius.circular(22)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.find<AppController>().usuario.grupo != 'administrador'
                ? Get.width * .7 - 25
                : Get.width * .7 - 73,
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: TextFormField(
              controller: controller.texteditingController,
              onFieldSubmitted: (s) {
                controller.page = 0;
                controller.listarVideo();
                controller.searchBar = false;
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Pesquisar',
                  hintStyle: TextStyle(color: Colors.white),
                  icon: Icon(Icons.search, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
