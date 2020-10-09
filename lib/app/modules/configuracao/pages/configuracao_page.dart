import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/modules/configuracao/controllers/configuracao_controller.dart';
import 'package:socialfood/app/widgets/custom_drawer.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

class ConfiguracaoPage extends GetView<ConfiguracaoController>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     drawer: CustomDrawer(),
     key: _scaffoldKey,
     appBar: AppBar(
       elevation: 0,
       leading: IconButton(
           icon: Icon(Icons.restaurant_menu),
           onPressed: () {
             _scaffoldKey.currentState.openDrawer();
           }),
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