import 'package:flutter/material.dart';
import 'package:flutter_database1/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  var idade = '';
  var nome = '';
  // referencia nossa classe single para gerenciar o banco de dados
  final dbHelper = DatabaseHelper.instance;

  // layout da homepage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo de CRUD básico sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300.0,
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60)
                  ),
                  labelText: 'Nome',
                ),
                onChanged: (text){
                  nome = text;
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
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60)
                  ),
                  labelText: 'Idade',
                ),
                  onChanged: (text){
                    idade = text;
                  },
              ),
            ),
            ElevatedButton(
              child: Text('Inserir dados', style: TextStyle(fontSize: 20),),
              onPressed: () {_inserir(idade,nome);},
            ),
            ElevatedButton(
              child: Text('Consultar dados', style: TextStyle(fontSize: 20),),
              onPressed: () {_consultar();},
            ),
            ElevatedButton(
              child: Text('Atualizar dados', style: TextStyle(fontSize: 20),),
              onPressed: () {_atualizar(nome, idade);},
            ),
            ElevatedButton(
              child: Text('Deletar dados', style: TextStyle(fontSize: 20),),
              onPressed: () {_deletar();},
            ),
          ],
        ),
      ),
    );
  }

  // Button onPressed methods

  void _inserir(var idade, var nome) async {
    // linha para inserir
    Map<String, dynamic> row = {
      DatabaseHelper.columnNome : nome,
      DatabaseHelper.columnIdade  : idade
    };
    final id = await dbHelper.insert(row);
    print('linha inserida id: $id');
  }

  void _consultar() async {
    final todasLinhas = await dbHelper.queryAllRows();
    print('Consulta todas as linhas:');
    todasLinhas.forEach((row) => print(row));
  }

  void _atualizar(var nome, var idade) async {
    // linha para atualizar
    Map<String, dynamic> row = {
      DatabaseHelper.columnId : 1,
      DatabaseHelper.columnNome : 'Luís',
      DatabaseHelper.columnIdade  :  20
    };
    final linhasAfetadas = await dbHelper.update(row);
    print('atualizadas $linhasAfetadas linha(s)');
  }

  void _deletar() async {
    // Assumindo que o numero de linhas é o id para a última linha
    final id = await dbHelper.queryRowCount();
    final linhaDeletada = await dbHelper.delete(id);
  print('id $id');
    print('Deletada(s) $linhaDeletada linha(s): linha $nome');
  }
}