import 'package:cleancodearchitecture/core/errors/failure.dart';
import 'package:cleancodearchitecture/core/usecases/usecase.dart';
import 'package:cleancodearchitecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

import '../repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  late final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
