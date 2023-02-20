import 'package:cleancodearchitecture/core/errors/exceptions.dart';
import 'package:cleancodearchitecture/core/errors/failure.dart';
import 'package:cleancodearchitecture/core/platform/network_info.dart';
import 'package:cleancodearchitecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:cleancodearchitecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:cleancodearchitecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:cleancodearchitecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleancodearchitecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  late final NumberTriviaRemoteDatSource remoteDataSource;
  late final NumberTriviaLocalDataSource localDataSource;
  late final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      Future<Either<Failure, NumberTrivia>> Function() getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cachedNumberTrivia(remoteTrivia as NumberTriviaModel);
        return Right(remoteTrivia as NumberTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getlastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
