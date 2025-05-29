import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String? time;
  String flag;
  String url;
  bool? isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try{
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //create datetime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);

    }catch(e){
      print('caught error: $e');
      time = 'could not get time data';

    }

  }
}

