# u8list_extensions

[![pub package](https://img.shields.io/pub/v/u8list_extensions.svg)](https://pub.dev/packages/u8list_extensions)

Extensions for Uint8List.

## Usage

```dart
final data = Uint8List.fromList(List.generate(20, (index) => index + 1));

// startsWith, endsWith, and equalsTo
print(data.startsWith([1, 2, 3])); // Output: true
print(data.endsWith([18, 19, 20])); // Output: true
print(data.equalsTo(Uint8List.fromList(List.generate(20, (i) => i + 1)))); // Output: true

// subView
final sublist1 = data.subView(1, end: 5);
print(sublist1); // Output: [2, 3, 4, 5]

// subView with length
final sublist2 = data.subView(15, length: 3);
print(sublist2); // Output: [16, 17, 18]

// Use subViewOrNull to avoid exceptions when the range is out of bounds
final sublist3 = data.subViewOrNull(18, length: 5);
print(sublist3); // Output: null

// toHexString
final hexString = data.subView(10).toHexString(separator: ' ');
print(hexString); // Output: "0b 0c 0d 0e 0f 10 11 12 13 14"

// asByteData
// Both `start` and `end` are optional.
final byteData = data.asByteData(start: 5, end: 6);
print(byteData.getUint8(0)); // Output: 6

// asByteDataWithLength
final byteDataWithLength = data.asByteDataWithLength(5, 1);
print(byteDataWithLength.getUint8(0)); // Output: 6

// toHexPreview
final hexPreview = data.toHexPreview(maxLength: 10);
print(hexPreview); // Output: "01 02 03 04 05 ... 10 11 12 13 14"
```
