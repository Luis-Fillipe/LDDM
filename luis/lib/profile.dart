import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'user.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profile createState() => _profile();
}

class _profile extends State<profile> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double valor = 20;
  String label = "";

  @override
  Widget build(BuildContext context) {
    user usuario = ModalRoute.of(context)?.settings.arguments as user;
    int _currentIndex = 2;
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      drawer: Drawer(),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: new AssetImage("assets/images/fundo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              SizedBox(
                width: 300.0,
                child: Text("Nome: "+usuario.nome),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: 300.0,
                child: Text("Email: "+usuario.email),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: 300.0,
                child: Text("Telefone: "+usuario.telefone),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: 300.0,
                child: Text("Data de Nascimento: "+usuario.data),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: 300.0,
                child: Text("Notificação por Email: "+usuario.notifiEmail.toString()),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: 300.0,
                child: Text("Notificação por Celular: "+usuario.notifiCelular.toString()),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        onTap: (index) async {
          final prefs = await SharedPreferences.getInstance();
          setState(()  {
            _currentIndex = index;
            if(index == 0){
              Navigator.of(context).pushNamed("/home", arguments: usuario);
            } else if(index == 1){
              Navigator.of(context).pushNamed("/list", arguments: usuario);
            }
            else if(index == 2){
              Navigator.of(context).pushNamed("/profile", arguments: usuario);
            }
          });
        },),
    );

  }
}

