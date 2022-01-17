import 'package:flutter/cupertino.dart';

class ImageModel{
  String? id;
  String? fileName;
  String? base64;

  ImageModel(this.base64);
  ImageModel.fileName(this.fileName);

  ImageModel.fromJson(Map<String, dynamic> json):
    id = json['_id'],
    fileName = json['fileName'];

  Map<String, dynamic> toJson() => 
  {
    'type': 'other',
    '_id': id,
    'fileName': fileName,
  };

}