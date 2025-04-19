testWidgets('DraggableLoggerButton renders correctly', (tester) async {
  await tester.pumpWidget(MaterialApp(home: _DraggableLoggerButton()));
  expect(find.byIcon(Icons.api), findsOneWidget);
});
