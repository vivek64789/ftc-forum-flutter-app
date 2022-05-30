import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ftc_forum/widgets/rounded_button.dart';
import 'package:integration_test/integration_test.dart';

import 'package:ftc_forum/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login Test', (WidgetTester tester) async {
    // setup
    app.main();
    await tester.pumpAndSettle();

    final Finder alreadyHaveAccountButton =
        find.byKey(const Key('registerScreen'));
    await tester.tap(alreadyHaveAccountButton);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 1000));
    final Finder registerName = find.byKey(const Key('registerName'));
    final Finder registerEmail = find.byKey(const Key('registerEmail'));
    final Finder registerPassword = find.byKey(const Key('registerPassword'));
    final Finder registerPhone = find.byKey(const Key('registerPhone'));
    final Finder registerDob = find.byKey(const Key('registerDob'));
    final Finder signUpButton = find.byKey(const Key('signUpButton'));

    // login
    final Finder loginEmail = find.byKey(const Key('loginEmail'));
    final Finder loginPassword = find.byKey(const Key('loginPassword'));
    final Finder loginButton = find.text('LOGIN');
    final Finder button = find.byType(ElevatedButton).first;

    await tester.enterText(loginEmail, 'admin@gmail.com');
    await Future.delayed(const Duration(milliseconds: 1000));

    await tester.enterText(loginPassword, 'Test@12345');
    await Future.delayed(const Duration(milliseconds: 1000));
    await tester.pump(const Duration(milliseconds: 1000));
    await tester.tap(loginButton);
    // test
    expect(button, findsOneWidget);
    expect(loginEmail, findsOneWidget);
    expect(loginPassword, findsOneWidget);
    expect(loginButton, findsOneWidget);
  });
}
