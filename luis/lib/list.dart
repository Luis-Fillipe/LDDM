import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'createAccount.dart';
import 'home.dart';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class list extends StatefulWidget {
  const list({Key? key}) : super(key: key);

  @override
  _list createState() => _list();
}

class _list extends State<list>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List _itens = [];
  void _carregarItens(){
    _itens = [];
    for(int i = 0; i <= 20; i++){

      Map<String, dynamic> item = Map();
      item["titulo"] = "Titulo ${i} da lista";
      item["descricao"] = "Descricao ${i} da lista";
      _itens.add(item);
    }
  }
  @override
  Widget build(BuildContext context){
    int _currentIndex = 1;
    user usuario = ModalRoute.of(context)?.settings.arguments as user;
    _carregarItens();

    return Scaffold(
      appBar: AppBar(title: Text("List")),
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
                   child: ListView.builder(
                       scrollDirection: Axis.vertical,
                       shrinkWrap: true,
                       itemCount: _itens.length,
                       itemBuilder: (BuildContext context, int indice){
                         return ListTile(
                           onTap: (){
                             showDialog(
                               context: context,
                               builder: (context){
                                 return AlertDialog(
                                   title: Text("Alerta"),
                                   content: Text("Você clicou no item ${indice}"),
                                   actions: <Widget>[
                                     ElevatedButton(
                                         onPressed: (){
                                           Navigator.pop(context);
                                          },
                                         child: Text("Voltar"))
                                   ],
                                 );
                               }
                             );
                           },
                           title: Text(_itens[indice]["titulo"]),
                           subtitle: Text(_itens[indice]["descricao"]),
                         );
                       }
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