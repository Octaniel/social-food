import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';

class VideoDetalheView extends GetView<HomeController> {
  final String videoid;

  VideoDetalheView({Key key, this.videoid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
        initState: (_) {},
        builder: (controller) {
          return Scaffold(
            appBar: renderAppBar(),
          );
        });
  }

  renderAppBar() {
    return AppBar();
  }
}
