import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  String url='https://api.onesignal.com/notifications';
  static const String oneSignalAppId = "0a35afa9-5361-43e2-9149-df923ce38aee";
  static const String oneSignalRestApiKey =
      "os_v2_app_bi227kktmfb6fekj36jdzy4k52uqvfxovrmu37nwo3rmxj6trrbh3ariqad34oeszat36ip5s6n6g7hi26i5ozk547hn7zwnemomssy";

  Future<void> sendNotification({required String pushId, required String title, required String body}) async {
  try {
  
    
  var response=await http.post(Uri.parse(url,),headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Basic $oneSignalRestApiKey'
  },body: jsonEncode({
    "app_id": oneSignalAppId,
    "contents": {
      "en": body
    },
    "include_player_ids": [pushId],
    "headings": {
      "en": title
    },
    
   
  }));

  if(response.statusCode==200){
    
  }else{
    
  }
} on Exception catch (e) {
  
}
  
  }

  }