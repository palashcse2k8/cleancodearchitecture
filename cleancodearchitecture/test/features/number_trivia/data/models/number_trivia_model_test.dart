import 'dart:convert';

import 'package:cleancodearchitecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:cleancodearchitecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  NumberTriviaModel tNumberTriviaModel =
      NumberTriviaModel(number: 1, text: 'test text');
  test('should get the model of NumberTrivia', () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () async {
    test('should return a valid JSON when the number is intger', () async {
      final Map <String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });
    test('should return a valid JSON when the number is double', () async {
      final Map <String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });
  });
}
