import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'createAccount.dart';
import 'home.dart';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _home createState() => _home();
}

class _home extends State<home>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



 String _nome = "";
  void carrregaVariaveis() async{
    final prefs = await SharedPreferences.getInstance();
    _nome = prefs.getString("nome") ?? "sem valor";

  }
  void initState() {
    super.initState();
    carrregaVariaveis();
  }
  @override
  Widget build(BuildContext context){
    user usuario = ModalRoute.of(context)?.settings.arguments as user;

    int _currentIndex = 0;

    return Scaffold(
      appBar: AppBar(title: Text("LDDM")),
      drawer: Drawer(),
      body: Container(
         height: Get.height,
         width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: new AssetImage("assets/images/fundo.jpg"),
            //Image.asset("assets/images/fundo.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                  height: 30.0,
                  child: Text("Seja bem vindo, ${usuario.nome} !")
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
        onTap: (index)async{
          final prefs = await SharedPreferences.getInstance();
          String nomePrefs = prefs.getString("nome") ?? "sem valor";
          setState((){
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