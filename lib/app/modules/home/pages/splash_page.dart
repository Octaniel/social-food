import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/data/provider/auth_provider.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/widgets/loader-widget.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

import '../../../app_controller.dart';

class SplashPage extends StatelessWidget {
  // ignore: missing_return
  Future verificarToken() {
    Future.delayed(Duration(seconds: 2), () async {
      if (await AuthProvider().verificarERenovarToken()) {
        await Get.find<AppController>().refreshUsuario();
        // Get.offNamed(Routes.HOME);
        GetPlatform.isWeb
            ? Get.offNamed(Routes.ADDVIDEOWEB)
            : Get.offNamed(Routes.HOME);
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    verificarToken();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/capa_Feed Food.jpg',
                fit: BoxFit.contain,
              ),
              // TextWidget(
              //   fontWeight: FontWeight.bold,
              //   color: Get.isDarkMode? Colors.white:Colors.black87,
              //   text: 'FeedfooD',
              //   fontSize: 30,
              // ),
              CircularProgressIndicator(
                  backgroundColor: Colors.yellow,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)),
              SizedBox(height: 10,),
              Text("BETA"),
            ],
          ),
        ),
      ),
    );
  }
}
