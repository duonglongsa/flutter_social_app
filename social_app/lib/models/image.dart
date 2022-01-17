class ImageModel{
  String? id;
  String? fileName;
  String? base64;

  ImageModel(this.base64);

  ImageModel.fromJson(Map<String, dynamic> json):
    id = json['_id'],
    fileName = json['fileName'];
}