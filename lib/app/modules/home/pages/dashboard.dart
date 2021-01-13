import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphic/graphic.dart' as graphic;
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';
import 'package:socialfood/app/modules/home/widgets/render-app-bar.dart';

class Dasboard extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Scaffold(
          appBar: renderAppBar(true),
          body: SafeArea(
              child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cardDash(
                      controller.totalUsuario,
                      "Total de usuarios cadastrados no app",
                      0xFF605ca8,
                      FontAwesomeIcons.users),
                  SizedBox(
                    width: 5,
                  ),
                  cardDash(
                      controller.totalVideo,
                      "Total de videos disponivel no app",
                      0xFF00a65a,
                      FontAwesomeIcons.video),
                  SizedBox(
                    width: 5,
                  ),
                  cardDash(
                      controller.totalUsuarioUltimo30Dias,
                      "Total de usuarios cadastrados no app no ultimo 30 dias",
                      0xFFf39c12,
                      FontAwesomeIcons.userClock),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "   Adesão de Usuarios",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              if (!controller.usuariosResumo.isBlank)
                Container(
                  width: 350,
                  height: 300,
                  child: graphic.Chart(
                    data: controller.usuariosResumo,
                    scales: {
                      'mes': graphic.CatScale(
                        accessor: (map) => map['mes'] as String,
                      ),
                      'quntidade': graphic.LinearScale(
                        accessor: (map) => map['quntidade'] as num,
                        nice: true,
                      )
                    },
                    geoms: [
                      graphic.IntervalGeom(
                        position: graphic.PositionAttr(field: 'mes*quntidade'),
                        shape: graphic.ShapeAttr(values: [
                          graphic.RectShape(radius: Radius.circular(5))
                        ]),
                      )
                    ],
                    axes: {
                      'mes': graphic.Defaults.horizontalAxis,
                      'quntidade': graphic.Defaults.verticalAxis,
                    },
                  ),
                )
              else
                Container(),
            ],
          )),
        );
      },
    );
  }

  Container cardDash(int total, String descricao, int color, IconData icon) {
    return Container(
      width: 300,
      height: 80,
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Text(
            "       $total",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "$descricao",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          trailing: Icon(
            icon,
            color: Colors.white.withOpacity(0.4),
          ),
        ),
        color: Color(color),
        shadowColor: Color(color),
      ),
    );
  }
}
