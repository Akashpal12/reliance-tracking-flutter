import 'dart:convert';

class jsonExtract {
  jsonExtract._();

  static dynamic extractJsonObjectFromXml(String xmlResponse) {
    try {
      int startIndex = xmlResponse.indexOf('{');
      int endIndex = xmlResponse.lastIndexOf('}') + 1;

      if (startIndex != -1 && endIndex != -1) {
        final jsonString = xmlResponse.substring(startIndex, endIndex);
        return json.decode(jsonString);
      }
    } catch (e) {
      print(e);
    }

    return null; // Return null when extraction fails
  }

  static dynamic extractJsonArrayFromXml(String xmlResponse) {
    try {
      int startIndex = xmlResponse.indexOf('[');
      int endIndex = xmlResponse.lastIndexOf(']') + 1;
      if (startIndex != -1 && endIndex != -1) {
        final jsonString = xmlResponse.substring(startIndex, endIndex);
        return json.decode(jsonString);
      }
    } catch (e) {
      print(e);
    }

    return null; // Return empty string when extraction fails
  }
}
