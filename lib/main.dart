import 'package:calc_upeu/comp/CalcButton.dart';
import 'package:calc_upeu/comp/CustomAppBar.dart';
import 'package:calc_upeu/theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'dart:math'; // Importa para usar funciones matemáticas

void main() {
  runApp(const CalcApp());
}

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  CalcAppState createState() => CalcAppState();
}

class CalcAppState extends State<CalcApp> {
  String valorAnt = '';
  String operador = '';

  TextEditingController _controller = TextEditingController();

  void numClick(String text) {
    setState(() => _controller.text += text);
  }

  void clear(String text) {
    setState(() {
      _controller.text = '';
    });
  }

  void opeClick(String text) {
    setState(() {
      valorAnt = _controller.text;
      operador = text;
      _controller.text = '';
    });
  }

  void accion() {
    setState(() {
      // jOSELIN MAYELY CONDORI TINTAYA
    });
  }

  void resultOperacion(String text) {
    setState(() {
      double currentValue = double.parse(_controller.text);

      switch (operador) {
        case "/":
          _controller.text = (int.parse(valorAnt) / currentValue).toString();
          break;
        case "*":
          _controller.text = (int.parse(valorAnt) * currentValue).toString();
          break;
        case "+":
          _controller.text = (int.parse(valorAnt) + currentValue).toString();
          break;
        case "-":
          _controller.text = (int.parse(valorAnt) - currentValue).toString();
          break;
        case "%":
          _controller.text = (int.parse(valorAnt) % currentValue).toString();
          break;
        case "√": // Raíz cuadrada
          _controller.text = sqrt(currentValue).toString();
          break;
        case "π": // Calcular Pi
          _controller.text = pi.toString();
          break;
        case "^2": // Potencia al cuadrado
          _controller.text = (currentValue * currentValue).toString();
          break;
        case "^": // Potencia a cualquier número
          _controller.text = (pow(int.parse(valorAnt), currentValue)).toString();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List> labelList = [
      ["AC", "C", "%", "/"],
      ["7", "8", "9", "*"],
      ["4", "5", "6", "-"],
      ["1", "2", "3", "+"],
      ["√", "π", "^2", "^"], // Nuevos botones aquí
      [".", "0", "00", "="]
    ];

    List<List> funx = [
      [clear, clear, opeClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [resultOperacion, resultOperacion, resultOperacion, opeClick], // Nuevos callbacks aquí
      [numClick, numClick, numClick, resultOperacion]
    ];

    AppTheme.colorX = Colors.blue;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeData,
      home: Scaffold(
        appBar: CustomAppBar(accionx: accion as Function),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: _controller,
                  readOnly: true, // Para que no se pueda editar directamente
                ),
              ),
              SizedBox(height: 20),
              ...List.generate(labelList.length, (index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...List.generate(
                    labelList[index].length,
                        (indexx) => CalcButton(
                      text: labelList[index][indexx],
                      callback: funx[index][indexx] as Function,
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
