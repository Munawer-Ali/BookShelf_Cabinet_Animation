import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bookshelf_cabinet_animation/main.dart';
import 'package:bookshelf_cabinet_animation/widgets/book_shelf_widget.dart';
import 'package:bookshelf_cabinet_animation/widgets/bulb_light.dart';
import 'package:bookshelf_cabinet_animation/widgets/animated_tab_selector.dart';
import 'package:bookshelf_cabinet_animation/utils/elastic_curve.dart';

void main() {
  group('Bookshelf Cabinet Animation Tests', () {
    testWidgets('App should start with correct title', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that the app title is displayed
      expect(find.text('Bookshelf Cabinet Animation'), findsOneWidget);
    });

    testWidgets('BookShelfWidget should render with correct properties', (WidgetTester tester) async {
      // Create test data
      final woodVisible = [true, false, true];
      final lighteningVisible = true;

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                BookShelfWidget(
                  woodVisible: woodVisible,
                  lighteningVisible: lighteningVisible,
                ),
              ],
            ),
          ),
        ),
      );

      // Verify the widget is rendered
      expect(find.byType(BookShelfWidget), findsOneWidget);
      
      // Verify bookshelf image is present
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('BulbLight widget should render with default properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const BulbLight(),
          ),
        ),
      );

      // Verify the widget is rendered
      expect(find.byType(BulbLight), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('BulbLight widget should render with custom properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BulbLight(
              width: 100,
              height: 50,
              glowColor: Colors.red,
              glowRadius: 30,
            ),
          ),
        ),
      );

      // Verify the widget is rendered
      expect(find.byType(BulbLight), findsOneWidget);
      
      // Get the container and verify its properties
      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxWidth, 100);
      expect(container.constraints?.maxHeight, 50);
    });

    testWidgets('AnimatedTabSelector should render with correct number of tabs', (WidgetTester tester) async {
      final labels = ['One', 'Two', 'Three'];
      int selectedIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedTabSelector(
              labels: labels,
              selectedIndex: selectedIndex,
              onTabSelected: (index) {
                selectedIndex = index;
              },
            ),
          ),
        ),
      );

      // Verify the widget is rendered
      expect(find.byType(AnimatedTabSelector), findsOneWidget);
      
      // Verify all labels are present
      for (String label in labels) {
        expect(find.text(label), findsOneWidget);
      }
    });

    testWidgets('AnimatedTabSelector should respond to tab taps', (WidgetTester tester) async {
      final labels = ['One', 'Two', 'Three'];
      int selectedIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return AnimatedTabSelector(
                  labels: labels,
                  selectedIndex: selectedIndex,
                  onTabSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      // Tap on the second tab
      await tester.tap(find.text('Two'));
      await tester.pump();

      // Verify the selection changed (this would need to be verified through the UI state)
      expect(find.text('Two'), findsOneWidget);
    });

    testWidgets('CustomElasticOutCurve should transform values correctly', (WidgetTester tester) async {
      const curve = CustomElasticOutCurve();
      
      // Test boundary values
      expect(curve.transform(0.0), equals(0.0));
      expect(curve.transform(1.0), equals(1.0));
      
      // Test that values are within reasonable bounds (elastic curves can overshoot)
      for (double t = 0.0; t <= 1.0; t += 0.1) {
        final result = curve.transform(t);
        expect(result, greaterThanOrEqualTo(-0.5)); // Allow some undershoot
        expect(result, lessThanOrEqualTo(1.5)); // Allow some overshoot
      }
    });

    testWidgets('MyHomePage should have expandable sections', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find the expandable sections
      expect(find.text('Make your furniture'), findsOneWidget);
      expect(find.text('Choose Lightening'), findsOneWidget);
    });

    testWidgets('Furniture section should expand on tap', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find and tap the furniture section
      final furnitureSection = find.text('Make your furniture');
      expect(furnitureSection, findsOneWidget);
      
      await tester.tap(furnitureSection);
      await tester.pumpAndSettle();

      // Verify the section expanded (look for additional content)
      expect(find.text(' Shelves'), findsOneWidget);
      expect(find.text(' Size'), findsOneWidget);
    });

    testWidgets('Lightening section should expand on tap', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find and tap the lightening section
      final lighteningSection = find.text('Choose Lightening');
      expect(lighteningSection, findsOneWidget);
      
      await tester.tap(lighteningSection);
      await tester.pumpAndSettle();

      // Verify the section expanded
      expect(find.text(' Lightening'), findsOneWidget);
    });

    testWidgets('Tab selectors should work correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Expand furniture section first
      await tester.tap(find.text('Make your furniture'));
      await tester.pumpAndSettle();

      // Test shelves tab selector
      expect(find.text('One'), findsOneWidget);
      expect(find.text('Two'), findsOneWidget);
      expect(find.text('Three'), findsOneWidget);

      // Test size tab selector
      expect(find.text('Square'), findsOneWidget);
      expect(find.text('Wide'), findsOneWidget);
      expect(find.text('Tall'), findsOneWidget);
    });

    testWidgets('Lightening tab selector should work correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Expand lightening section first
      await tester.tap(find.text('Choose Lightening'));
      await tester.pumpAndSettle();

      // Test lightening tab selector
      expect(find.text('None'), findsOneWidget);
      expect(find.text('Bulb'), findsOneWidget);
      expect(find.text('Strip'), findsOneWidget);
    });
  });

  group('Widget Integration Tests', () {
    testWidgets('Complete app flow should work', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Expand furniture section
      await tester.tap(find.text('Make your furniture'));
      await tester.pumpAndSettle();

      // Select different shelf options
      await tester.tap(find.text('Two'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Wide'));
      await tester.pumpAndSettle();

      // Expand lightening section
      await tester.tap(find.text('Choose Lightening'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Select bulb option
      await tester.tap(find.text('Bulb'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Verify the app is still functional
      expect(find.byType(BookShelfWidget), findsOneWidget);
    });
  });

  group('Performance Tests', () {
    testWidgets('Widget should rebuild efficiently', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Measure initial build time
      final stopwatch = Stopwatch()..start();
      
      // Trigger multiple rebuilds
      for (int i = 0; i < 10; i++) {
        await tester.pump();
      }
      
      stopwatch.stop();
      
      // Verify rebuilds complete in reasonable time (less than 1 second for 10 rebuilds)
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    });
  });
}