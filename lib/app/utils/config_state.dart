import 'package:first/app/utils/preference_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:signals/signals.dart';

class ConfigState {
  static const STORE_URL_KEY = 'URL';
  static const STORE_TOKEY_KEY = 'TOKEN';
  final url = signal('');
  final token = signal('');
  bool disposeCtrl = false;
  ConfigState({required this.prefs}) {
    prefs.read(STORE_URL_KEY).then((value) {
      url.set(value != '' ? value : 'http://192.168.77.34:8080/');
    });
    prefs.read(STORE_TOKEY_KEY).then((value) {
      if(value!="") {
        token.set(value);
      }
    });

    url.subscribe((value) {
      if(disposeCtrl == false && value != "") {
        prefs.write(STORE_URL_KEY, value);
        debugPrint("set-URL:${url()}");
      }
    });

    token.subscribe((value) {
      if(disposeCtrl == false && value != ""){
        prefs.write(STORE_TOKEY_KEY, value);
        debugPrint("set-TOKEN:${token()}");
      }
    });
  }
  final PreferenceStore prefs;
  dispose(){
    disposeCtrl = true;
    debugPrint("prefs-dispose-url:${url()}");
    debugPrint("prefs-dispose-token:${token()}");
    url.dispose();
    token.dispose();
  }
}