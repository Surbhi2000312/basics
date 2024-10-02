import 'dart:convert';
PostsModel postsModelFromJson(String str) => PostsModel.fromJson(json.decode(str));
String postsModelToJson(PostsModel data) => json.encode(data.toJson());
class PostsModel {
  PostsModel({
      this.userId, 
      this.id, 
      this.title, 
      this.body,});

  PostsModel.fromJson(dynamic json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
  num? userId;
  num? id;
  String? title;
  String? body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['id'] = id;
    map['title'] = title;
    map['body'] = body;
    return map;
  }

}