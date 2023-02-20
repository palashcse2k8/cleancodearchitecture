
import 'package:cleancodearchitecture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getlastNumberTrivia ();
  Future<void> cachedNumberTrivia (NumberTriviaModel numberTriviaModel);
}