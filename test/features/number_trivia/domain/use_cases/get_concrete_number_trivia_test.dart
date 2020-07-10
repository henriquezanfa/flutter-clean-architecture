import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/repositories/trivia_repository.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia useCase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final number = 1;
  final numberTrivia = NumberTrivia(number: 1, text: 'test');
  test(
    'should get trivia for the number from repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(numberTrivia));

      // act
      final result = await useCase(number: number);

      // assert
      expect(result, Right(numberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(number));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
