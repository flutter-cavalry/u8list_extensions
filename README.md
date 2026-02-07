# u8list_extensions

[![pub package](https://img.shields.io/pub/v/u8list_extensions.svg)](https://pub.dev/packages/u8list_extensions)

Extensions for Uint8List.

## Usage

```dart
final data = Uint8List.fromList(List.generate(20, (index) => index + 1));

// Example of subView
final sublist1 = data.subView(1, 5);
print(sublist1); // Output: [2, 3, 4, 5]

// Example of subViewWithLength
final sublist2 = data.subViewWithLength(15, 3);
print(sublist2); // Output: [16, 17, 18]

// Example of toHexString
final hexString = data.subView(10).toHexString(separator: ' ');
print(hexString); // Output: "0b 0c 0d 0e 0f 10 11 12 13 14"

// Example of asByteData
final byteData = data.asByteData(5, 6);
print(byteData.getUint8(0)); // Output: 6

// Example of asByteDataWithLength
final byteDataWithLength = data.asByteDataWithLength(5, 1);
print(byteDataWithLength.getUint8(0)); // Output: 6

// Example of toHexPreview
final hexPreview = data.toHexPreview(maxLength: 10);
print(hexPreview); // Output: "01 02 03 04 05 ... 10 11 12 13 14"
```
