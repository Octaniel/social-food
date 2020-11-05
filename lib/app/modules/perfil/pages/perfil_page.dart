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
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              child: Stack(
                children: [
                  ClipRRect(
                    child: Image.asset(
                      'images/back_perfil.jpg',
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50)),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Center(
                          child: CircleAvatar(
                            radius: 55,
                            // child: Icon(Icons.person),
                            backgroundImage:
                                NetworkImage(usuario.pessoa.fotoUrl),
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
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Dados Pessoais",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Text("VISUALIZE SUAS INFORMAÇÕES"),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      "Atualização dos eus dados pessoais",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Text("MANTENHA-SE ATUALIZADO"),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      "Alterar Senha",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Text("CRIE UMA NOVA SENHA"),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      "Configuração",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: 3),
                      child:
                          Text("CONFIGURA O APP DE JEITO QUE ACHARES MELHOR"),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () async {
                      if (await Get.find<AppController>().logout()) {
                        Get.offAllNamed(Routes.LOGIN);
                      }
                    },
                    title: Text(
                      "Sair",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  Divider(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
