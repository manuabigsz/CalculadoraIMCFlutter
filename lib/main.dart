import 'package:flutter/material.dart';
import 'Pessoa.dart';

double calcularIMC(Pessoa pessoa) {
  return pessoa.peso / (pessoa.altura * pessoa.altura);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  double resultadoIMC = 0.0;
  String Classificacao = '';
  String errorMessage = '';

  void calcular() {
    final nome = nomeController.text;
    final pesoText = pesoController.text;
    final alturaText = alturaController.text;

    try {
      final peso = double.parse(pesoText);
      final altura = double.parse(alturaText);

      if (nome.isNotEmpty && peso > 0 && altura > 0) {
        final pessoa = Pessoa(nome: nome, peso: peso, altura: altura);
        final imc = calcularIMC(pessoa);

        setState(() {
          resultadoIMC = imc;
          if (resultadoIMC < 16) Classificacao = 'Magreza grave';
          if (16 <= resultadoIMC && resultadoIMC < 17)
            Classificacao = 'Magreza Moderada';
          if (17 <= resultadoIMC && resultadoIMC < 18.5)
            Classificacao = 'Magreza Leve';
          if (18.5 <= resultadoIMC && resultadoIMC < 25)
            Classificacao = 'Saudável';
          if (25 <= resultadoIMC && resultadoIMC < 30)
            Classificacao = 'Sobrepeso';
          if (30 <= resultadoIMC && resultadoIMC < 35)
            Classificacao = 'Obesidade Grau I';
          if (35 <= resultadoIMC && resultadoIMC < 40)
            Classificacao = 'Obesidade Grau II (severa)';
          if (resultadoIMC >= 40)
            Classificacao = 'Obesidade Grau III (mórbida)';
          errorMessage = '';
        });
        return;
      }
    } catch (e) {
      errorMessage = 'Valores de peso ou altura inválidos.';
    }

    setState(() {
      resultadoIMC = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        toolbarHeight: 80,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Informe seus dados:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nome',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Peso (kg)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Altura (m)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: calcular,
                  child: Text('Calcular IMC'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              errorMessage,
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            if (resultadoIMC != 0)
              Text(
                'Resultado do IMC:',
                style: TextStyle(fontSize: 18),
              ),
            if (resultadoIMC != 0)
              Text(
                'O IMC de ${nomeController.text} é ${resultadoIMC.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            if (Classificacao != '')
              Text(
                Classificacao,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
