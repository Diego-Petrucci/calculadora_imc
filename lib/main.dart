import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculadora IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double imc = 0.0;
  double altura = 0.0;
  double peso = 0.0;

  void calculateIMC(double altura, double peso) {
    setState(() {
      imc = peso / (altura * altura);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 36,
              ),
              Container(
                height: 200,
                child: Image.asset('assets/images/balanca.png'),
              ),
              SizedBox(height: 36),
              const Text(
                'Calcule seu IMC',
                style: TextStyle(fontSize: 52),
              ),
              SizedBox(height: 36),
              SizedBox(
                width: 900,
                child: TextField(
                  inputFormatters: [TextInputMask(mask: '9.99')],
                  onChanged: (text) {
                    altura = double.parse(text);
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Digite sua altura em M: ',
                    hintStyle: const TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide: const BorderSide(
                        width: 200,
                        style: BorderStyle.solid,
                      ),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.all(2.0),
                  ),
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                width: 900,
                child: TextField(
                  inputFormatters: [
                    TextInputMask(mask: ['99.99', '999.99'])
                  ],
                  onChanged: (text) {
                    peso = double.parse(text);
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Digite seu peso em KG: ',
                    hintStyle: const TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide: const BorderSide(
                        width: 1000,
                        style: BorderStyle.solid,
                      ),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
              ),
              SizedBox(
                height: 36,
              ),
              SizedBox(
                width: 400,
                height: 70,
                child: ElevatedButton(
                    child: const Text('Calcular'),
                    onPressed: () {
                      _abrirDialog(context);
                      calculateIMC(altura, peso);
                    }),
              ),
            ]),
      ),
    );
  }

  Widget? _abrirDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
    var IMCFormatado = imc.toStringAsFixed(2);
          return Container(
            child: AlertDialog(
                title: const Text(
                  'Seu IMC é:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 54),
                ),
                content: Column(children: <Widget>[
                  SizedBox(height: 24),
                  Text(
                    '$IMCFormatado',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 102),
                  ),
                  SizedBox(height: 72),
                  Image.asset('assets/images/tabelaimc2.png'),
                  SizedBox(height: 72),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.blue,
                    child: Text("OK"),
                  )
                ])),
          );
        });
    return null;
  }
}
