import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_service_booking_app/main.dart';

void main() {
  testWidgets('Service Booking loads', (WidgetTester tester) async {
    await tester.pumpWidget(const ServiceBookingApp());
    expect(find.text('Service Booking'), findsWidgets);
  });
}
