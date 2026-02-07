import 'dart:typed_data';

extension Uint8ListExt on Uint8List {
  /// Creates a sublist view of this [Uint8List] from [start] to [end].
  Uint8List subView(int start, [int? end]) {
    return Uint8List.sublistView(this, start, end);
  }

  /// Creates a sublist view of this [Uint8List] from [start] with the specified [length].
  Uint8List subViewWithLength(int start, [int? length]) {
    return Uint8List.sublistView(
      this,
      start,
      length != null ? start + length : null,
    );
  }

  /// Converts the [Uint8List] to a hexadecimal string representation.
  String toHexString({String separator = ''}) {
    final StringBuffer buffer = StringBuffer();
    for (var i = 0; i < length; i++) {
      final byte = this[i];
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
      if (separator.isNotEmpty && i < length - 1) {
        buffer.write(separator);
      }
    }
    return buffer.toString();
  }

  /// Creates a [ByteData] view of this [Uint8List] from [start] to [end].
  ByteData asByteData([int start = 0, int? end]) {
    return ByteData.sublistView(this, start, end);
  }

  /// Creates a [ByteData] view of this [Uint8List] from [start] with the specified [length].
  ByteData asByteDataWithLength(int start, [int? length]) {
    return ByteData.sublistView(
      this,
      start,
      length != null ? start + length : null,
    );
  }

  String toHexPreview({int maxLength = 20}) {
    var head = 'Bytes($length)';
    if (length == 0) {
      return head;
    }
    final String content;
    if (length <= maxLength) {
      content = toHexString(separator: ' ');
    } else {
      content =
          '${subView(0, maxLength ~/ 2).toHexString(separator: ' ')} ... ${subView(length - maxLength ~/ 2).toHexString(separator: ' ')}';
    }
    return '$head[$content]';
  }
}
