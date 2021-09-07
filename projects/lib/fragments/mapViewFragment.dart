import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:projects/MapPopUps/categoryMapPopup.dart';
import 'package:projects/api/nearbyCategoriesService.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';



class StatefulMapFragment extends StatefulWidget {
  @override
  _MapFragment createState() => _MapFragment();
}



class _MapFragment extends State<StatefulMapFragment> {

  // TODO make it impossible to zoom out so far that background of fragment can be seen

  List<Marker> _markerList = List.empty(growable: true);

  final MapController mapController = new MapController();
  final NearbyCategoriesService ncs = new NearbyCategoriesService();
  final PopupController _popupLayerController = PopupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
            onTap: (_) => _popupLayerController.hidePopup(),
            controller: mapController,
            center: LatLng(46.8, 8.22), // TODO Start on users Location
            zoom: 8.0,
            plugins: <MapPlugin>[
              LocationMarkerPlugin(),
              MarkerClusterPlugin()
            ]),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        LocationMarkerLayerOptions(),
        MarkerClusterLayerOptions(
          // TODO get markers to rotate as well
          popupOptions: PopupOptions(
              popupBuilder: (BuildContext context, Marker marker) => CategoryPopup(marker),
              popupController: _popupLayerController,
              markerRotate: true,
          ),
          builder: (BuildContext context, List<Marker> markers) {
            return FloatingActionButton(
              child: Text(markers.length.toString()),
              onPressed: () {},
              heroTag: "clusterBtn",
            ); // TODO Implement zoom in on tap
          },
          markers: getMarkerList(),
          maxClusterRadius: 120,
          size: Size(40, 40),
          fitBoundsOptions: FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
        ),
      ]),
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          ncs.markerBuilder(ncs.getNearbyCategories(mapController.center.latitude, mapController.center.longitude, calculateRadius())).then((value) {
            _markerList = value;
            setState(() {});
          });
        },
        label: Text("Search in this area"),
        icon: Icon(Icons.search),
        heroTag: "searchBtn",
      ),
    );
  }

  int calculateRadius() {
    // TODO Implement
    return 4;
  }

  List<Marker> getMarkerList () {
    return _markerList;
  }
}
