import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vote_app/data/election/election_list.dart';
import 'package:vote_app/data/repository/election_repository.dart';
import 'package:vote_app/ui/style/color/colors.dart';
import 'package:vote_app/ui/vote/vote.dart';
import '../style/text/style.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<ElectionList> futureElection1;
  Map<String, double> dataMap = Map();

  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  @override
  void initState() {
    futureElection1 = getElectionInformation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHomePage(),
    );
  }

  Widget _buildHomePage() {
    return FutureBuilder<ElectionList>(
      future: futureElection1,
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
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Current'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: h0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: GFCarousel(
                        viewportFraction: 0.95,
                        enableInfiniteScroll: false,
                        height: 310,
                        items: [0, 1].map((e) {
                          return buildpie(
                              map: dataMap,
                              dateEnd: snapshot.data.elections[0].dateEnd,
                              electionTitle:
                                  snapshot.data.elections[0].description,
                              snapshot: snapshot);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: GFCarousel(
                  viewportFraction: 0.95,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: false,
                  height: 150,
                  items: [0, 1].map((e) {
                    return buildParties(
                        partyName:
                            snapshot.data.elections[e].parties.parties[e].name,
                        ideology: snapshot
                            .data.elections[e].parties.parties[e].ideology,
                        color: Colors.red);
                  }).toList(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: GFCarousel(
                viewportFraction: 0.95,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: false,
                activeIndicator: Colors.blue,
                height: 320,
                items: [0, 1].map((e) {
                  return gfCard(
                    electionTitle: snapshot.data.elections[e].description,
                    dataMap: dataMap,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildParties({String partyName, String ideology, Color color}) {
    return GestureDetector(
      onTap: () {},
      child: GFCard(
        title: GFListTile(
          title: Text(
            partyName.toUpperCase(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subTitle: Text(
            ideology.toUpperCase(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          avatar: GFAvatar(
            backgroundColor: color,
            child: Text(partyName[0].toUpperCase()),
          ),
        ),
      ),
    );
  }

  Widget gfCard({String electionTitle, Map dataMap}) {
    return GFCard(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            electionTitle,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          PieChart(
            dataMap: dataMap,
          ),
        ],
      ),
      buttonBar: GFButtonBar(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Flexible(
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

  Widget buildpie(
      {Map map, String electionTitle, String dateEnd, AsyncSnapshot snapshot}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VotePage(
                dataMap: dataMap,
                electionTitle: electionTitle,
                dateEnd: dateEnd,
                asyncSnapshot: snapshot,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Text(
                electionTitle,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              PieChart(
                dataMap: map,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Last Day'),
                      Text(dateEnd.substring(0, 10)),
                    ],
                  ),
                  Container(
                    width: 3,
                    height: 50,
                    color: Colors.black26,
                  ),
                  Column(
                    children: [
                      Text('Vote'),
                      Text((map['ldp'] + map['rdp']).toInt().toString()),
                    ],
                  ),
                  Container(
                    width: 3,
                    height: 50,
                    color: Colors.black26,
                  ),
                  Column(
                    children: [
                      Text('Status'),
                      Text('-'),
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
