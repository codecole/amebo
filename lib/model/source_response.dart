import 'sources.dart';

class SourceResponse {
  List<SourceModel> sources;
  String error;

  SourceResponse({this.sources, this.error});

  SourceResponse.fromJson(dynamic json) {
    if (json["sources"] != null) {
      sources = [];
      json["sources"].forEach((v) {
        sources.add(SourceModel.fromJson(v));
      });
    } else {
      error = "";
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (sources != null) {
      map["sources"] = sources.map((v) => v.toJson()).toList();
    }
    return map;
  }

  SourceResponse.withError(String errorValue)
      : sources = List(),
        error = errorValue;
}
