// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatModel {
  final String msg;
  final int index;
  ChatModel({
    required this.msg,
    required this.index,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      ChatModel(msg: json['msg'], index: json['index']);
}
