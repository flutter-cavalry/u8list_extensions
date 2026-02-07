import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:u8list_extensions/u8list_extensions.dart';

final _data = Uint8List.fromList(List.generate(20, (index) => index + 1));

void main() {
  test('subView', () {
    expect(_data.subView(1, 5), Uint8List.fromList([2, 3, 4, 5]));
    expect(_data.subView(15), Uint8List.fromList([16, 17, 18, 19, 20]));
  });

  test('subViewWithLength', () {
    expect(_data.subViewWithLength(1, 4), Uint8List.fromList([2, 3, 4, 5]));
    expect(
      _data.subViewWithLength(15),
      Uint8List.fromList([16, 17, 18, 19, 20]),
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
    expect(_data.asByteData(1, 5).getUint8(0), 2);
    expect(_data.asByteData(15).getUint8(0), 16);
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
