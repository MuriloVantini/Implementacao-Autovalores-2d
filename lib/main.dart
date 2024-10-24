import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var primaryColor = const Color.fromARGB(255, 209, 223, 22);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          focusColor: primaryColor,
          focusedErrorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: Colors.red)),
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: Colors.red)),
          focusedBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: primaryColor)),
        ),
      ),
      home: const MyHomePage(title: 'Autovalores 2D'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? validateEmptyValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Valor não pode ser vazio';
    }
    try {
      double.parse(value);
    } catch (e) {
      return 'Valor inválido';
    }
    return null;
  }

  List<double?> calcularAutovalores(double a, double b, double c) {
    double delta = b * b - 4 * a * c;

    // Verificando se Delta é negativo
    if (delta < 0) {
      return [null, null]; // Autovalores complexos
    }

    // Calculando os autovalores usando Bhaskara
    double lambda1 = (-b + sqrt(delta)) / (2 * a);
    double lambda2 = (-b - sqrt(delta)) / (2 * a);

    return [lambda1, lambda2];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String result = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController a1 = TextEditingController();
  TextEditingController b1 = TextEditingController();
  TextEditingController a2 = TextEditingController();
  TextEditingController b2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: a1,
                    decoration: const InputDecoration(labelText: 'a1'),
                    validator: (value) {
                      return validateEmptyValue(value);
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: b1,
                    decoration: const InputDecoration(labelText: 'b1'),
                    validator: (value) {
                      return validateEmptyValue(value);
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: a2,
                    decoration: const InputDecoration(labelText: 'a2'),
                    validator: (value) {
                      return validateEmptyValue(value);
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: b2,
                    decoration: const InputDecoration(labelText: 'b2'),
                    validator: (value) {
                      return validateEmptyValue(value);
                    },
                  ),
                  const SizedBox(height: 15),
                  Text(result, style: const TextStyle(color: Colors.black, fontSize: 22))
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            try {
              double a1 = double.parse(this.a1.text);
              double b1 = double.parse(this.b1.text);
              double a2 = double.parse(this.a2.text);
              double b2 = double.parse(this.b2.text);

              double a = 1; 
              double b = -(a1 + b2); 
              double c = (a1 * b2 - a2 * b1); 
              List<double?> autovalores = calcularAutovalores(a, b, c);
              if (autovalores[0] != null && autovalores[1] != null) {
                setState(() {
                  result = 'Autovalores:\nλ1 = ${autovalores[0]}\nλ2 = ${autovalores[1]}';
                });
              } else {
                setState(() {
                  result = 'Autovalores complexos';
                });
              }
            } catch (e) {
              setState(() {
                result = 'Erro ao converter valores para double. Por favor, verifique se os valores estão preenchidos corretamente.';
                formKey.currentState!.validate();
              });
            }
          }
        },
        tooltip: 'Calcular',
        child: const Icon(Icons.check),
      ), 
    );
  }
}
