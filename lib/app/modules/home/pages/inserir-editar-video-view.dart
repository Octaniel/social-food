import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';
import 'package:socialfood/app/res/util.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/theme/theme-controller.dart';
import 'package:socialfood/app/widgets/custom_drawer.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

import 'bottom-nav-widget.dart';

class InserirEditarVideoView extends GetView<HomeController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: renderAppBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: renderBottomMenu(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextFormField(
                onChanged: (v) => controller.video.url = v,
                decoration: InputDecoration(
                    labelStyle: GoogleFonts.muli(), labelText: 'Url do vídeo'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(

                maxLines: 3,
                onChanged: (v){
                  controller.video.descricao = v;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Descrição',
                  // contentPadding: EdgeInsets.all(5)
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextWidget(text: 'Caso esteja tudo pronto, clique no botão abaixo'),
              SizedBox(
                height: 10,
              ),
              Container(
                width: Get.width,
                height: 50,
                child: RaisedButton(
                    color: !isDarkMode ? Colors.red : Colors.black,
                    elevation: 0,
                    child: TextWidget(
                      text: 'Enviar para aprovação',
                      color: Colors.white,
                    ),
                    onPressed: () => inserirVideo()),
              )
            ],
          ),
        ),
      ),
    );
  }

  inserirVideo() async {
      if (await controller.inserirVideo()) {
        Get.rawSnackbar(
            icon: Icon(FontAwesomeIcons.check),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF3CFEB5),
            messageText: Text(
              'Enviado com sucesso',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
      } else {
        Get.rawSnackbar(
            icon: Icon(
              FontAwesomeIcons.erlang,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFFFE3C3C),
            messageText: Text(
              'Houve problema no envio',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
      }
    }

  Widget renderMenu() {
    return Drawer();
  }

  Widget renderBottomMenu() {
    return BottomNavWidget();
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
        IconButton(icon: Icon(Ionicons.ios_home), onPressed: () {
          Get.toNamed(Routes.HOME);
        }),
        IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: () => ThemeController.to.handleThemeChange()),
      ],
    );
  }
}
