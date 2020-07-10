import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 400));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test(
      '''should perform a GET request on a URL with number being 
        the endpoint and with applicatio/jsop header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess();
        // act
        await dataSource.getConcreteNumberTrivia(tNumber);

        // assert
        verify(
          mockHttpClient.get(
            'http://numbersapi.com/$tNumber',
            headers: {'content-type': 'application/json'},
          ),
        );
      },
    );

    test('Should return NumberTriviaModel when response code is 200', () async {
      // arrange
      setUpMockHttpClientSuccess();

      // act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      // assert
      expect(result, tNumberTriviaModel);
    });

    test('Should throw ServerException when response code is not 200',
        () async {
      // arrange
      setUpMockHttpClientFailure();

      // act
      final call = dataSource.getConcreteNumberTrivia;

      // assert
      expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });
  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test(
      '''should perform a GET request on a URL with number being 
        the endpoint and with applicatio/jsop header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess();
        // act
        await dataSource.getRandomNumberTrivia();

        // assert
        verify(
          mockHttpClient.get(
            'http://numbersapi.com/random',
            headers: {'content-type': 'application/json'},
          ),
        );
      },
    );

    test('Should return NumberTriviaModel when response code is 200', () async {
      // arrange
      setUpMockHttpClientSuccess();

      // act
      final result = await dataSource.getRandomNumberTrivia();

      // assert
      expect(result, tNumberTriviaModel);
    });

    test('Should throw ServerException when response code is not 200',
        () async {
      // arrange
      setUpMockHttpClientFailure();

      // act
      final call = dataSource.getRandomNumberTrivia;

      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
