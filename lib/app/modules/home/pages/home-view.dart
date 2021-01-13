import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';
import 'package:socialfood/app/widgets/custom_drawer.dart';

import 'dashboard.dart';

class HomeView extends GetView<HomeController> {
  final texteditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // appBar: renderAppBar(),
      body: Dasboard(),
      drawer: CustomDrawer(),
    );
  }

  Widget renderMenu() {
    return Drawer();
  }
}
