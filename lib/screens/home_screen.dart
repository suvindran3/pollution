import 'package:flutter/material.dart';
import 'package:react_ec/sample.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MapZoomPanBehavior mapZoomPanBehavior;
  late MapTileLayerController mapTileLayerController;
  late MapShapeSource mapShapeSource;
  final double min = 0;
  final double max = 2.3880000000000003;

  @override
  void initState() {
    mapZoomPanBehavior = MapZoomPanBehavior(minZoomLevel: 3, maxZoomLevel: 17);
    mapTileLayerController = MapTileLayerController();
    mapShapeSource = MapShapeSource.asset(
      'images/data.json',
      dataCount: 50,
      primaryValueMapper: (count) => '50',
      shapeColorValueMapper: (count) => 50,
      shapeColorMappers: [
        const MapColorMapper(from: 0, to: 100, color: Colors.red),
        const MapColorMapper(from: 101, to: 300, color: Colors.green)
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Scrollbar(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        hintText: 'Chennai',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const ListTile(
                    title: Text(
                      'Temperature',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      '29.35 C',
                      style: TextStyle(color: Colors.white),
                    ),
                    tileColor: Color(0xff1660A1),
                    leading: Icon(Icons.thermostat_outlined),
                  ),
                  const ListTile(
                    title: Text(
                      'Humidity',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      '73%',
                      style: TextStyle(color: Colors.white),
                    ),
                    tileColor: Color(0xff1660A1),
                    leading: Icon(Icons.opacity_outlined),
                  ),
                  const ListTile(
                    title: Text(
                      'Pressure',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      '1016 mb',
                      style: TextStyle(color: Colors.white),
                    ),
                    tileColor: Color(0xff1660A1),
                    leading: Icon(Icons.compress_outlined),
                  ),
                  const ListTile(
                    title: Text(
                      'Feels like',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      '29.35 C',
                      style: TextStyle(color: Colors.white),
                    ),
                    tileColor: Color(0xff1660A1),
                    leading: Icon(Icons.thermostat_auto_outlined),
                  ),
                  SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 500,
                        pointers: const <GaugePointer>[
                          NeedlePointer(
                            value: 350,
                          ),
                        ],
                        annotations: const <GaugeAnnotation>[
                          GaugeAnnotation(
                              widget: Text(
                                '350\nModerate Air Quality',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow),
                              ),
                              angle: 90,
                              positionFactor: 0.5),
                        ],
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0,
                              endValue: 50,
                              color: Colors.red,
                              startWidth: 10,
                              endWidth: 10),
                          GaugeRange(
                              startValue: 50,
                              endValue: 100,
                              color: Colors.red,
                              startWidth: 10,
                              endWidth: 10),
                          GaugeRange(
                              startValue: 100,
                              endValue: 150,
                              color: Colors.orange,
                              startWidth: 10,
                              endWidth: 10),
                          GaugeRange(
                              startValue: 150,
                              endValue: 200,
                              color: Colors.orange,
                              startWidth: 10,
                              endWidth: 10),
                          GaugeRange(
                              startValue: 200,
                              endValue: 250,
                              color: Colors.orangeAccent,
                              startWidth: 10,
                              endWidth: 10),
                          GaugeRange(
                              startValue: 250,
                              endValue: 300,
                              color: Colors.orangeAccent,
                              startWidth: 10,
                              endWidth: 10),
                          GaugeRange(
                              startValue: 300,
                              endValue: 350,
                              color: Colors.yellow,
                              startWidth: 10,
                              endWidth: 10),
                          GaugeRange(
                              startValue: 350,
                              endValue: 400,
                              color: Colors.yellow,
                              startWidth: 10,
                              endWidth: 10),
                          GaugeRange(
                              startValue: 400,
                              endValue: 450,
                              color: Colors.green,
                              startWidth: 10,
                              endWidth: 10),
                          GaugeRange(
                              startValue: 450,
                              endValue: 500,
                              color: Colors.green,
                              startWidth: 10,
                              endWidth: 10)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: SfMaps(
              layers: [
                MapTileLayer(
                  zoomPanBehavior: mapZoomPanBehavior,
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  sublayers: [
                    MapCircleLayer(
                      circles: List.generate(
                        1000,
                        (index) => MapCircle(
                          strokeWidth: 0,
                          strokeColor: Colors.transparent,
                          color: const Color(0xffF16019).withOpacity(
                              sample.elementAt(index)['aod'] / max),
                          center: MapLatLng(
                            sample.elementAt(index)['lat'],
                            sample.elementAt(index)['lng'],
                          ),
                        ),
                      ).toSet(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void generateHeatMap() {}
}
