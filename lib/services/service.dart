import 'dart:html' as html;
import 'package:shared_preferences/shared_preferences.dart';

void downloadFile(String url) {
  html.AnchorElement anchorElement = new html.AnchorElement(href: url);
  anchorElement.download = url;
  anchorElement.click();
}

sharedChannelGet() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getString('channel') ?? 'Global';
}

sharedChannelSet(String channel) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('channel', channel);
}
