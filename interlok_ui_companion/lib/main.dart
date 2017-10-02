import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ********************************************************************
//
// Main
//
// ********************************************************************
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
      routes: <String, WidgetBuilder> {
        '/addUiInstance': (BuildContext context) => new AddUiPage(),
      },
    );
  }
}

//String _ipAddress = 'Unknown';
List adapterList = [];

// ********************************************************************
//
// This is the Add UI Instance Page
//
// ********************************************************************
class AddUiPage extends StatefulWidget {
  AddUiPage({Key key}) : super(key: key);

  @override
  _AddUiPageState createState() => new _AddUiPageState();
}


class _AddUiPageState extends State<AddUiPage> {

  final TextEditingController uiURL = new TextEditingController(text: 'http://dev-vm02.adaptris.net/interlok/');
  final TextEditingController uiUser = new TextEditingController(text: 'admin');
  final TextEditingController uiPsw = new TextEditingController(text: 'admin');

  //prob a constant
  String apiURI = 'api/external/adapter';

  pushAdapter(BuildContext context, adp) {
      adapterList.add(adp);
  }

  addUIInstance(BuildContext context) async {
    String url = uiURL.text + apiURI;

    final auth = BASE64.encode(UTF8.encode("${uiUser.text}:${uiPsw.text}"));
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'authorization': 'Basic $auth'
    });
    List data = JSON.decode(response.body);
    for (var object in data) {
      pushAdapter(context, object);
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling set State to update our
    // non-existent appearance.
    if (!mounted) return;
  }

  // add ui instance page options
  Widget getAddOptions(BuildContext context) {
    Widget addOptionsSection = new Container(
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new RaisedButton(
                onPressed: () {
                  addUIInstance(context);
                  Navigator.of(context).pushNamed('/');
                },
                child: new Text('Add'),
              ),
              new RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
                child: new Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
    return addOptionsSection;
  }

  @override
  Widget build(BuildContext context) {

    Widget pageContent = new Container(
      child: new Column(
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Text(
                'Add an Interlok UI Instance',
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
              new SizedBox(height: 12.0),
              new TextField(
                controller: uiURL,
                decoration: new InputDecoration(
                  hintText: 'UI URL',
                ),
              ),
              new TextField(
                controller: uiUser,
                decoration: new InputDecoration(
                  hintText: 'Username',
                ),
              ),
              new TextField(
                controller: uiPsw,
                decoration: new InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return new Scaffold(
      body: new Center(
        child: new Column(
          children: <Widget>[
            getTitleSection(context),
            pageContent,
            getAddOptions(context),
          ],
        ),
      ),
    );
  }
}

// ********************************************************************
//
// This is the Home Page
//
// ********************************************************************
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

String uiURL = 'http://dev-vm02.adaptris.net/interlok/';
String uiUser = 'admin';
String uiPsw = 'admin';
String apiURI = 'api/external/adapter';

getAdapterDetails(BuildContext context, adp) async {
//  String jmxEnv = adp['jmxEnv'];
//  String jmxUid = adp['jmxUid'];
//  String adpUrl = adp['url'];
  
  print("getAdapterDetails for adp:" + adp);
  String adpId = adp['id'].toString();

  print("getAdapterDetails for adpId:" + adpId);
  
    
//  var esp_url = adpUrl; //HTML_ESCAPE.convert(adpUrl);
//  var esp_jmxUid = jmxUid; //HTML_ESCAPE.convert(jmxUid);

  String url = uiURL + apiURI + '/' + adpId;
  print("getAdapterDetails for url:" + url);

  final auth = BASE64.encode(UTF8.encode("${uiUser}:${uiPsw}"));
  var response = await http.get(url, headers: {
    'Accept': 'application/json',
    'authorization': 'Basic $auth'
  });
  print("getAdapterDetails:" + response.body);
  return JSON.decode(response.body);
}

class _MyHomePageState extends State<MyHomePage> {

  Widget getAdapterRow(adp) {
    String name = adp['name'];
    String adpState = "Unknown";

    try {
        print("getting adpDetails");
//        var adpDetails = getAdapterDetails(context, adp);
//
//        print("adpDetails:" + adpDetails);
//
//        if (adpDetails) {
//            adpState = adpDetails['state'];
//        }
    } catch (e) {
      // No specified type, handles all
      print('Couldnt get adapter details: $e');
    }
      
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Text(
            name,
            style: new TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            )
          ),
          new Text(
              adpState,
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.blue,
              )
          )
        ]),
        new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
//            new IconButton(
//              icon: const Icon(Icons.play_arrow),
//              tooltip: 'Start',
//              onPressed: () {
////                use the
//              //    url
//              //    jmxUid
//              //    jmxEnv
//              },
//            ),
//            new IconButton(
//              icon: const Icon(Icons.stop),
//              tooltip: 'Stop',
//              onPressed: () {
//              },
//            ),
//            new IconButton(
//              icon: const Icon(Icons.help),
//              tooltip: 'Info',
//              onPressed: () {
//              },
//            ),
          ]),
        ]),
      ],
    );

  }

  var adpList;

  getAdapterList(BuildContext context) {
    adpList = [];
    adpList = adapterList;

    List adpRows = [];
    for (var adp in adpList) {
      adpRows.add(getAdapterRow(adp));
    }
    return adpRows;
  }

  // table showing registered adapters with state
  Widget getUiInstances(BuildContext context) {
    Widget uiListSection = new Container(
      child: new Column(
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getAdapterList(context),
          ),
        ],
      ),
    );
    return uiListSection;
  }

  // home page options, add, refresh, etc
  Widget getHomeOptions(BuildContext context) {
    Widget uiListSection = new Container(
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/addUiInstance');
                },
                child: new Text('Add'),
              ),
              new SizedBox(width: 10.0),
              new RaisedButton(
                onPressed: () {
                  setState(() {
                    adapterList = [];
                  });
                },
                child: new Text('Clear'),
              ),
            ],
          ),
        ],
      ),
    );
    return uiListSection;
  }

  @override
  Widget build(BuildContext context) {
    print("checking objects");
    print("adapterList object: ${adapterList}");
    print("adpList object: ${adpList}");

    Widget home = new Scaffold(
      body: new Center(
        child: new Column(
          children: <Widget>[
            getTitleSection(context),
            getUiInstances(context),
            getHomeOptions(context),
          ],
        ),
      ),
    );

    return new MaterialApp(
      title: 'Interlok Mobile',
      color: Colors.blue,
      home: home,
    );
  }
}


// ********************************************************************
//
// These are common methods
//
// ********************************************************************
Widget getTitleSection(BuildContext context) {
  var spacer = new SizedBox(height: 32.0);
  Widget titleSection = new Container(
    decoration: new BoxDecoration(color: Colors.black),
    child: new Column(
      children: <Widget>[
        spacer,
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Image.asset(
              'images/logo-48sq.png',
              width: 48.0,
              height: 48.0,
              fit: BoxFit.cover,
            ),
            new SizedBox(width: 10.0),
            new Text(
              'Interlok UI',
              style: new TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text(
              'Welcome to the Interlok UI Mobile Companion',
              style: new TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            )
          ],
        ),
        spacer,
      ],
    ),
  );
  return titleSection;
}
