class IMC {
  late double peso;
  late double altura;
  double resultadoIMC = 0.0;
  String classificacao = '';
  String errorMessage = '';

  IMC(double peso, double altura) {
    this.peso = peso;
    this.altura = altura;
    calcularIMC();
  }

  void calcularIMC() {
    if (peso <= 0 || altura <= 0) {
      errorMessage = 'Valores de peso ou altura inválidos.';
      return;
    }

    final imc = peso / (altura * altura);
    resultadoIMC = imc;

    if (resultadoIMC < 16)
      classificacao = 'Magreza grave';
    else if (resultadoIMC < 17)
      classificacao = 'Magreza Moderada';
    else if (resultadoIMC < 18.5)
      classificacao = 'Magreza Leve';
    else if (resultadoIMC < 25)
      classificacao = 'Saudável';
    else if (resultadoIMC < 30)
      classificacao = 'Sobrepeso';
    else if (resultadoIMC < 35)
      classificacao = 'Obesidade Grau I';
    else if (resultadoIMC < 40)
      classificacao = 'Obesidade Grau II (severa)';
    else
      classificacao = 'Obesidade Grau III (mórbida)';
  }

  double get resultadoDoIMC => resultadoIMC;

  String get classificacaoDoIMC => classificacao;
}
