library tekartik_google_maps.example;

import 'dart:html';
import 'dart:async';
import 'package:tekartik_google_maps/google_maps.dart';

Storage storage = window.localStorage;

String _storageKeyPref = 'com.tekartik.tekartik_google_maps_example';
dynamic storageGet(String key) {
  return storage['$_storageKeyPref.$key'];
}
void storageSet(String key, String value) {
  if (value == null) {
    storage.remove(key);
  } else {
    storage['$_storageKeyPref.$key'] = value;
  }
}

Element loadResult;
FormElement googleMapForm;
GoogleMaps googleMaps;

// Pref key
String autoLoadPrefKey = 'autoload'; // boolean
String latPrefKey = 'lat'; // num
String lngPrefKey = 'lng'; // num

Future _loadGoogleMaps() async {
  loadResult.innerHtml = 'loading...';
  try {
    googleMaps = await loadGoogleMaps();
    loadResult.innerHtml = 'Google maps loaded';
    googleMapForm.classes.remove('hidden');
  } catch (e, st) {
    print(st);
    loadResult.innerHtml = 'load failed $e';
  }
}

void main() {
  // Load
  FormElement loadGoogleMapsForm = querySelector('form.app-google-maps');
  loadResult = loadGoogleMapsForm.querySelector('.app-result');
  //loadResult.innerHtml ="Ok";

  bool autoLoad = storageGet(autoLoadPrefKey) == true.toString();
  CheckboxInputElement autoLoadCheckbox = loadGoogleMapsForm.querySelector(
      '.app-autoload');
  autoLoadCheckbox.checked = autoLoad;
  autoLoadCheckbox.onChange.listen((_) {
    storageSet(autoLoadPrefKey, autoLoadCheckbox.checked.toString());
  });
  if (autoLoad) {
    _loadGoogleMaps();
  }

  loadGoogleMapsForm.querySelector('button.app-load').onClick.listen((Event event) {
    event.preventDefault();
    _loadGoogleMaps();
  });


  // Map
  FormElement form = querySelector('form.app-map');
  googleMapForm = form;
  InputElement latElement = form.querySelector(".app-lat");
  latElement.value = storageGet(latPrefKey);
  InputElement lngElement = form.querySelector(".app-lng");
  lngElement.value = storageGet(lngPrefKey);
  form.querySelector(".app-go").onClick.listen((event) {
    event.preventDefault();
    storageSet(latPrefKey, latElement.value.toString());
    storageSet(lngPrefKey, lngElement.value.toString());

    num lat = num.parse(latElement.value);
    num lng = num.parse(lngElement.value);
    var mapOptions = new MapOptions()..center = new LatLng(lat, lng);
    var map = new GoogleMap(googleMapForm.querySelector(".app-map-canvas"), mapOptions);
  });


  /*
  Element loadGapiForm = querySelector('form.app-gapi');
  Element loadGapiButton = loadGapiForm.querySelector('button.app-load');

  loadGapiResult = loadGapiForm.querySelector('.app-result');
  CheckboxInputElement autoLoadCheckbox = loadGapiForm.querySelector(
      '.app-autoload');

  bool autoload = storageGet(GAPI_AUTOLOAD) == true.toString();

  autoLoadCheckbox.checked = autoload;
  if (autoload) {
    _loadGapi();
  }

  loadGapiButton.onClick.listen((Event event) {
    event.preventDefault();
    _loadGapi();
  });

  autoLoadCheckbox.onChange.listen((_) {
    storageSet(GAPI_AUTOLOAD, autoLoadCheckbox.checked.toString());
  });

  if (autoload) {
    _loadGapi();
  }
  */
}