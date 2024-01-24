import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('Tapping back button should pop screen', (tester) async {
    await tester.pumpWidget(_makeTestableWidget(AboutPage()));

    // tap back button
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(find.byType(AboutPage), findsNothing);
  });

  testWidgets('Page should display image and description', (tester) async {
    await tester.pumpWidget(_makeTestableWidget(AboutPage()));

    expect(find.byType(Image), findsOneWidget);

    expect(find.byType(Text), findsOneWidget);
    expect(find.textContaining('Ditonton merupakan'), findsOneWidget);
  });
}
