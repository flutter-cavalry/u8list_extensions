import 'dart:typed_data';

extension Uint8ListExt on Uint8List {
  /// Returns whether this list starts with [prefix].
  bool startsWith(List<int> prefix, {int offset = 0}) {
    if (offset < 0 || offset > length || prefix.length > length - offset) {
      return false;
    }
    for (var i = 0; i < prefix.length; i++) {
      if (this[offset + i] != prefix[i]) {
        return false;
      }
    }
    return true;
  }

  /// Returns whether this list ends with [suffix].
  bool endsWith(List<int> suffix) {
    if (suffix.length > length) {
      return false;
    }
    final offset = length - suffix.length;
    for (var i = 0; i < suffix.length; i++) {
      if (this[offset + i] != suffix[i]) {
        return false;
      }
    }
    return true;
  }

  /// Returns whether this list contains the same bytes as [other].
  bool equalsTo(Uint8List other) {
    if (length != other.length) {
      return false;
    }
    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }

  /// Creates a sublist view of this [Uint8List] from [start] to [end] or with the specified [length].
  Uint8List subView(int start, {int? end, int? length}) {
    if (end != null && length != null) {
      throw ArgumentError('Cannot specify both end and length.');
    }

    if (length != null) {
      end = start + length;
    }
    return Uint8List.sublistView(this, start, end);
  }

  /// Creates a sublist view of this [Uint8List] from [start] to [end] or with the specified [length].
  /// Returns null if the specified range is out of bounds.
  Uint8List? subViewOrNull(int start, {int? end, int? length}) {
    if (end != null && length != null) {
      throw ArgumentError('Cannot specify both end and length.');
    }

    if (length != null) {
      end = start + length;
    }
    if (start < 0 ||
        start > this.length ||
        (end != null && (end < start || end > this.length))) {
      return null;
    }
    return Uint8List.sublistView(this, start, end);
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

  /// Creates a [ByteData] view of this [Uint8List] from [start] to [end] or with the specified [length].
  ByteData asByteData({int start = 0, int? end, int? length}) {
    if (end != null && length != null) {
      throw ArgumentError('Cannot specify both end and length.');
    }

    if (length != null) {
      end = start + length;
    }
    return ByteData.sublistView(this, start, end);
  }

  /// Creates a [ByteData] view of this [Uint8List] from [start] to [end] or with the specified [length].
  /// Returns null if the specified range is out of bounds.
  ByteData? asByteDataOrNull({int start = 0, int? end, int? length}) {
    if (end != null && length != null) {
      throw ArgumentError('Cannot specify both end and length.');
    }

    if (length != null) {
      end = start + length;
    }
    if (start < 0 ||
        start > this.length ||
        (end != null && (end < start || end > this.length))) {
      return null;
    }
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

  String toHexPreview({int maxLength = 20, noHead = false, separator = ' '}) {
    return toHexPreviewCore(
      maxLength: maxLength,
      noHead: noHead,
      separator: separator,
    ).$1;
  }

  (String, bool) toHexPreviewCore({
    int maxLength = 20,
    noHead = false,
    separator = ' ',
  }) {
    var head = noHead ? '' : 'Bytes($length)';
    if (length == 0) {
      return (head, false);
    }
    final String content;
    final bool truncated;
    if (length <= maxLength) {
      content = toHexString(separator: separator);
      truncated = false;
    } else {
      content =
          '${subView(0, end: maxLength ~/ 2).toHexString(separator: separator)} ... ${subView(length - maxLength ~/ 2).toHexString(separator: separator)}';
      truncated = true;
    }
    if (noHead) {
      return (content, truncated);
    }
    return ('$head[$content]', truncated);
  }
}
