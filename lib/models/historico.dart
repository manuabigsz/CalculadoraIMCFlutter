class Historico {
  List<String> historicoIMC = [];

  void adicionar(String nome, double imc, String classificacao) {
    historicoIMC.add('$nome,${imc.toStringAsFixed(2)},$classificacao');
  }
}
