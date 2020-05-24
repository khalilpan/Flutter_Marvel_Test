// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:marvel/features/heroes_list/heroes_list.dart';
import 'package:marvel/features/onboarding/onboarding.dart';

void main() {
  testWidgets(
      'Navigate to Onboarding second page and land back on the first page',
      (WidgetTester tester) async {
    var onboardingPage = OnboardingPage();

    //testing first page of onBoarding
    await tester.pumpWidget(CupertinoApp(home: onboardingPage));
    expect(find.text("Marvel Heroes"), findsOneWidget);

    //variable for onboarding page
    var element = find.byKey(Key("onboarding_page_view"));

    //drag onBoarding page to left using the variable
    await tester.drag(element, Offset(-500, 0));
    // Build the widget until the dismiss animation ends.
    await tester.pumpAndSettle();

    //testing second page of onboarding page
    expect(find.text("All Heroes"), findsOneWidget);
    expect(find.text("Marvel Heroes"), findsNothing);
    // drag onBoarding page to left using the variable
    await tester.drag(element, Offset(-500, 0));
    // Build the widget until the dismiss animation ends.
    await tester.pumpAndSettle();

    //testing third page of onboarding page
    expect(find.text("Detailed information"), findsOneWidget);
    expect(find.text("All Heroes"), findsNothing);
    expect(find.text("Marvel Heroes"), findsNothing);

    //drag onBoarding page to left using the variable
    await tester.drag(element, Offset(-500, 0));
    // Build the widget until the dismiss animation ends.
    await tester.pumpAndSettle();

    //testing the last page of oboarding and the BUTTON
    expect(find.byKey(Key('buttonOnboarding')), findsOneWidget);
    expect(find.text("Detailed information"), findsNothing);
    // Define the test key.
    // final buttonKey = Key('button_onboarding');
    // Build a MaterialApp with the testKey.
    // await tester.pumpWidget(MaterialApp(key: buttonKey, home: Container()));

    // expect(find.text("All Heroes"), findsOneWidget);
    //     expect(find.text("Detailed information"), findsOneWidget);

    //click on button in the last page of onboarding
    await tester.tap(find.byKey(Key('buttonOnboarding')));
  });

  // testWidgets('testing_page_heroes_list', (WidgetTester tester) async {
    //var heroesListPage = HeroesListPage();

    // Build the widget.
    // await tester.pumpWidget(new HeroesListPage());
    //await tester.pumpWidget(CupertinoApp(home: heroesListPage));
    //await tester.pumpAndSettle();
    // expect(find.text("HEROES MARVEL"), findsOneWidget);

    //expect(find.byKey(Key('title_marvel_heroes')), findsNothing);
    // Define the test key.
    // final titleKey = Key('title_marvel_heroes');
    // Build a MaterialApp with the testKey.
    // await tester.pumpWidget(MaterialApp(key: titleKey, home: Container()));
    // Expect to find the item on screen.
    // expect(find.byKey(Key("title_marvel_heroes")), findsOneWidget);
    // expect(find.byKey(Key('title_marvel_heroes')), findsOneWidget);
    // final listViewKey = Key('listview_child');
    // await tester.pumpWidget(MaterialApp(key: listViewKey, home: Container()));
    // expect(find.byKey(listViewKey), findsOneWidget);
  // });
}
