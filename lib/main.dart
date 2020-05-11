import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:call_number/call_number.dart';
import 'package:sms_maintained/sms.dart';

void main() => runApp(MyApp());

class Section {

  String _title;
  List<Task> _tasks;

  Section(String title)
  {
    this._title = title;
    this._tasks = new List();
  }

  String get title => _title;

  void addTask(Task task) {
    this._tasks.add(task);
  }

  List<Container> getTasks ()
  {
    List<Container> displayableTasks = new List();
    this._tasks.forEach((task) => displayableTasks.add(task.buildTask()));
    return displayableTasks;
  }

  Column getSection()
  {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                this._title.toUpperCase(),
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: this.getTasks(),
        ),
      ],
    );
  }
}

class Task {

  String _workTitle;
  String _years;
  String _state;
  String _sign;

  Task(this._workTitle, this._years, this._state, this._sign);

  String get title => _workTitle;
  String get years => _years;
  String get state => _state;
  String get sign => _sign;

  Container buildTask() { //Get Container of one task
    return Container(
      padding: const EdgeInsets.all(16),
      child: Hero(
        tag: _workTitle,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      this._workTitle,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    child: Text(
                      this._sign,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      this._state,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 6, left: 4),
              child: Text(
                this._years,
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _CallNumberWidgetState extends State<CallNumberWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return IconButton(
      icon: Icon(Icons.call),
      iconSize: 50,
      color: Colors.blue,
      onPressed: _startCall,
    );
  }
  
  void _startCall() async
  {
    await new CallNumber().callNumber('+33624446270');
  }
}

class CallNumberWidget extends StatefulWidget
{
  @override
  _CallNumberWidgetState createState() => _CallNumberWidgetState();
}

class _SendSmsWidgetState extends State<SendSmsWidget>
{
  @override
  Widget build(BuildContext context) {

    return IconButton(
      icon: Icon(Icons.message),
      iconSize: 50,
      color: Colors.blue,
      onPressed: _sendSms,
    );

  }

  void _sendSms()
  {
    SmsSender sms = new SmsSender();
    sms.sendSms(new SmsMessage('+33624446270', 'Bonjour !'));
  }
}

class SendSmsWidget extends StatefulWidget
{
  @override
  _SendSmsWidgetState createState() => _SendSmsWidgetState();
}

class MyApp extends StatelessWidget {

  Section _formations, _experiences;

  final Widget photo = Container(
    margin: const EdgeInsets.symmetric(
      vertical: 20,
    ),
    child: Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Image.asset(
          'images/lorenzo.jpg',
          height: 200,
        ),
      ),
    ),
  );

  final Widget buttons =  Container(
    padding: const EdgeInsets.symmetric(
      vertical: 4,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CallNumberWidget(),
            ],
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SendSmsWidget(),
            ]
        ),
      ],
    ),
  );
  
  @override
  Widget build(BuildContext context) {

    this._formations = new Section("Formations");
    this._experiences = new Section("Expérience");

    this._formations.addTask(Task("BTS Systèmes numériques option informatique et réseau", "2017-2019", "Laval (53)", "Immaculée Conception"));
    this._formations.addTask(Task("Fondamentaux du leadership de niveau I", "Février 2019", "Guyancourt (79)", "McDonald's France"));
    this._formations.addTask(Task("Baccalauréat technologique (STI2D) option SIN", "2015-2017", "Alençon (61)", "Lycée ALAIN"));

    this._experiences.addTask(Task("Responsable de zone (Manager)", "2018-2019", "Arçonnay (72)", "McDonald's"));
    this._experiences.addTask(Task("Equipier polyvalent", "2017-2018", "Arçonnay (72)", "McDonald's"));
    this._experiences.addTask(Task("Développeur Front-End", "juin 2018", "La Ferriere-Bochard (61)", "Exploitation des sources ROXANE"));

    return MaterialApp(
      title: 'CV de Lorenzo LAGOUTTE',
      home: Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text(
                  "Lorenzo LAGOUTTE"
                ),
            ),
          ),
          body: ListView(
            children: [
              photo,
              buttons,
              Divider(
                thickness: 5,
              ),
              this._formations.getSection(),
              Divider(
                thickness: 5,
              ),
              this._experiences.getSection(),
            ],
          ),
      ),
    );

  }

  /*final Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
          children: [
            Expanded(

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Laura COUTELLE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Text(
                      '51 avenue Quakenbruck, Courteille, FRANCE',
                      style: TextStyle(
                        color: Colors.purple[400],
                      ),
                    ),
                  ]
              ),
            ),
            FavoriteWidget(),
          ]
      )
  );

  final Widget description = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'Bonjour, je m\'appele Laura et je suis magnifique,'
          ' mais aussi très relou parfois.',
      softWrap: true,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 20,
        color: Colors.purple[400],
      ),
    ),
  );

  @override
  Widget build(BuildContext context)
  {

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.purple, Icons.call, "Appeler"),
          _buildButtonColumn(Colors.purple, Icons.near_me, "Localiser"),
        ],
      ),
    );

    return MaterialApp(
      title: 'Layout tutorial',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Laura je t\'aime'),
            backgroundColor: Colors.purple,
          ),
          body: ListView(
              children: [
                Image.asset(
                    'images/laura.jpg',
                    width: 400,
                    height: 250,
                    fit: BoxFit.cover
                ),
                titleSection,
                buttonSection,
                description,
              ]
          )
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
            ),
          ),
        ),
      ],
    );
  } */
}

/*class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;

  void _toggleFavorite() {
    setState(() {
      _isFavorited ? _isFavorited = false : _isFavorited = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border)),
            color: Colors.red,
            onPressed: _toggleFavorite,
          ),
        ),
      ],
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}*/
