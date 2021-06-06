import 'package:data_saving/dataProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> pyr = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha'a"];

  @override
  Widget build(BuildContext context) {
    var notifications = Provider.of<TheData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Notifiche",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                "Scegli le preghiere che vuoi essere avvisato",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.getNotifications().length,
                itemBuilder: (context, index) {
                  List<bool> list = notifications.getNotifications();
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: index == 0
                            ? Radius.circular(20)
                            : Radius.circular(0),
                        topRight: index == 0
                            ? Radius.circular(20)
                            : Radius.circular(0),
                        bottomLeft: index == 4
                            ? Radius.circular(20)
                            : Radius.circular(0),
                        bottomRight: index == 4
                            ? Radius.circular(20)
                            : Radius.circular(0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pyr[index],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                child: FlutterSwitch(
                                  activeColor: Theme.of(context).primaryColor,
                                  width: 70.0,
                                  height: 30.0,
                                  valueFontSize: 15.0,
                                  toggleSize: 15.0,
                                  value: list[index],
                                  padding: 8.0,
                                  showOnOff: true,
                                  onToggle: (value) {
                                    setState(() {
                                      notifications.updateNotifications(index);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                list[index]
                                    ? LineAwesomeIcons.bell
                                    : LineAwesomeIcons.bell_slash,
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
