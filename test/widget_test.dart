import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculadora_imc/main.dart';

void main() {
  testWidgets('Verifica se o título da AppBar está correto', (WidgetTester tester) async {
    // Constrói o app
    await tester.pumpWidget(AppCalculadoraIMC());

    // Verifica se o título "Calculadora de IMC" aparece na AppBar
    expect(find.text('Calculadora de IMC'), findsOneWidget);
  });

  testWidgets('Verifica se os campos de entrada estão na tela', (WidgetTester tester) async {
    await tester.pumpWidget(AppCalculadoraIMC());

    // Verifica se os campos de peso e altura aparecem
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Peso (kg)'), findsOneWidget);
    expect(find.text('Altura (m)'), findsOneWidget);
  });

  testWidgets('Verifica se o botão calcular está presente', (WidgetTester tester) async {
    await tester.pumpWidget(AppCalculadoraIMC());

    expect(find.text('Calcular'), findsOneWidget);
  });
}
