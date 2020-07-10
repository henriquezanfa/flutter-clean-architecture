import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int numeber);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
