import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/modules/configuracao/controllers/configuracao_controller.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/widgets/custom_drawer.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

import '../../../app_controller.dart';

class ConfiguracaoPage extends GetView<ConfiguracaoController>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     drawer: CustomDrawer(),
     key: _scaffoldKey,
     appBar: AppBar(
       elevation: 0,
       leading: GestureDetector(
         onTap: () => Get.toNamed(Routes.PERFIL),
         child: Container(
           margin: EdgeInsets.all(5),
           child: CircleAvatar(
             // radius: 25,
             // child: Icon(Icons.person),
             backgroundImage: NetworkImage(
                 Get.find<AppController>().usuario.pessoa.fotoUrl),
           ),
         ),
       ),
       title: TextWidget(
         text: 'FeedFood',
       ),
     ),
     body: Center(
       child: Text("Configuração"),
     ),
   );
  }

}