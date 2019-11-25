import 'package:flutter/material.dart';

class Pessoa {
  double imc, height, weight;
  String result, sexo;
  Color cor;

  Pessoa({this.height, this.weight, this.sexo});

  void calculateImc() {
    imc = weight / (height * height);

    classificar();
  }

  void classificar() {
    result = "IMC = ${imc.toStringAsPrecision(3)}\n";
    if (sexo == "male") {
      if (imc < 20.7) {
        result += "Abaixo do peso";
        cor = Colors.black;
      } else if (imc < 26.4) {
        result += "Peso ideal";
        cor = Colors.lightGreen;
      } else if (imc < 27.8) {
        result += "Pouco acima do peso";
        cor = Colors.blueGrey;
      } else if (imc < 31.1) {
        result += "Acima do peso";
        cor = Colors.blue;
      } else {
        result += "Obesidade";
        cor = Colors.red[900];
      }
    } else {
      if (imc < 19.1) {
        result += "Abaixo do peso";
        cor = Colors.yellow;
      } else if (imc < 25.8) {
        result += "Peso ideal";
        cor = Colors.lightGreen;
      } else if (imc < 27.3) {
        result += "Pouco acima do peso";
        cor = Colors.red[200];
      } else if (imc < 32.3) {
        result += "Acima do peso";
        cor = Colors.red[400];
      } else {
        result += "Obesidade";
        cor = Colors.red[900];
      }
    }
  }
}
