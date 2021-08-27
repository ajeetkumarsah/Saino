import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OurFormDataModel {
  String? fName;
  String? lName;
  String? number;
  String? country;
  String? gender;

  //Default Constructor :D
  OurFormDataModel();

  //SnapShot to Current Model Converter :D
  OurFormDataModel.fromSnapToModel(Map<String, dynamic> json) {
    fName = json['fName'];
    lName = json['lName'];
    number = json['number'];
    country = json['country'];
    gender = json['gender'];
  }

  //Convert Model To Map
  Map<String, dynamic> convertToMap({required OurFormDataModel value}) {
    Map<String, dynamic> data = new Map<String, dynamic>();
    if (value.fName != null) data['fName'] = value.fName;
    if (value.lName != null) data['lName'] = value.lName;
    if (value.number != null) data['number'] = value.number;
    if (value.country != null) data['country'] = value.country;
    if (value.gender != null) data['gender'] = value.gender;

    return data;
  }
}
