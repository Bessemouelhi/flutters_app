import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ma_rando/services/network_helper.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart'
    as http; // Remplacez par le bon chemin vers NetworkHelper

class MockClient extends Mock implements http.Client {}

void main() {
  final testUri = Uri.parse('http://test.com');
  final NetworkHelper networkHelper = NetworkHelper(testUri);
  final MockClient mockClient = MockClient();

  test('Retourne les données lorsque la requête HTTP réussit', () async {
    final Map<String, dynamic> fakeData = {'key': 'value'};
    when(mockClient.get(testUri))
        .thenAnswer((_) async => http.Response(jsonEncode(fakeData), 200));

    final result = await networkHelper.getDataTest(client: mockClient);

    expect(result, fakeData);
  });

  test('Lance une exception lorsque le statut HTTP est différent de 200',
      () async {
    when(mockClient.get(testUri))
        .thenAnswer((_) async => http.Response('Not Found', 404));

    final result = networkHelper.getDataTest(client: mockClient);

    expect(() => result, prints('404'));
  });
}
