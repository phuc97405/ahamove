import 'package:flutter_test/flutter_test.dart';
import 'package:ahamove/core/base/functions/base_functions.dart';

void main() {
  test('formatNumberToK should format number correctly', () {
    // Arrange
    final baseFunctions = BaseFunctions.instance;

    // Act
    final result1 = baseFunctions.formatNumberToK(500);
    final result2 = baseFunctions.formatNumberToK(1500);
    final result3 = baseFunctions.formatNumberToK(10000);

    // Assert
    expect(result1, '500');
    expect(result2, '1.5k');
    expect(result3, '10.0k');
  });
}
