import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/util/input_converter.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInteger', () {
    test(
        'should return an integer when the string represents an unsigned integer',
        () async {
      // arrange
      final str = '123';

      // act
      final result = inputConverter.stringToUnsignedInteger(str);

      // asserts
      expect(result, Right(123));
    });
    test('should return a failure when string is not an integer', () async {
      // arrange
      final str = 'abc';

      // act
      final result = inputConverter.stringToUnsignedInteger(str);

      // asserts
      expect(result, Left(InvalidInputFailure()));
    });
    test('should return a failure when string is a negative integer', () async {
      // arrange
      final str = '-123';

      // act
      final result = inputConverter.stringToUnsignedInteger(str);

      // asserts
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
