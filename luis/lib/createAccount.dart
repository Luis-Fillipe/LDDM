import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class createAccount extends StatefulWidget {
  const createAccount({Key? key}) : super(key: key);

  @override
  _createAccount createState() => _createAccount();
}
enum genero {Masculino, Feminino}
class _createAccount extends State<createAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;
  bool _mostrarSenha = false;
  bool _email = false;
  genero? _genero = null;
  bool _telefone = false;
  double valor = 20;
  String _nome = "";
  String _senha = "";
  String _emailInput = "";
  String _data = "";
  String _celular = "";
  String _genero2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
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
              SizedBox(height: 10.0),
              SizedBox(
                width: 300.0,
                child: TextField(
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: valor
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60)),
                    labelText: 'Nome (*)',
                  ),
                  onChanged: (text){
                    _nome = text;
                  },
                  maxLength: 25,
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: 300.0,
                child: TextField(
                  obscureText: false,
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(
                      fontSize: valor
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60)),
                    labelText: 'Data de Nascimento',
                  ),
                  onChanged: (text){
                    _data = text;
                  },
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: 300.0,
                child: TextField(
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      fontSize: valor
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60)),
                    labelText: 'Telefone',
                  ),
                  onChanged: (text){
                    _celular = text;
                  },
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: 300.0,
                child: TextField(
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      fontSize: valor
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60)),
                    labelText: 'Email (*)',
                  ),
                  onChanged: (text){
                    _emailInput = text;
                  },
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: 300.0,
                child: TextFormField(
                  obscureText: _mostrarSenha == false ? true : false,
                  style: TextStyle(
                      fontSize: valor
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60)),
                      labelText: 'Senha (*)',
                      suffixIcon: GestureDetector(
                        child: Icon(
                            _mostrarSenha == false
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.lightBlue),
                        onTap: () {
                          setState(() {
                            _mostrarSenha = !_mostrarSenha;
                          });
                        },

                      )),
                  onChanged: (text){
                    _senha = text;
                  },
                  maxLength: 15,
                ),
              ),
              SizedBox(height: 15),
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(32),
                ),
                Text("Masculino"),
                Radio<genero>(
                    value: genero.Masculino,
                    groupValue: _genero,
                    onChanged: (genero? a){
                      setState(() {
                        _genero = genero.Masculino;
                      });
                    }),
                Text("Feminino"),
                Radio<genero>(
                    value: genero.Feminino,
                    groupValue: _genero,
                    onChanged: (genero? a){
                      setState(() {
                        _genero = genero.Feminino;
                      });
                    }),
              ]),
              SizedBox(height: 15),
              Text("Notificações:"),
              SwitchListTile(
                activeColor: Colors.lightBlue,
                title: Text("Email"),
                value: _email,
                onChanged: (bool valor){
                    setState(() {
                      _email = valor;
                    });
                  }),
              SwitchListTile(
                  activeColor: Colors.lightBlue,
                  title: Text("Telefone"),
                  value: _telefone,
                  onChanged: (bool valor){
                    setState(() {
                      _telefone = valor;
                    });
                  }),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: (){
                  _salvarDados();
                },
                child: Text('Cadastrar'),
              ),
              SizedBox(height: 15),
              Slider(
                  value: valor,
                  min: 05,
                  max: 50,
                  divisions: 10,
                  onChanged: (double novoValor){
                    setState(() {
                      valor = novoValor;
                    });
                  }
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Já é cadastrado?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => login()));
                    },
                    child: Text('Fazer Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );

  }
  void _salvarDados() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", _nome);
    await prefs.setString("email", _emailInput);
    await prefs.setString("telefone", _celular);
    await prefs.setString("data", _data);
    await prefs.setString("senha", _senha);
    await prefs.setBool("notificacaoE", _email);
    await prefs.setBool("notificacaoT", _telefone);
    if(_nome.isEmpty || _emailInput.isEmpty || _senha.isEmpty){
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
    } else {
      showDialog(context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Sucesso"),
              content: Text("Siga para o login"),
              actions: <Widget>[
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/login");
                    }
                )
              ]
          );
        },
      );
    }
  }
}

