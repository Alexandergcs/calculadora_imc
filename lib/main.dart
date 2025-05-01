import 'package:flutter/material.dart';

void main() => runApp(AppCalculadoraIMC());

class AppCalculadoraIMC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      debugShowCheckedModeBanner: false,
      home: TelaPrincipalIMC(),
    );
  }
}

class TelaPrincipalIMC extends StatefulWidget {
  @override
  _TelaPrincipalIMCState createState() => _TelaPrincipalIMCState();
}

class _TelaPrincipalIMCState extends State<TelaPrincipalIMC> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  double? _imc;
  String _classificacao = '';
  Color _corResultado = Colors.grey;

  void _calcularIMC() {
    final double? peso = double.tryParse(_pesoController.text);
    final double? altura = double.tryParse(_alturaController.text);

    if (peso != null && altura != null && altura > 0) {
      final double imcCalculado = peso / (altura * altura);
      String classificacao;
      Color cor;

      if (imcCalculado < 18.5) {
        classificacao = "Abaixo do peso";
        cor = Colors.blueAccent;
      } else if (imcCalculado < 24.9) {
        classificacao = "Peso ideal";
        cor = Colors.green;
      } else if (imcCalculado < 29.9) {
        classificacao = "Sobrepeso";
        cor = Colors.orange;
      } else if (imcCalculado < 34.9) {
        classificacao = "Obesidade grau I";
        cor = Colors.deepOrange;
      } else if (imcCalculado < 39.9) {
        classificacao = "Obesidade grau II";
        cor = Colors.red;
      } else {
        classificacao = "Obesidade grau III";
        cor = Colors.red.shade900;
      }

      setState(() {
        _imc = imcCalculado;
        _classificacao = classificacao;
        _corResultado = cor;
      });
    }
  }

  void _limparCampos() {
    _pesoController.clear();
    _alturaController.clear();
    setState(() {
      _imc = null;
      _classificacao = '';
      _corResultado = Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calcularIMC,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: Text('Calcular'),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _limparCampos,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: Icon(Icons.clear),
                ),
              ],
            ),
            SizedBox(height: 30),
            if (_imc != null)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _corResultado.withOpacity(0.2),
                  border: Border.all(color: _corResultado, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'IMC: ${_imc!.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _classificacao,
                      style: TextStyle(fontSize: 20, color: _corResultado),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
