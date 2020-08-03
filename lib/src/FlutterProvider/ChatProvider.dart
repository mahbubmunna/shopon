import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/Chat.dart';
import 'package:smartcommercebd/src/models/Conversations.dart';
import 'package:smartcommercebd/src/models/Message.dart';
import 'package:smartcommercebd/src/models/SendMessage.dart';
import 'package:smartcommercebd/src/providers/shared_pref_provider.dart';
import 'package:smartcommercebd/src/utils/common_utils.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatData> _chats_list;

  List<ChatData> get chats_list => _chats_list;

  String _url;

  Chats _chats;

  ChatProvider(id) {
    print("OMK IDDD  ${id}");

    if (id != null) {
      getChat(id).then((value) {
        _chats_list = value;

        notifyListeners();
      });
    }
  }

  Future<List<ChatData>> getChat(id) async {
    print("The Id is ${id}");

     if(_chats_list!=null){
      _chats_list.clear();

    }

  //  _chats = new Chats();

    var token = await SharedPrefProvider.getString(token_key);

    Map<String, String> header = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    print("The id  ${id}");
    await http
        .get("${api_base_url}conversation/${id}", headers: header)
        .then((value) {
      print("Chat value  == > ${value.body}");

      _chats = Chats.fromJson(json.decode(value.body));

      CommonUtils.chat_next_url = _chats.results.nextPageUrl;
      setUrl(_chats.results.nextPageUrl);

      print("The url is  ${CommonUtils.chat_next_url}");
      _chats_list = _chats.results.data;

      notifyListeners();
    });

    return _chats_list;
  }

  chatPagination() async {
    var token = await SharedPrefProvider.getString(token_key);

    Map<String, String> header = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    await http
        .get("${CommonUtils.chat_next_url}", headers: header)
        .then((value) {
      print("Chat value  == > ${value.body}");





      //_chats=new Chats();
      _chats = Chats.fromJson(json.decode(value.body));

      CommonUtils.chat_next_url = _chats.results.nextPageUrl;

      setUrl(_chats.results.nextPageUrl);
      //_url = ;

      for (int i = 0; i < _chats.results.data.length; i++) {
        print("_chats.results.data[i]   ${_chats.results.data[i]}");

        _chats_list.add(_chats.results.data[i]);

        print("chats_list   ${_chats_list.length}");

        notifyListeners();
      }
    });
  }

  Future<SendMessage> setMessage(product_id, messages) async {
    SendMessage message;

    var token = await SharedPrefProvider.getString(token_key);

    Map<String, String> body = {
      "conversation_id": product_id.toString(),
      //"title": title,
      "message": messages,
    };

    Map<String, String> header = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    await http
        .post("${api_base_url}send-message", body: body, headers: header)
        .then((value) {
      print("The Value Iss ${value.body}");
      message = SendMessage.fromJson(json.decode(value.body));

      getChat(product_id);
    });

    return message;
  }

  void setUrl(nextPageUrl) {
    _url = nextPageUrl;
    notifyListeners();
  }
}
