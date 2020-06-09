import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vote_app/ui/style/color/colors.dart';
import 'package:vote_app/ui/style/text/style.dart';
import 'package:vote_app/ui/widget/load.dart';

class VotePage extends StatefulWidget {
  final String dateEnd;
  final String electionTitle;
  final Map dataMap;
  final AsyncSnapshot asyncSnapshot;

  const VotePage(
      {Key key,
      @required this.dataMap,
      this.dateEnd,
      this.electionTitle,
      this.asyncSnapshot})
      : super(key: key);
  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.blue,
        child: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Back'.toUpperCase(),
            style: h2,
          ),
        ),
      ),
      body: Align(
        child: Container(
          decoration: BoxDecoration(
            gradient: backgroundGradient,
          ),
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'VOTE',
                style: h0,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              buildpie(
                  map: widget.dataMap,
                  electionTitle: widget.electionTitle,
                  dateEnd: widget.dateEnd),
              SizedBox(
                height: 20,
              ),
              Text(
                'Select to vote'.toUpperCase(),
                style: h2,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.dataMap.length,
                  itemBuilder: (context, index) {
                    return GFCarousel(
                      scrollDirection: Axis.horizontal,
                      height: 150,
                      viewportFraction: 0.50,
                      items: [
                        gfCard(widget.asyncSnapshot.data.elections[index]
                            .parties.parties[index].name
                            .toString())
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  GFCard gfCard(String title) {
    return GFCard(
      content: GestureDetector(
        onTap: () {
          onLoad(context: context, text: 'Warning', function: () {});
        },
        child: Container(
          child: Center(
            child: Text(
              title,
              style: h0,
            ),
          ),
          width: 300,
          height: 100,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget buildpie({Map map, String electionTitle, String dateEnd}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Text(electionTitle),
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
