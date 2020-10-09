import 'package:flutter/material.dart';
import 'package:socialfood/app/widgets/custom_drawer.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

class PerfilPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
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
      body: Container(
        child: Center(
          child: TextWidget(text: 'Perfil'),
        ),
      ),
    );
  }
}
