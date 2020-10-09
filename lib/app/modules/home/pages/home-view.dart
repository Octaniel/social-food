import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';
import 'package:socialfood/app/modules/home/pages/perfil-view.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/theme/theme-controller.dart';
import 'package:socialfood/app/widgets/custom_drawer.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

import 'bottom-nav-widget.dart';
import 'feed-view.dart';
import 'inserir-editar-video-view.dart';

class HomeView extends GetView<HomeController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: renderAppBar(),
      body: renderBody(),
      drawer: CustomDrawer(),
      bottomNavigationBar: renderBottomMenu(),
    );
  }

  Widget renderBody() {
    return Container(
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.controller,
        children: [
          FeedView(),
          PerfilView(),
          InserirEditarVideoView()
        ],
      ),
    );
  }

  Widget renderAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
          icon: Icon(Icons.restaurant_menu),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          }),
      title: TextWidget(
        text: 'FeedFood',
      ),
      actions: [

        IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: () => ThemeController.to.handleThemeChange()),
        IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => Get.bottomSheet(BottomSheet(
                onClosing: () => {},
                builder: (context) {
                  return Container();
                }))),
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () => ThemeController.to.handleThemeChange()),
        IconButton(icon: Icon(Icons.video_call), onPressed: () {
          Get.toNamed(Routes.INSERIRVIDEO);
        }),
      ],
    );
  }

  Widget renderMenu() {
    return Drawer();
  }

  Widget renderBottomMenu() {
    return BottomNavWidget();
  }
}
