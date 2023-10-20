// ignore_for_file: public_member_api_docs, sort_constructors_first
class Models {
  String id;
  String root;
  int create;
  Models({
    required this.id,
    required this.root,
    required this.create,
  });
  factory Models.fromJson(Map<String, dynamic> json) =>
      Models(id: json['id'], root: json['root'], create: json['created']);

  static List<Models> modelsList(List response) {
    return response.map((e) => Models.fromJson(e)).toList();
  }
}
