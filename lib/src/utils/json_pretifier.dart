import 'dart:convert';

class JsonPrettifier {
  /// Returns a prettified (indented) version of the given JSON string.
  /// Falls back to the original string if it cannot be parsed.
  static String pretty(String rawJson) {
    try {
      final decoded = json.decode(rawJson);
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(decoded);
    } catch (e) {
      return rawJson; // Return original if not valid JSON
    }
  }
    static dynamic decodeJson(String input) {
    return jsonDecode(input); // Use this to get the actual Map or List
  }
}