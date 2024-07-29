import 'dart:convert';

class DtmDirection {
  final int id;
  final String name;

  DtmDirection({
    required this.id,
    required this.name,
  });

  factory DtmDirection.fromJson(Map<String, dynamic> json) {
    return DtmDirection(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

List<DtmDirection> dtmDirectionsFromJson(String str) =>
    List<DtmDirection>.from(json.decode(str).map((x) => DtmDirection.fromJson(x)));

String dtmDirectionsToJson(List<DtmDirection> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));