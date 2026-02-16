class SectionIdModel {
  int? success;
  bool? error;
  dynamic data;

  SectionIdModel({this.success, this.error, this.data});

  SectionIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? "";
    error = json['error'] ?? "";
    if (json['data'] is List) {
      data = (json['data'] as List).map((v) => SectionIdData.fromJson(v)).toList();
    } else if (json['data'] is String) {
      data = json['data'] ?? "";
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
