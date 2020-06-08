import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vote_app/data/election/election_list.dart';
import 'package:vote_app/data/repository/election_repository.dart';
import 'package:vote_app/ui/login/login_page.dart';
import 'package:vote_app/ui/style/color/colors.dart';
import 'package:vote_app/ui/style/text/style.dart';

class WelcomePage extends StatefulWidget {
  final CameraDescription camera;

  const WelcomePage({Key key, this.camera}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Future<ElectionList> futureElection;
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
    futureElection = getElectionInformation();
  }

  static final List<String> chartDropdownItems = [
    'Last 7 days',
    'Last month',
    'Last year'
  ];

  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;
  @override
  Widget build(BuildContext context) {
    return buildWelcoming(context);
  }

  Widget buildWelcoming(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ElectionList>(
        future: futureElection,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dataMap.putIfAbsent(
                snapshot.data.elections[0].parties.parties[0].name,
                () => snapshot.data.elections[0].score.scores[0].score
                    .toDouble());
            dataMap.putIfAbsent(
                snapshot.data.elections[1].parties.parties[1].name,
                () => snapshot.data.elections[0].score.scores[1].score
                    .toDouble());
            print(snapshot.hasData);
            return _buildWelcomePage(context, snapshot, 0);
          } else if (snapshot.hasError) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(68.0),
              child: Text("${snapshot.error}"),
            ));
          }
          return Container(
            decoration: BoxDecoration(gradient: backgroundGradient),
            child: Center(
              child: Text(
                'Vote App',
                style: h0,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomePage(
      BuildContext context, AsyncSnapshot asyncSnapshot, int index) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Column(
              children: [
                Text(
                  'Welcome to Voting System',
                  style: h1bold,
                  textAlign: TextAlign.center,
                ),
                Divider(
                  color: Colors.white70,
                ),
                Text(
                  'The way of vote ease and secure',
                  style: h1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            width: 380,
            child: FlatButton(
              color: Colors.blue,
              child: Text(
                'Sign in',
                style: h2,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(
                    camera: widget.camera,
                  ),
                ),
              ),
            ),
          ),
          buildpie(dataMap),
          buildpie(dataMap),
          buildpie(dataMap),
        ],
      ),
    );
  }

  Widget buildpie(Map map) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(color: Colors.white70),
        child: Column(
          children: [
            Text('Title'),
            PieChart(
              dataMap: map,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Days'),
                    Text('Days'),
                  ],
                ),
                Container(
                  width: 3,
                  height: 50,
                  color: Colors.black26,
                ),
                Column(
                  children: [
                    Text('Days'),
                    Text('Days'),
                  ],
                ),
                Container(
                  width: 3,
                  height: 50,
                  color: Colors.black26,
                ),
                Column(
                  children: [
                    Text('Days'),
                    Text('Days'),
                  ],
                ),
                Container(
                  width: 3,
                  height: 50,
                  color: Colors.black26,
                ),
                Column(
                  children: [
                    Text('Days'),
                    Text('Days'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
