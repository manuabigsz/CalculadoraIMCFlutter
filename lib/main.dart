import 'package:flutter/material.dart';
import 'models/IMC.dart';
import 'models/historico.dart';
import 'pages/formulario_imc_modal.dart';

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
  List<String> historicoIMC = [];

  Historico historico = Historico();

  void _abrirModal() {
    nomeController.clear();
    pesoController.clear();
    alturaController.clear();
    resultadoIMC = 0;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ModalBottomSheet(
          nomeController: nomeController,
          pesoController: pesoController,
          alturaController: alturaController,
          onPressed: () {
            Navigator.pop(context);
          },
          calcularEAdicionarAoHistorico: () {
            if (resultadoIMC == 0) {
              final imc = IMC(
                double.tryParse(pesoController.text) ?? 0,
                double.tryParse(alturaController.text) ?? 0,
              );
              imc.calcularIMC();
              if (imc.errorMessage.isEmpty) {
                resultadoIMC = imc.resultadoIMC;
                Classificacao = imc.classificacaoDoIMC;

                historico.adicionar(
                  nomeController.text,
                  resultadoIMC,
                  Classificacao,
                );

                setState(() {});
              }
            }
          },
        );
      },
    );
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
            if (historico.historicoIMC.isEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Seja bem-vindo ao projeto desenvolvido no Santander Bootcamp 2023 - Mobile com Flutter!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            if (Classificacao != '')
              Text(
                'Resultado do IMC:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            if (Classificacao != '')
              Text(
                'O IMC de ${nomeController.text} é ${resultadoIMC.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            if (Classificacao != '')
              Text(
                'Classificado como $Classificacao',
                style: TextStyle(fontSize: 24),
              ),
            SizedBox(
              height: 20,
            ),
            if (historico.historicoIMC.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Histórico de IMC:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Nome')),
                      DataColumn(label: Text('IMC')),
                      DataColumn(label: Text('Classificação')),
                    ],
                    rows: historico.historicoIMC.map((item) {
                      var values = item.split(', ');
                      return DataRow(
                        cells: [
                          DataCell(Text(values[0])),
                          DataCell(Text(values[1])),
                          DataCell(Text(values[2])),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirModal,
        child: Icon(Icons.add),
      ),
    );
  }
}
