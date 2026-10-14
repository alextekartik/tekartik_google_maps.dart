library tekartik_google_maps;

import 'dart:async';
import 'dart:js';
import 'dart:html';

import 'package:tekartik_utils/js_utils.dart';

part 'src/google_maps.dart';


GoogleMaps _googleMaps;
Completer _googleMapsLoader;

JsObject googleMapsContext;

Future<GoogleMaps> loadGoogleMaps() async {

  if (_googleMapsLoader == null) {
    _googleMapsLoader = new Completer();

    // Create a jsObject to handle the response.
    String callbackName = 'tekartik_google_maps_load_callback';
    context[callbackName] = () {
      googleMapsContext = context['google']['maps'];
      _googleMaps = new GoogleMaps._(googleMapsContext);
      _googleMapsLoader.complete(_googleMaps);
    };

    // no need to await here we have the callback, but a failed load must
    // fail the loader (and allow a retry) instead of hanging forever
    var loader = _googleMapsLoader;
    loadJavascriptScript('//maps.googleapis.com/maps/api/js?callback=${callbackName}')
        .catchError((e) {
      if (identical(_googleMapsLoader, loader)) {
        _googleMapsLoader = null;
      }
      if (!loader.isCompleted) {
        loader.completeError(e);
      }
    });

  }
  return _googleMapsLoader.future;
}

