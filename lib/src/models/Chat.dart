class Chats {
  bool success;
  Results results;
  String message;

  Chats({this.success, this.results, this.message});

  Chats.fromJson(Map<String, dynamic> json) {
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
  var currentPage;
  List<ChatData> data;
  var firstPageUrl;
  var from;
  var lastPage;
  var lastPageUrl;
  var nextPageUrl;
  var path;
  var perPage;
  var prevPageUrl;
  var to;
  var total;

  Results(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Results.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];


    data = new List<ChatData>();

    if (json["data"].runtimeType.toString().endsWith("List<dynamic>")) {
      json['data'].forEach((v) {
        print("Valueeee  ${v}");

        data.add(new ChatData.fromJson(v));
      });
    } else {
      Map<dynamic, dynamic> map = json["data"];
      map.forEach((key, value) {
        data.add(new ChatData.fromJson(value));
      });
    }


   /* if (json['data'] != null) {
      data = new List<ChatData>();
      json['data'].forEach((v) {
        data.add(new ChatData.fromJson(v));
      });
    }*/
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class ChatData {
  var messageId;
  var name;
  var image;
  var message;
  var createdAt;

  ChatData({this.messageId, this.name, this.image, this.message, this.createdAt});

  ChatData.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    name = json['name'];
    image = json['image'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message_id'] = this.messageId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}
