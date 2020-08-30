import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tqwa/component/menu.dart';
import 'package:tqwa/data_screen.dart';
import 'package:tqwa/location.dart';

class Home extends StatelessWidget {
  final type;

  Home({this.type});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('خروج'),
                content: Text('هل تريد الخروج من التطبيق ؟'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => SystemNavigator.pop(),
                      child: Text('نعم')),
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('لا'))
                ],
              )),
      child: Scaffold(
        appBar: AppBar(
          title: Text('HOME'),
          centerTitle: true,
        ),
        drawer: Drawer(child: Menu()),
        backgroundColor: Colors.white.withOpacity(0.95),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection(type).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (snapshot.hasError)
                return Center(
                  child: Text('لا يوجد بلاغات جديده'),
                );
              return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  children: snapshot.data.documents
                      .map<Widget>((DocumentSnapshot document) {
                    return Card(
                      elevation: 15.0,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DataScreen(
                                address: document.data['address'],
                                caseInfo: document.data['case'],
                                city: document.data['city'],
                                name: document.data['name'],
                                phone: document.data['phone'],
                              ),
                            ),
                          );
                        },
                        title: Text(document.data['name'] ?? 'بدون عنوان'),
                        subtitle: Text(document.data['case'].toString() ??
                            'الحاله غير محدده'),
                        trailing: IconButton(
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.blue,
                            ),
                            onPressed: () async {
                              //open Location on Google Map
                              Location location = Location();
                              Position position =
                                  await location.getCurrentLocation();
                              await location.openGoogleMapApp(
                                  latitude: position.latitude,
                                  longitude: position.longitude);
                            }),
                      ),
                    );
                  }).toList());
            }),
      ),
    );
  }
}
