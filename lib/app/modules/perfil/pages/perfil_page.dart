import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/widgets/custom_drawer.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

import '../../../app_controller.dart';

class PerfilPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var usuario = Get.find<AppController>().usuario;
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.restaurant_menu),
            onPressed: () {
              Get.offNamed(Routes.HOME);
              // Navigator.pop(Get.context);
            }),
        title: TextWidget(
          text: 'FeedFood',
        ),
        actions: [
          IconButton(
            tooltip: 'Sair',
            onPressed: () async {
              if (await Get.find<AppController>().logout()) {
                Get.offAllNamed(Routes.LOGIN);
              }
            },
            icon: Icon(FontAwesomeIcons.signOutAlt),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 10, right: 5, left: 5),
          children: [
            Container(
              child: Center(
                child: CircleAvatar(
                  radius: 55,
                  // child: Icon(Icons.person),
                  backgroundImage: NetworkImage(usuario.pessoa.fotoUrl),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${usuario.pessoa.nome} ${usuario.pessoa.apelido}',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
