import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'createAccount.dart';
import 'home.dart';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _login createState() => _login();
}

class _login extends State<login>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;
  bool _mostrarSenha = false;
  String _senha = "";
  String _email = "";
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      drawer: Drawer(),
      body:
      Container(

        height: Get.height,
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
                  height: 230.0
              ),

              SizedBox(
                  width: 10.0,
                  height: 10.0
              ),
              SizedBox(
                width: 300.0,
                child: TextField(
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60)
                    ),
                    labelText: 'Email',
                  ),
                  onChanged: (text){
                    _email = text;
                  },
                ),
              ),
              SizedBox(
                child: SizedBox(
                    width: 10.0,
                    height: 10.0
                ),
              ),
              SizedBox(
                width: 300.0,
                child: TextFormField(
                  obscureText: _mostrarSenha == false ? true : false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60)
                      ),
                      labelText: 'Password',
                      suffixIcon: GestureDetector(
                        child: Icon(_mostrarSenha == false ?   Icons.visibility_off : Icons.visibility, color: Colors.lightBlue),
                        onTap: (){
                          setState(() {
                            _mostrarSenha = !_mostrarSenha;
                          });
                        },
                      )
                  ),
                  onChanged: (text){
                    _senha = text;
                  },
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  _validar();
                },
                child: Text('Entrar'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Não tem uma conta?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => createAccount()));
                    },
                    child: Text('Criar conta'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),


    );
  }
  void _validar() async{
    final prefs = await SharedPreferences.getInstance();
    String nomePrefs = prefs.getString("nome") ?? "sem valor";
    String emailPrefs = prefs.getString("email") ?? "sem valor";
    String senhaPrefs = prefs.getString("senha") ?? "sem valor";


    if (_senha.isEmpty || _email.isEmpty) {
      showDialog(context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Erro"),
              content: Text("Preencha os campos"),
              actions: <Widget>[
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                )
              ]
          );
        },
      );
    }
    else if (_email != emailPrefs || _senha != senhaPrefs) {
      print(emailPrefs);
      print(senhaPrefs);
      showDialog(context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Erro"),
              content: Text("Login e/ou Senha inválido(s)"),
              actions: <Widget>[
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                )
              ]
          );
        },
      );
    }

    else if (_email == emailPrefs && _senha == senhaPrefs) {
      user usuario = new user();

      usuario.nome = prefs.getString("nome") ?? "sem valor";
      usuario.email = _email;
      usuario.telefone = prefs.getString("celular") ?? "sem valor";
      usuario.data = prefs.getString("data") ?? "sem valor";
      usuario.notifiEmail = prefs.getBool("notificacaoE") ?? false;
      usuario.notifiCelular = prefs.getBool("notificacaoT") ?? false;
      Navigator.of(context).pushNamed("/home", arguments: usuario);
    } else {

    }
  }
}