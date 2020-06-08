import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vote_app/data/election/election_list.dart';
import 'package:vote_app/data/repository/election_repository.dart';
import 'package:vote_app/ui/style/color/colors.dart';
import 'package:vote_app/ui/vote/vote.dart';
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

  Widget _buildBody(BuildContext context, AsyncSnapshot snapshot) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.blue,
        child: FlatButton(
          onPressed: () {},
          child: Text(
            'Logout'.toUpperCase(),
            style: h2,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Home'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: h0,
                        ),
                      ),
                    ),
                    buildpie(dataMap)
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: GFCarousel(
                  height: 150,
                  items: [
                    buildParties(),
                    buildParties(),
                    buildParties(),
                    buildParties(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: GFCarousel(
                      viewportFraction: 0.65,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: false,
                      activeIndicator: Colors.blue,
                      height: 253,
                      items: [
                        gfCard(),
                        gfCard(),
                        gfCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildParties() {
    return GestureDetector(
      onTap: () {},
      child: GFCard(
        title: GFListTile(
          title: Text('Party name'),
          subTitle: Text('ideology'),
          avatar: GFAvatar(),
        ),
      ),
    );
  }

  GFCard gfCard() {
    return GFCard(
      content: Column(
        children: [
          Text(
            'Title',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          PieChart(
            dataMap: dataMap,
          ),
        ],
      ),
      buttonBar: GFButtonBar(
        children: <Widget>[
          Container(
            height: 68,
            child: GFButton(
              color: Colors.deepOrangeAccent,
              fullWidthButton: true,
              onPressed: () {},
              text: 'Join'.toUpperCase(),
              textStyle: h2,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildpie(Map map) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VotePage(
                  dataMap: dataMap,
                ),
              ));
        },
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(color: Colors.white),
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
      ),
    );
  }
}
