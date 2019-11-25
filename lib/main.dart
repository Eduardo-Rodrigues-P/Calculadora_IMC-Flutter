import 'package:calculadora_imc/pessoa.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { male, feminine }

void main() => runApp(
      MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SingingCharacter _character = SingingCharacter.male;

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String result;
  double weight, height;
  String sexo;

  var pessoa = Pessoa();

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() {
      pessoa.result = 'Informe seu peso e altura ';
      pessoa.cor = Colors.black;
      _character = SingingCharacter.male;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Calculadora Imc"),
    centerTitle: true,
    flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                center: const Alignment(0.7, -0.6),
                radius: 3.0,
                colors: [
                    Colors.black,
                    Color(0xffc11c34),
                ],
                stops: [0.5, 1],
            ),
        ),
    ),
      backgroundColor: Colors.green,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetFields();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            title: const Text('Masculino'),
            leading: Radio(
              value: SingingCharacter.male,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Feminino'),
            leading: Radio(
              value: SingingCharacter.feminine,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          buildTextFormField(
              label: "Peso (kg)",
              error: "Insira seu peso!",
              controller: _weightController),
          buildTextFormField(
              label: "Altura (cm)",
              error: "Insira uma altura!",
              controller: _heightController),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }

  Widget buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        color: Colors.black,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            setState(() {
              setVariable();
              pessoa = Pessoa(weight: weight, height: height, sexo: sexo);
              pessoa.calculateImc();
            });
          }
        },
        child: Text('CALCULAR', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        pessoa.result ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: pessoa.cor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }

  void setVariable() {
    weight = double.parse(_weightController.text);
    height = double.parse(_heightController.text) / 100.0;

    if (_character == SingingCharacter.male)
      sexo = "male";
    else
      sexo = "feminine";
  }
}
