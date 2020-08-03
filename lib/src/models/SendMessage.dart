class SendMessage {
  bool success;
  Results results;
  String message;

  SendMessage({this.success, this.results, this.message});

  SendMessage.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    results =
        json['results'] != null ? new Results.fromJson(json['results']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.results != null) {
      data['results'] = this.results.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Results {
  Messages message;

  Results({this.message});

  Results.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? new Messages.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message.toJson();
    }
    return data;
  }
}

class Messages {
  var conversationId;
  var userId;
  var message;
  var updatedAt;
  var createdAt;
  var id;
  Conversation conversation;

  Messages(
      {this.conversationId,
      this.userId,
      this.message,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.conversation});

  Messages.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversation_id'];
    userId = json['user_id'];
    message = json['message'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    conversation = json['conversation'] != null
        ? new Conversation.fromJson(json['conversation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conversation_id'] = this.conversationId;
    data['user_id'] = this.userId;
    data['message'] = this.message;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.conversation != null) {
      data['conversation'] = this.conversation.toJson();
    }
    return data;
  }
}

class Conversation {
  var id;
  var senderId;
  var receiverId;
  var title;
  var senderViewed;
  var receiverViewed;
  var createdAt;
  var updatedAt;

  Conversation(
      {this.id,
      this.senderId,
      this.receiverId,
      this.title,
      this.senderViewed,
      this.receiverViewed,
      this.createdAt,
      this.updatedAt});

  Conversation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    title = json['title'];
    senderViewed = json['sender_viewed'];
    receiverViewed = json['receiver_viewed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['title'] = this.title;
    data['sender_viewed'] = this.senderViewed;
    data['receiver_viewed'] = this.receiverViewed;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
