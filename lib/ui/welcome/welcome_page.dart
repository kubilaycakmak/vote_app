import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vote_app/data/dummy/chart_dummy_data.dart';
import 'package:vote_app/data/repository/user_repository.dart';
import 'package:vote_app/ui/authentication/authentication_bloc.dart';
import 'package:vote_app/ui/login/bloc/login_bloc.dart';
import 'package:vote_app/ui/login/login_page.dart';
import 'package:vote_app/ui/style/color/colors.dart';
import 'package:vote_app/ui/style/text/style.dart';

class WelcomePage extends StatefulWidget {

  
  const WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  UserRepository userRepository;
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

  static final List<String> chartDropdownItems = [ 'Last 7 days', 'Last month', 'Last year' ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
              Center(child: Column(
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Text('Welome to Vote Application', style: h1, textAlign: TextAlign.center,),
                    Divider(
                      color: Colors.white,
                    ),
                    Text('The way secure and simple', style: h2, textAlign: TextAlign.center,),
                  ],
                )),
            FloatingActionButton.extended(
              heroTag: 'loginButton',
              backgroundColor: Colors.blue.shade700,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(
                  )
                ));
              }, 
              label: Text('Login')),
            _buildTile(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: <Widget>[
                    Text('Dummy VOTE - B'),
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
                          initialAngle: 1,
                          chartValueStyle: defaultChartValueStyle.copyWith(
                            color: Colors.blueGrey[900].withOpacity(0.9),
                          ),
                          chartType: ChartType.disc,
                        ),
                  ],
                ),
              ),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: <Widget>[
                    Text('Dummy VOTE - A'),
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
            _buildTile(
              Padding
                  (
                    padding: const EdgeInsets.all(24.0),
                    child: Column
                    (
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [
                        Row
                        (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>
                          [
                            Column
                            (
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>
                              [
                                Text('Vote', style: TextStyle(color: Colors.green)),
                                Text('\16K', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                              ],
                            ),
                            DropdownButton
                            (
                              isDense: true,
                              value: actualDropdown,
                              onChanged: (String value) => setState(()
                              {
                                actualDropdown = value;
                                actualChart = chartDropdownItems.indexOf(value); // Refresh the chart
                              }),
                              items: chartDropdownItems.map((String title)
                              {
                                return DropdownMenuItem
                                (
                                  value: title,
                                  child: Text(title, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 14.0)),
                                );
                              }).toList()
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 4.0)),
                        Sparkline
                        (
                          data: charts[actualChart],
                          lineWidth: 5.0,
                          lineColor: Colors.greenAccent,
                        )
                      ],
                    )
                  ),
            ),
            _buildTile(
              Padding
              (
                padding: const EdgeInsets.all(24.0),
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Column
                    (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [
                        Text('Total Vote used', style: TextStyle(color: Colors.redAccent)),
                        Text('173K', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
                      ],
                    ),
                    Material
                    (
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(24.0),
                      child: Center
                      (
                        child: Padding
                        (
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.person, color: Colors.white, size: 30.0),
                        )
                      )
                    )
                  ]
                ),
              ),
              onTap: () => null,
            )
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 140.0),
            StaggeredTile.extent(2, 50.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(2, 220.0),
            StaggeredTile.extent(2, 110.0),
          ],
        ),
      )
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell
      (
        // Do onTap() if it isn't null, otherwise do print()
        onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
        child: child
      )
    );
  }
}