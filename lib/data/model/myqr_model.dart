class MyQRModel {
  int myQrCodesId;
  String myQrCodesLabelName;
  String myQrCodesImagePath;
  String myQrCodesCreatedAt;
  int myQrCodesUserid;

  MyQRModel({
    required this.myQrCodesId,
    required this.myQrCodesLabelName,
    required this.myQrCodesImagePath,
    required this.myQrCodesCreatedAt,
    required this.myQrCodesUserid,
  });

  factory MyQRModel.fromJson(Map<String, dynamic> json) {
    return MyQRModel(
      myQrCodesId: json['myQrCodes_id'],
      myQrCodesLabelName: json['myQrCodes_labelName'],
      myQrCodesImagePath: json['myQrCodes_imagePath'],
      myQrCodesCreatedAt: json['myQrCodes_created_at'],
      myQrCodesUserid: json['myQrCodes_userid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['myQrCodes_id'] = myQrCodesId;
    data['myQrCodes_labelName'] = myQrCodesLabelName;
    data['myQrCodes_imagePath'] = myQrCodesImagePath;
    data['myQrCodes_created_at'] = myQrCodesCreatedAt;
    data['myQrCodes_userid'] = myQrCodesUserid;
    return data;
  }
}
