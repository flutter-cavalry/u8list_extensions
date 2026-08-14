import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:u8list_extensions/u8list_extensions.dart';

final _data = Uint8List.fromList(List.generate(20, (index) => index + 1));

void main() {
  test('subView', () {
    expect(_data.subView(1, end: 5), Uint8List.fromList([2, 3, 4, 5]));
    expect(_data.subView(15), Uint8List.fromList([16, 17, 18, 19, 20]));
  });

  test('subView with length', () {
    expect(_data.subView(1, length: 4), Uint8List.fromList([2, 3, 4, 5]));
    expect(
      _data.subView(15, length: 5),
      Uint8List.fromList([16, 17, 18, 19, 20]),
    );
  });

  test('subViewOrNull', () {
    expect(_data.subViewOrNull(1, end: 5), Uint8List.fromList([2, 3, 4, 5]));
    expect(_data.subViewOrNull(1, length: 4), Uint8List.fromList([2, 3, 4, 5]));
    expect(_data.subViewOrNull(15), Uint8List.fromList([16, 17, 18, 19, 20]));
  });

  test('subViewOrNull returns null for invalid bounds', () {
    expect(_data.subViewOrNull(-1), isNull);
    expect(_data.subViewOrNull(15, length: 6), isNull);
    expect(_data.subViewOrNull(0, end: 21), isNull);
  });

  test('subViewOrNull rejects end and length together', () {
    expect(
      () => _data.subViewOrNull(1, end: 5, length: 4),
      throwsArgumentError,
    );
  });

  test('toHexString', () {
    expect(
      _data.subView(10).toHexString(separator: ' '),
      '0b 0c 0d 0e 0f 10 11 12 13 14',
    );
    expect(_data.subView(10).toHexString(), '0b0c0d0e0f1011121314');
  });

  test('asByteData', () {
    final byEnd = _data.asByteData(start: 1, end: 5);
    final byLength = _data.asByteData(start: 1, length: 4);
    final toEnd = _data.asByteData(start: 15);

    expect(byEnd.getUint8(0), 2);
    expect(byEnd.lengthInBytes, 4);
    expect(byLength.getUint8(0), 2);
    expect(byLength.lengthInBytes, 4);
    expect(toEnd.getUint8(0), 16);
    expect(toEnd.lengthInBytes, 5);
  });

  test('asByteData rejects end and length together', () {
    expect(
      () => _data.asByteData(start: 1, end: 5, length: 4),
      throwsArgumentError,
    );
  });

  test('asByteDataOrNull', () {
    final byEnd = _data.asByteDataOrNull(start: 1, end: 5);
    final byLength = _data.asByteDataOrNull(start: 1, length: 4);
    final toEnd = _data.asByteDataOrNull(start: 15);

    expect(byEnd?.getUint8(0), 2);
    expect(byEnd?.lengthInBytes, 4);
    expect(byLength?.getUint8(0), 2);
    expect(byLength?.lengthInBytes, 4);
    expect(toEnd?.getUint8(0), 16);
    expect(toEnd?.lengthInBytes, 5);
  });

  test('asByteDataOrNull returns null for invalid bounds', () {
    expect(_data.asByteDataOrNull(start: -1), isNull);
    expect(_data.asByteDataOrNull(start: 15, length: 6), isNull);
    expect(_data.asByteDataOrNull(start: 0, end: 21), isNull);
  });

  test('asByteDataOrNull rejects end and length together', () {
    expect(
      () => _data.asByteDataOrNull(start: 1, end: 5, length: 4),
      throwsArgumentError,
    );
  });

  test('asByteDataWithLength', () {
    expect(_data.asByteDataWithLength(1, 4).getUint8(0), 2);
    expect(_data.asByteDataWithLength(15).getUint8(0), 16);
  });

  test('toHexPreview', () {
    expect(
      _data.toHexPreview(maxLength: 10),
      'Bytes(20)[01 02 03 04 05 ... 10 11 12 13 14]',
    );
  });
}
