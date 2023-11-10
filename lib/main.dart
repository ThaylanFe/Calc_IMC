import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String gender = 'Male'; // Padrão masculino

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alinhe os elementos com espaço entre eles
          children: [
            Text("Calculadora IMC"),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Leonardo Paschoa  RA: 1431432312005"),
                Text("Kauã Oliveira de Souza  RA: 1431432312014")
              ],
            )
          ],
        ),
        
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Altura (cm)'),
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Peso (kg)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                Text('Masculino'),
                Radio(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                Text('Feminino'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
              },
              child: Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
  // Obter valores de altura e peso do usuário
  double height = double.parse(heightController.text.replaceAll(',', '.')) / 100;
  double weight = double.parse(weightController.text.replaceAll(',', '.'));

  // Calcular o IMC
  double bmi = (weight / (height * height)) / 10000;

  // Determinar a categoria do IMC com base no gênero
  String category = '';
  if (gender == 'Male') {
    category = getBMICategoryForMen(bmi);
  } else if (gender == 'Female') {
    category = getBMICategoryForWomen(bmi);
  }

  // Exibir resultado
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Resultado do IMC'),
        content: Text('Seu IMC é: ${bmi.toStringAsFixed(2)}\nCategoria: $category'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}

String getBMICategoryForMen(double bmi) {
  if (bmi < 20.7) {
    return 'Abaixo do peso';
  } else if (bmi >= 20.7 && bmi < 26.4) {
    return 'Peso normal';
  } else if (bmi >= 26.4 && bmi < 27.8) {
    return 'Um pouco acima do peso';
  } else if (bmi >= 27.8 && bmi < 31.1) {
    return 'Acima do peso';
  } else {
    return 'Obeso';
  }
}

String getBMICategoryForWomen(double bmi) {
  if (bmi < 19.1) {
    return 'Abaixo do peso';
  } else if (bmi >= 19.1 && bmi < 25.8) {
    return 'Peso normal';
  } else if (bmi >= 25.8 && bmi < 27.3) {
    return 'um pouco acima do peso';
  } else if (bmi >= 27.3 && bmi < 32.3) {
    return 'Acima do peso';
  } else {
    return 'Obeso';
    }
  }
}