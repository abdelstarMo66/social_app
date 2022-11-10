class ChatModel {
  String? text;
  String? senderId;
  String? receiverId;
  String? dateMessage;
  String? image;


  ChatModel({
    this.text,
    this.dateMessage,
    this.receiverId,
    this.senderId,
    this.image,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    dateMessage = json['dateMessage'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'dateMessage': dateMessage,
      'receiverId': receiverId,
      'senderId': senderId,
      'image': image,
    };
  }
}
