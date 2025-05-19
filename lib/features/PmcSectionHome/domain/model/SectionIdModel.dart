class SectionIdModel {
  int? success;
  bool? error;
  List<SectionIdData>? data;

  SectionIdModel({this.success, this.error, this.data});

  SectionIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? "";
    error = json['error'] ?? "";
    if (json['data'] != null) {
      data = <SectionIdData>[];
      json['data'].forEach((v) {
        data!.add(new SectionIdData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionIdData {
  String? sectionId;
  String? sectionName;

  SectionIdData({this.sectionId, this.sectionName});

  SectionIdData.fromJson(Map<String, dynamic> json) {
    sectionId = json['section_id'] ?? "";
    sectionName = json['section_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section_id'] = this.sectionId;
    data['section_name'] = this.sectionName;
    return data;
  }
}
