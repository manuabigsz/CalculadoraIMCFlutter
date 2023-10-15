import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget {
  final TextEditingController nomeController;
  final TextEditingController pesoController;
  final TextEditingController alturaController;
  final Function onPressed;
  final Function calcularEAdicionarAoHistorico; // Nova função

  ModalBottomSheet({
    required this.nomeController,
    required this.pesoController,
    required this.alturaController,
    required this.onPressed,
    required this.calcularEAdicionarAoHistorico, // Nova função
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Informe seus dados:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          ElevatedButton(
            onPressed: () {
              calcularEAdicionarAoHistorico();
              onPressed();
            },
            child: Text(
              'Calcular IMC',
              style: TextStyle(fontSize: 20),
            ),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(150, 50)),
              padding: MaterialStateProperty.all(EdgeInsets.all(16)),
            ),
          )
        ],
      ),
    );
  }
}
