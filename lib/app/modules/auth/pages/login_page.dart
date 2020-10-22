import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/app_controller.dart';
import 'package:socialfood/app/modules/auth/controllers/auth_controller.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/widgets/text-form-widget.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

class LoginPage extends GetView<AuthController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextWidget(
                text: GetPlatform.isWeb?'FEEDFOOD ADMIN':'FEEDFOOD',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(143, 148, 251, .2),
                        blurRadius: 20.0,
                        offset: Offset(0, 10))
                  ]),
              width: 300,
              height: GetPlatform.isWeb?270:312,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                        label: 'E-mail',
                        onChanged: (v) => controller.email = v,
                        isObscure: false,
                        icon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          var email = controller.email;
                          if (GetUtils.isNullOrBlank(email))
                            return "Preencha o seu e-mail";
                          if (!GetUtils.isEmail(email))
                            return "E-mail inválido";
                          return null;
                        }),
                    TextFormFieldWidget(
                        label: 'Senha',
                        onChanged: (v) => controller.senha = v,
                        isObscure: true,
                        icon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                        inputType: TextInputType.text,
                        validator: (value) {
                          var senha = controller.senha;
                          if (GetUtils.isNullOrBlank(senha))
                            return "Preencha a sua senha";
                          return null;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: Get.width - 30,
                      height: 40,
                      child: RaisedButton(
                          color: Colors.grey[300],
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: Obx(
                              () => controller.carregando
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : TextWidget(
                                      text: "LOGAR",
                                      color: Colors.black,
                                    ),
                            )),
                          ),
                          onPressed: !controller.carregando
                              ? () {
                                  validarForm();
                                }
                              : null),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GetPlatform.isWeb?Text(''):InkWell(
                      onTap: () {
                        Get.toNamed(Routes.REGISTRAR);
                      },
                      child: Text('Eu não tenho conta', style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        color: Color(0xFF575E63),

                      ),)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  validarForm() async {
    if (formKey.currentState.validate()) {
      controller.carregando = true;
      if (await controller.logar()) {
        Get.find<AppController>().refreshUsuario();
        Get.rawSnackbar(
            icon: Icon(FontAwesomeIcons.check),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF3CFEB5),
            messageText: Text(
              'Seja Bem vindo',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
        Future.delayed(Duration(seconds: 2), () {
          GetPlatform.isWeb?Get.offAllNamed(Routes.ADDVIDEOWEB):Get.offAllNamed(Routes.HOME);
        });
      } else {
        Get.rawSnackbar(
            icon: Icon(
              FontAwesomeIcons.times,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFFFE3C3C),
            messageText: Text(
              'Senha ou E-mail Invalido',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
        Future.delayed(Duration(seconds: 2), () {});
      }
      controller.carregando = false;
    }
  }
}
