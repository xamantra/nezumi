import 'package:flutter_test/flutter_test.dart';
import 'package:nezumi/main.dart';

void main() {
  testWidgets('root', (tester) async {
    tester.pumpWidget(momentum());
  });
}
