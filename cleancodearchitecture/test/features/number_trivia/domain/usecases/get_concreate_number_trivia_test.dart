

import 'package:cleancodearchitecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleancodearchitecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:cleancodearchitecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {
  MockNumberTriviaRepository();
}

void main () {

  GetConcreteNumberTrivia? usecase;
  MockNumberTriviaRepository? mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository as NumberTriviaRepository);
  });
  
  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: tNumber, text: 'test');

  test(
      'should get trivia for the number from repository',
          () async {
        when(mockNumberTriviaRepository?.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => Right(tNumberTrivia));

        final result = await usecase?.call(Params(number: tNumber));
        expect(result, Right(tNumberTrivia));
        verify(mockNumberTriviaRepository?.getConcreteNumberTrivia(tNumber));
        verifyNoMoreInteractions(mockNumberTriviaRepository);

  });

}




