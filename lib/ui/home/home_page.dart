import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vote_app/data/election/election_list.dart';
import 'package:vote_app/data/repository/election_repository.dart';
import '../style/text/style.dart';
import '../welcome/welcome_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHomePage(),
    );
  }

  Widget _buildHomePage() {
    return FutureBuilder<ElectionList>(
      future: futureElection,
      builder: (context, snapshot) {
        dataMap.putIfAbsent(snapshot.data.elections[0].parties.parties[0].name,
            () => snapshot.data.elections[0].score.scores[0].score.toDouble());
        dataMap.putIfAbsent(snapshot.data.elections[1].parties.parties[1].name,
            () => snapshot.data.elections[0].score.scores[1].score.toDouble());
        if (snapshot.hasData) {
          return _buildBody(context, snapshot);
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }

  Container _buildBody(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      color: Color.fromRGBO(19, 76, 113, 1),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Text(
                      '',
                      style: h0,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: PieChart(
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
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Text(
                    'Tap to Vote!',
                    style: h2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  child: GFItemsCarousel(
                    itemHeight: 100,
                    rowCount: 4,
                    children: List.generate(
                      4,
                      (index) => Container(
                        width: 200,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(index.toString()),
                          color:
                              Color.fromRGBO(index * 65, index * 220, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Text(
                    'Join another election',
                    style: h2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  child: GFCarousel(
                    height: 250,
                    items: [
                      GFCard(
                        boxFit: BoxFit.cover,
                        image: Image.asset('your asset image'),
                        title: GFListTile(
                          avatar: GFAvatar(),
                          title: Text('Card Title'),
                          icon: GFIconButton(
                            onPressed: null,
                            icon: Icon(Icons.favorite_border),
                          ),
                        ),
                        content: Text(
                            "Some quick example text to build on the card"),
                        buttonBar: GFButtonBar(
                          children: <Widget>[
                            GFButton(
                              onPressed: () {},
                              text: 'Join',
                            ),
                          ],
                        ),
                      ),
                      GFCard(
                        boxFit: BoxFit.cover,
                        image: Image.asset('your asset image'),
                        title: GFListTile(
                          avatar: GFAvatar(),
                          title: Text('Card Title'),
                          icon: GFIconButton(
                            onPressed: null,
                            icon: Icon(Icons.favorite_border),
                          ),
                        ),
                        content: Text(
                            "Some quick example text to build on the card"),
                        buttonBar: GFButtonBar(
                          children: <Widget>[
                            GFButton(
                              onPressed: () {},
                              text: 'Join',
                            ),
                          ],
                        ),
                      ),
                      GFCard(
                        boxFit: BoxFit.cover,
                        image: Image.asset('your asset image'),
                        title: GFListTile(
                          avatar: GFAvatar(),
                          title: Text('Card Title'),
                          icon: GFIconButton(
                            onPressed: null,
                            icon: Icon(Icons.favorite_border),
                          ),
                        ),
                        content: Text(
                            "Some quick example text to build on the card"),
                        buttonBar: GFButtonBar(
                          children: <Widget>[
                            GFButton(
                              onPressed: () {},
                              text: 'Join',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              height: 80,
              child: GFButton(
                child: Text('Logout'),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WelcomePage()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
