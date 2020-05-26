import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../style/text/style.dart';
import '../welcome/welcome_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, double> dataMap = Map();

  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("A", () => 5);
    dataMap.putIfAbsent("B", () => 3);
    dataMap.putIfAbsent("C", () => 2);
    dataMap.putIfAbsent("D", () => 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHomePage(),
    );
  }

  Widget _buildHomePage() {
    return Container(
      color: Colors.lightBlue[200],
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      'Current',
                      style: h0,
                    ),
                  ),
                  PieChart(
                    dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 10.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
                    showLegends: true,
                    legendPosition: LegendPosition.right,
                    initialAngle: 3,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.disc,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Select box to Vote!',
                      style: h2,
                    ),
                  ),
                  Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            height: 100,
                            width: 200,
                            color: Color.fromRGBO(59 * index + 1,
                                25 * index + 1, 10 * index + 1, 1),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Other Elections',
                      style: h2,
                    ),
                  ),
                  Container(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            height: 100,
                            width: 200,
                            color: Color.fromRGBO(19 * index + 1,
                                95 * index + 2, 10 * index + 1, 0.9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: ClipOval(
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      color: Color.fromRGBO(999 * index,
                                          95 * index, 10 * index, 1),
                                      height: 140,
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Tikla',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .button
                                            .color),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            color: Colors.white,
            height: 100,
            child: FlatButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WelcomePage()));
              },
            ),
          )),
        ],
      ),
    );
  }
}
