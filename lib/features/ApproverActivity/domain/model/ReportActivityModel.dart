class ReportActivityModel {
  int? success;
  bool? error;
  dynamic data;

  ReportActivityModel({this.success, this.error, this.data});

  ReportActivityModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? "";
    error = json['error'] ?? "";
    if (json['data'] != null) {
      if(json['data'] is String){
        data = json['data'] ?? "";
      } else{
        data = <ReportActivityData>[];
        json['data'].forEach((v) {
          data!.add(new ReportActivityData.fromJson(v));
        });
      }
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

class ReportActivityData {
  String? id;
  String? spreadId;
  String? sectionId;
  String? alignmentSheetId;
  String? chainageFrom;
  String? chainageTo;
  String? totalLength;
  String? reportNo;
  String? attachFile;
  String? weather;
  String? tpIpChainage;
  dynamic chainage;
  String? tpIpNos;
  String? tpRemarks;
  String? bearingAngle;
  String? terrain;
  dynamic contractorApprove;
  dynamic contractorId;
  dynamic pmcApprove;
  dynamic pmcId;
  dynamic clientId;
  dynamic clientApprove;
  String? activityRemarks;
  String? source;
  String? status;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? formateNo;
  dynamic contractorApproveDate;
  dynamic pmcApproveDate;
  dynamic clientApproveDate;
  String? activityDate;
  String? activityId;
  String? latitude;
  String? longitude;
  String? weatherId;
  String? groundTypeId;
  dynamic pipeSize;
  String? ureportNo;
  dynamic contractorSource;
  dynamic rejectRemark;
  String? image;
  String? downloadLink;
  String? spreadName;
  String? sectionName;

  ReportActivityData(
      {this.id,
        this.spreadId,
        this.sectionId,
        this.alignmentSheetId,
        this.chainageFrom,
        this.chainageTo,
        this.totalLength,
        this.reportNo,
        this.attachFile,
        this.weather,
        this.tpIpChainage,
        this.chainage,
        this.tpIpNos,
        this.tpRemarks,
        this.bearingAngle,
        this.terrain,
        this.contractorApprove,
        this.contractorId,
        this.pmcApprove,
        this.pmcId,
        this.clientId,
        this.clientApprove,
        this.activityRemarks,
        this.source,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.formateNo,
        this.contractorApproveDate,
        this.pmcApproveDate,
        this.clientApproveDate,
        this.activityDate,
        this.activityId,
        this.latitude,
        this.longitude,
        this.weatherId,
        this.groundTypeId,
        this.pipeSize,
        this.ureportNo,
        this.contractorSource,
        this.rejectRemark,
        this.image,
        this.downloadLink,
        this.spreadName,
        this.sectionName});

  ReportActivityData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    spreadId = json['spread_id'] ?? "";
    sectionId = json['section_id'] ?? "";
    alignmentSheetId = json['alignment_sheet_id'] ?? "";
    chainageFrom = json['chainage_from'] ?? "";
    chainageTo = json['chainage_to'] ?? "";
    totalLength = json['total_length'] ?? "";
    reportNo = json['report_no'] ?? "";
    attachFile = json['attach_file'] ?? "";
    weather = json['weather'] ?? "";
    tpIpChainage = json['tp_ip_chainage'] ?? "";
    chainage = json['chainage'] ?? "";
    tpIpNos = json['tp_ip_nos'] ?? "";
    tpRemarks = json['tp_remarks'] ?? "";
    bearingAngle = json['bearing_angle'] ?? "";
    terrain = json['terrain'] ?? "";
    contractorApprove = json['contractor_approve'] ?? "";
    contractorId = json['contractor_id'] ?? "";
    pmcApprove = json['pmc_approve'] ?? "";
    pmcId = json['pmc_id'] ?? "";
    clientId = json['client_id'] ?? "";
    clientApprove = json['client_approve'] ?? "";
    activityRemarks = json['activity_remarks'] ?? "";
    source = json['source'] ?? "";
    status = json['status'] ?? "";
    createdBy = json['created_by'] ?? "";
    updatedBy = json['updated_by'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    formateNo = json['formate_no'] ?? "";
    contractorApproveDate = json['contractor_approve_date'] ?? "";
    pmcApproveDate = json['pmc_approve_date'] ?? "";
    clientApproveDate = json['client_approve_date'] ?? "";
    activityDate = json['activity_date'] ?? "";
    activityId = json['activity_id'] ?? "";
    latitude = json['latitude'] ?? "";
    longitude = json['longitude'] ?? "";
    weatherId = json['weather_id'] ?? "";
    groundTypeId = json['ground_type_id'] ?? "";
    pipeSize = json['pipe_size'] ?? "";
    ureportNo = json['ureport_no'] ?? "";
    contractorSource = json['contractor_source'] ?? "";
    rejectRemark = json['reject_remark'] ?? "";
    image = json['image'] ?? "";
    downloadLink = json['download_link'] ?? "";
    spreadName = json['spread_name'] ?? "";
    sectionName = json['section_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['spread_id'] = this.spreadId;
    data['section_id'] = this.sectionId;
    data['alignment_sheet_id'] = this.alignmentSheetId;
    data['chainage_from'] = this.chainageFrom;
    data['chainage_to'] = this.chainageTo;
    data['total_length'] = this.totalLength;
    data['report_no'] = this.reportNo;
    data['attach_file'] = this.attachFile;
    data['weather'] = this.weather;
    data['tp_ip_chainage'] = this.tpIpChainage;
    data['chainage'] = this.chainage;
    data['tp_ip_nos'] = this.tpIpNos;
    data['tp_remarks'] = this.tpRemarks;
    data['bearing_angle'] = this.bearingAngle;
    data['terrain'] = this.terrain;
    data['contractor_approve'] = this.contractorApprove;
    data['contractor_id'] = this.contractorId;
    data['pmc_approve'] = this.pmcApprove;
    data['pmc_id'] = this.pmcId;
    data['client_id'] = this.clientId;
    data['client_approve'] = this.clientApprove;
    data['activity_remarks'] = this.activityRemarks;
    data['source'] = this.source;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['formate_no'] = this.formateNo;
    data['contractor_approve_date'] = this.contractorApproveDate;
    data['pmc_approve_date'] = this.pmcApproveDate;
    data['client_approve_date'] = this.clientApproveDate;
    data['activity_date'] = this.activityDate;
    data['activity_id'] = this.activityId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['weather_id'] = this.weatherId;
    data['ground_type_id'] = this.groundTypeId;
    data['pipe_size'] = this.pipeSize;
    data['ureport_no'] = this.ureportNo;
    data['contractor_source'] = this.contractorSource;
    data['reject_remark'] = this.rejectRemark;
    data['image'] = this.image;
    data['download_link'] = this.downloadLink;
    data['spread_name'] = this.spreadName;
    data['section_name'] = this.sectionName;
    return data;
  }
}
