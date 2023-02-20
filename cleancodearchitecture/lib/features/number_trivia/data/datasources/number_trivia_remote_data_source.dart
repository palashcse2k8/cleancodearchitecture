
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteDatSource {
  Future <Either<Failure, NumberTrivia>> getConcreteNumberTrivia (int number);
  Future <Either<Failure, NumberTrivia>> getRandomNumberTrivia ();
}