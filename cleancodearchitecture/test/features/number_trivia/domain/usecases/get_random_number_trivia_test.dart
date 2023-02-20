

import 'package:cleancodearchitecture/core/usecases/usecase.dart';
import 'package:cleancodearchitecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleancodearchitecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:cleancodearchitecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {
  MockNumberTriviaRepository();
}

void main () {

  GetRandomNumberTrivia? usecase;
  MockNumberTriviaRepository? mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository as NumberTriviaRepository);
  });

  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
      'should get trivia from repository',
          () async {
        when(mockNumberTriviaRepository?.getRandomNumberTrivia()).thenAnswer((_) async => Right(tNumberTrivia));

        final result = await usecase?.call(NoParams());
        expect(result, Right(tNumberTrivia));
        verify(mockNumberTriviaRepository?.getRandomNumberTrivia());
        verifyNoMoreInteractions(mockNumberTriviaRepository);

      });

}
