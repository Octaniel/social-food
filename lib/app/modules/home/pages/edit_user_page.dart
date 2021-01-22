import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/app_controller.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';
import 'package:socialfood/app/modules/home/widgets/render-app-bar.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/widgets/text-form-widget.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

class EditUserPage extends GetView<HomeController> {
  final _ttxeEditingcontroller1 = TextEditingController();
  final _ttxeEditingcontroller2 = TextEditingController();
  final _ttxeEditingcontroller3 = TextEditingController();
  final _ttxeEditingcontroller4 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _ttxeEditingcontroller1.text = controller.usuario.pessoa.nome;
    _ttxeEditingcontroller2.text = controller.usuario.pessoa.apelido;
    _ttxeEditingcontroller3.text = controller.usuario.pessoa.telemovel;
    _ttxeEditingcontroller4.text = controller.usuario.pessoa.email;

    return Scaffold(
      appBar: renderAppBar(true, isUsers: true),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: Get.height * .2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextWidget(
                    text: 'Atualizar Usuario',
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
                  height: 426,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormFieldWidget(
                            controller: _ttxeEditingcontroller1,
                            label: 'Nome',
                            onChanged: (v) =>
                                controller.usuario.pessoa.nome = v,
                            isObscure: false,
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            inputType: TextInputType.name,
                            validator: (value) {
                              var nome = controller.usuario.pessoa.nome;
                              if (GetUtils.isNullOrBlank(nome))
                                return "Preencha o seu nome";
                              return null;
                            }),
                        TextFormFieldWidget(
                            controller: _ttxeEditingcontroller2,
                            label: 'Sobrenome',
                            onChanged: (v) =>
                                controller.usuario.pessoa.apelido = v,
                            isObscure: false,
                            icon: Icon(
                              FontAwesomeIcons.personBooth,
                              color: Colors.black,
                            ),
                            inputType: TextInputType.name,
                            validator: (value) {
                              var nome = controller.usuario.pessoa.apelido;
                              if (GetUtils.isNullOrBlank(nome))
                                return "Preencha o seu Sobrenome";
                              return null;
                            }),
                        TextFormFieldWidget(
                            controller: _ttxeEditingcontroller3,
                            label: 'Telemovel',
                            onChanged: (v) =>
                                controller.usuario.pessoa.telemovel = v,
                            isObscure: false,
                            icon: Icon(
                              FontAwesomeIcons.mobile,
                              color: Colors.black,
                            ),
                            inputType: TextInputType.number,
                            validator: (value) {
                              var nome = controller.usuario.pessoa.telemovel;
                              if (GetUtils.isNullOrBlank(nome))
                                return "Preencha o seu Telemovel";
                              return null;
                            }),
                        TextFormFieldWidget(
                            controller: _ttxeEditingcontroller4,
                            label: 'E-mail',
                            onChanged: (v) =>
                                controller.usuario.pessoa.email = v,
                            isObscure: false,
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            inputType: TextInputType.emailAddress,
                            validator: (value) {
                              var email = controller.usuario.pessoa.email;
                              if (GetUtils.isNullOrBlank(email))
                                return "Preencha o seu e-mail";
                              if (!GetUtils.isEmail(email))
                                return "E-mail inválido";
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
                                          text: "ATUALIZAR",
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  validarForm() async {
    if (formKey.currentState.validate()) {
      controller.carregando = true;
      var list = await controller.saveUser();
      if (list.elementAt(0) == true) {
        Get.find<AppController>().refreshUsuario();
        Get.rawSnackbar(
            icon: Icon(FontAwesomeIcons.check),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF3CFEB5),
            messageText: Text(
              '${list.elementAt(1)}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(Get.context);
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
              '${list.elementAt(1)}',
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
