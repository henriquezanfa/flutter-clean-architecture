import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../entities/number_trivia.dart';
import '../repositories/trivia_repository.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> call({
    @required int number,
  }) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}
