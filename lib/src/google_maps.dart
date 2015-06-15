part of tekartik_google_maps;

class GoogleMaps {
  JsObject jsObject;

  GoogleMaps._(this.jsObject);
}

class LatLng {
  JsObject _jsObject;
  LatLng(num lat, num lng) {
    _jsObject = new JsObject(googleMapsContext['LatLng'], [lat, lng]);
  }
}

class MapTypeId {
  static JsObject get _all => googleMapsContext['MapTypeId'];
  static get roadMap => _all['ROADMAP'];
}

class GoogleMap {
  JsObject _jsObject;
  GoogleMap(Element mapElement, MapOptions mapOptions) {
    new JsObject(googleMapsContext['Map'], [mapElement, mapOptions._jsObject]);
  }
}
class MapOptions {
  JsObject _jsObject = new JsObject.jsify({
    "zoom": 8,
    "mapTypeId": MapTypeId.roadMap
  });
  set center(LatLng center) => _jsObject['center'] = center._jsObject;
  MapOptions();
}

//var get mapTypeIdRo
/*
 var mapTypeId = google_maps['MapTypeId']['ROADMAP'];

  // new JsObject.jsify() recursively converts a collection of Dart objects
  // to a collection of JavaScript objects and returns a proxy to it.
  var mapOptions = new JsObject.jsify({
      "center": center,
      "zoom": 8,
      "mapTypeId": mapTypeId
  });

  // Nodes are passed though, or transferred, not proxied.
  new JsObject(google_maps['Map'], [querySelector('#map-canvas'), mapOptions]);
 */