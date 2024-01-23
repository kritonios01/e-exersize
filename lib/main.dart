import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

// var settings = ConnectionSettings(
//   host: '10.1.1.1', 
//   port: 3306,
//   user: 'user1',
//   password: '',
//   db: 'e_exersize'
// );

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  final String tableName = 'sports';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // Open the database (create if it doesn't exist)
    _database = await openDatabase(
      'e_exersize.db',
      version: 1,
      onCreate: (Database db, int version) async {
        // Create your table if it doesn't exist
        await db.execute('''
          CREATE TABLE $tableName (
            game_id INTEGER PRIMARY KEY,
            sport TEXT,
            region TEXT,
            time TEXT,
            duration INTEGER
          )
        ''');
      },
    );

    return _database!;
  }

  Future<int> deleteAllData() async {
    final db = await database;
    return db.delete(tableName);
  }


  // Define a function that inserts dogs into the database
  Future<int> insertData(Map<String, dynamic> data) async {
    final db = await database;
    return db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Query method with WHERE clause                  "name = ?"    ['John']
  Future<List<Map<String, dynamic>>> queryData(String whereClause, List<dynamic> whereArgs) async {
    final db = await database;
    return db.query(tableName, where: whereClause, whereArgs: whereArgs);
  }
}

class SportData {
  final int id;
  final String sport;
  final String region;
  final String time;
  final int duration;


  SportData({required this.id, required this.sport, required this.region, required this.time, required this.duration});

  // Factory method to create a YourData object from a map
  factory SportData.fromMap(Map<String, dynamic> map) {
    return SportData(
      id: map['game_id'],
      sport: map['sport'],
      region: map['region'],
      time: map['time'],
      duration: map['duration']
    );
  }
}






void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DatabaseHelper dbHelper = DatabaseHelper();


  int t = await dbHelper.deleteAllData();
  print('Deleted: $t');

  final List<Map<String, dynamic>> sports = [
    {'sport': 'Volleyball', 'region': 'Zografou', 'time': '2024-01-22 12:30:00', 'duration': 60},
    {'sport': 'Volleyball', 'region': 'Zografou', 'time': '2024-01-22 12:30:00', 'duration': 60},
    {'sport': 'Basketball', 'region': 'Nea Erythraia', 'time': '2024-02-24 17:30:00', 'duration': 90},
    {'sport': 'Football', 'region': 'Peristeri', 'time': '2024-01-26 20:30:00', 'duration': 120},
    {'sport': 'Football', 'region': 'Peristeri', 'time': '2024-01-26 20:30:00', 'duration': 120},
    {'sport': 'Football', 'region': 'Peristeri', 'time': '2024-01-26 20:30:00', 'duration': 120},
    {'sport': 'Ice Skating', 'region': 'Aigaleo', 'time': '2024-01-30 18:00:00', 'duration': 45},
    {'sport': 'Football', 'region': 'Kifisia', 'time': '2024-03-02 17:00:00', 'duration': 90},
    {'sport': 'Football', 'region': 'Kifisia', 'time': '2024-03-02 17:00:00', 'duration': 90},
    {'sport': 'Basketball', 'region': 'Zografou', 'time': '2024-02-02 10:00:00', 'duration': 120},
    {'sport': 'Basketball', 'region': 'Zografou', 'time': '2024-02-02 10:00:00', 'duration': 120},
    {'sport': 'Tennis', 'region': 'Petroupoli', 'time': '2024-02-03 15:30:00', 'duration': 60},
    {'sport': 'Cycling', 'region': 'Piraeus', 'time': '2024-01-31 16:30:00', 'duration': 180},
    {'sport': 'Cycling', 'region': 'Piraeus', 'time': '2024-01-31 16:30:00', 'duration': 180},
    {'sport': 'Cycling', 'region': 'Piraeus', 'time': '2024-01-31 16:30:00', 'duration': 180},
    {'sport': 'Sailing', 'region': 'Alimos', 'time': '2024-03-10 13:00:00', 'duration': 90},
    {'sport': 'Basketball', 'region': 'Zografou', 'time': '2024-01-25 18:00:00', 'duration': 90},
    {'sport': 'Swimming', 'region': 'Voula', 'time': '2024-03-25 09:00:00', 'duration': 60},
    {'sport': 'Football', 'region': 'Nikaia', 'time': '2024-02-08 14:15:00', 'duration': 120},
    {'sport': 'Ping pong', 'region': 'Zografou', 'time': '2024-01-28 19:30:00', 'duration': 90},
    {'sport': 'Ping pong', 'region': 'Zografou', 'time': '2024-01-28 19:30:00', 'duration': 90},
    {'sport': 'Bowling', 'region': 'Kallithea', 'time': '2024-02-10 17:30:00', 'duration': 60},
    {'sport': 'Volleyball', 'region': 'Chalandri', 'time': '2024-01-30 16:00:00', 'duration': 90},
    {'sport': 'Volleyball', 'region': 'Chalandri', 'time': '2024-01-30 16:00:00', 'duration': 90},
  ];

  int lastId = 0;
  //print('Reached point1!!!!!!!!!!!!!!!');
  // Insert data into the database
  for (var sport in sports) {
    lastId = await dbHelper.insertData(sport);
  }


  
  //print('Reached point2!!!!!!!!!!!!!!!');
  print('Data inserted with last row ID: $lastId');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-Exersize',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainNavigationBar(),
    );
  }
}



class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});

  @override
  State<MainNavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<MainNavigationBar> {
  final List<Widget> appPages = [CreateTeamPage(), HomePage(), NotificationsPage()];
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: theme.colorScheme.surface,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.create),
            icon: Icon(Icons.create_outlined),
            label: 'Create Team',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Badge(child: Icon(Icons.notifications_sharp)),//label: Text('2') -> add this for notification number
            icon: Badge(child: Icon(Icons.notifications_outlined)),
            label: 'Notifications',
          ),
        ],
      ),

      body: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('FirstPage'),
            child: appPages[currentPageIndex],
          ),
        ],
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      )

    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(     /// Home page
      children: [
        Expanded(  // First block
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: theme.textTheme.bodyLarge!.fontFamily,
            ),
            child: Container(
              color: theme.colorScheme.tertiary,    //Color(0xFF800000), // Burgundy color
              child: Stack(
                children: [

                  Center(
                    child: Text('Connecting Athletes', style: TextStyle(fontFamily: 'RhodiumLibre')),
                  ),
                  Positioned(
                    top: 16.0,
                    right: 16.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Navigating to the InfoPage when the top right info icon is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(   // Second block
          height: 400.0,
          color: Colors.white,
          child: Image.asset(
            'assets/main_page_bball.png', // Replace with your actual image file name
            fit: BoxFit.cover,
          ),
        ),
        Expanded(   // Third block
          child: Container(
            color: theme.colorScheme.tertiary, // Burgundy color
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 140.0, // Adjust the height as needed
                  color: theme.colorScheme.tertiary, // Burgundy color
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push( //this changes page with animation, can it be implemented within the current navigationbar??
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SearchTeamsPage(),
                        //   ),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchTeamsPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary //Color(0xFF6A1B9A), // Slightly darker purple
                      ),
                      child: Text(
                        'Search for teams!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}





class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          // First block with back icon
          Container(
            height: 135.0, // Assuming standard toolbar height
            color: theme.colorScheme.tertiary, // Burgundy color
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'e-Exersize',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
                          ),
                        ),
                        SizedBox(height: 8.0), // Adjust the spacing between texts
                        Text(
                          'Version 1.0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Second block with image
          Container(
            height: 420.0,
            color: Colors.white,
            child: Image.asset(
              'assets/main_page_bball.png', // Replace with your actual image file name
              fit: BoxFit.cover,
            ),
          ),
          // Third block (Burgundy background with "NTUA" text)
          Container(
            height: 126.0, // Adjust the height as needed
            color: theme.colorScheme.tertiary, // Burgundy color
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Copyright 2023 © NTUA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0), // Adjust the spacing between texts
                  Text(
                    'For academic purposes only',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}





class SearchTeamsPage extends StatefulWidget {
  const SearchTeamsPage({super.key});

  @override
  State<SearchTeamsPage> createState() => _SearchTeamsPageState();
}

class _SearchTeamsPageState extends State<SearchTeamsPage> {
  List<dynamic> inputData = ['', '', '', 0];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(     /// Home page
      children: [
        Expanded(  // First block
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: theme.textTheme.bodyLarge!.fontFamily,
            ),
            child: Container(
              color: theme.colorScheme.tertiary,    //Color(0xFF800000), // Burgundy color
              child: Stack(
                children: [

                  SafeArea(
                      //alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  
                  Center(
                    child: Text(
                        'Find your team to connect with other athletes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'RhodiumLibre'
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ),

                ],
              ),
            ),
          ),
        ),
        Container(
              height: 400.0,
              color: Colors.white,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/main_page_bball.png', // Replace with your actual image file name
                    fit: BoxFit.cover,
                  ),
                  // Third block - Four purplish white background text frames
                  Positioned(
                    top: 25.0, // Adjust the top position based on your design
                    left: 20.0, // Adjust the left position based on your design
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Grayish white color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width - 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sport',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            onChanged: (value) {
                              inputData[0] = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'What sport are you interested in',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120.0, // Adjust the top position based on your design
                    left: 20.0, // Adjust the left position based on your design
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Grayish white color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width - 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Region',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            onChanged: (value) {
                              inputData[1] = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Where do you want to meet',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 215.0, // Adjust the top position based on your design
                    left: 20.0, // Adjust the left position based on your design
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Grayish white color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width - 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            onChanged: (value) {
                              inputData[2] = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'When are you available',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 310.0, // Adjust the top position based on your design
                    left: 20.0, // Adjust the left position based on your design
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Grayish white color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width - 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Duration',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            onChanged: (value) {
                              inputData[3] = int.parse(value);
                            },
                            decoration: InputDecoration(
                              hintText: 'For how long',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        Expanded(   // Third block
          child: Container(
            color: theme.colorScheme.tertiary, // Burgundy color
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 140.0, // Adjust the height as needed
                  color: theme.colorScheme.tertiary, // Burgundy color
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push( //this changes page with animation, can it be implemented within the current navigationbar??
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SearchTeamsPage(),
                        //   ),
                        // );
                        print('Entered Text: $inputData');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TeamsFoundPage(params: inputData)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary //Color(0xFF6A1B9A), // Slightly darker purple
                      ),
                      child: Text(
                        'Find available teams!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}





class CreateTeamPage extends StatelessWidget {
  List<dynamic> inputData = ['', '', '', 0];

  Future<void> _createTeamAndNavigate(BuildContext context) async {
    final DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper.insertData({
      'sport': inputData[0],
      'region': inputData[1],
      'time': inputData[2],
      'duration': inputData[3]
    });
    //print(n);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            // First block
            Expanded(
              child: Container(
                color: theme.colorScheme.tertiary, // Burgundy color
                child: Stack(
                  children: [
                    SafeArea(
                      //alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        'Create your own team',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'RhodiumLibre'
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Second block
            Container(
              height: 400.0,
              color: Colors.white,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/main_page_bball.png', // Replace with your actual image file name
                    fit: BoxFit.cover,
                  ),
                  // Third block - Four purplish white background text frames
                  Positioned(
                    top: 25.0, // Adjust the top position based on your design
                    left: 20.0, // Adjust the left position based on your design
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Grayish white color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width - 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sport',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFormField(
                            onChanged: (value) {
                              inputData[0] = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'What sport are you interested in',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120.0, // Adjust the top position based on your design
                    left: 20.0, // Adjust the left position based on your design
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Grayish white color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width - 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Region',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFormField(
                            onChanged: (value) {
                              inputData[1] = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Where do you want to meet',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 215.0, // Adjust the top position based on your design
                    left: 20.0, // Adjust the left position based on your design
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Grayish white color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width - 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFormField(
                            onChanged: (value) {
                              inputData[2] = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'When are you available',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 310.0, // Adjust the top position based on your design
                    left: 20.0, // Adjust the left position based on your design
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Grayish white color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width - 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Duration',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFormField(
                            onChanged: (value) {
                              inputData[3] = int.parse(value);
                            },
                            decoration: InputDecoration(
                              hintText: 'For how long',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Fourth block
            Expanded(
              child: Container(
                color: theme.colorScheme.tertiary, // Burgundy color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 80.0, // Adjust the height as needed
                      color: theme.colorScheme.tertiary, // Burgundy color
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            //final DatabaseHelper dbHelper = DatabaseHelper();
                            //await dbHelper.insertData(sport);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => HomePage()),
                            // );
                            _createTeamAndNavigate(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: theme.colorScheme.primary, // Slightly darker purple
                          ),
                          child: Text(
                            'Create team',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}










class TeamsFoundPage extends StatefulWidget {
  final List<dynamic> params;
  const TeamsFoundPage({super.key, required this.params});
  @override
  _TeamsFoundPageState createState() => _TeamsFoundPageState();
}

class _TeamsFoundPageState extends State<TeamsFoundPage> {
  // bool isOptionSelected1 = false;
  // bool isOptionSelected2 = false;
  // bool isOptionSelected3 = false;

  int? selectedTeamId;

  late List<SportData> availableSports; //= [SportData(id: 0, sport: 'Not available', region: 'Not available', time: 'Not available', duration: 0)];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  final DatabaseHelper dbHelper = DatabaseHelper();
  Future<List<SportData>> fetchData() async {

    List<Map<String, dynamic>> results = await dbHelper.queryData(
      'sport = ? AND region = ? AND time = ? AND duration = ?', widget.params);

    availableSports = results.map((map) => SportData.fromMap(map)).toList();

    setState(() {
      
    });
    availableSports.forEach((data) {
      print('ID: ${data.id}, Name: ${data.sport}, Age: ${data.region} ${data.time} ${data.duration}');
    });

    return availableSports;
  }

  @override
  Widget build(BuildContext context) {

    print(availableSports);



    List<Widget> optionBlocks = availableSports.map((SportData row) {
      return Column(
        children: [
          buildOptionBlock(
            context,
            row.id,
            'Sport: ${row.sport}',
            'Region: ${row.region}',
            'Time: ${row.time}',
            'Duration: ${row.duration}',
            selectedTeamId == row.id, // Check if this team is selected
            () {
              setState(() {
                selectedTeamId = row.id; // Update the selected team ID on tap
              });
            },
          ),
          SizedBox(height: 10.0),
        ],
      );
    }).toList();

    
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            // First block
            Expanded(
              child: Container(
                color: theme.colorScheme.tertiary, // Burgundy color
                child: Stack(
                  children: [
                    SafeArea(
                      //alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    Center(
                      child: Text(
                        'We found some teams that match your criteria!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'RhodiumLibre'
                        ),
                        textAlign: TextAlign.center,
                        ),
                      ),
                    
                  ],
                ),
              ),
            ),
            // Second block
            Container(
              height: 400.0,
              color: Colors.white,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  Image.asset(
                    'assets/main_page_bball.png', // Replace with your actual image file name
                    fit: BoxFit.cover,
                  ),
                  // Large Frame
                  Container(
                    color: Colors.grey[200], // Grayish white color
                    width: MediaQuery.of(context).size.width,
                    height: 380.0, // Adjust the height as needed
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: optionBlocks
                    ),
                  ),
                ],
              ),
            ),
            // Third block
            Expanded(
              child: Container(
                color: theme.colorScheme.tertiary, // Burgundy color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 140.0, // Adjust the height as needed
                      color: theme.colorScheme.tertiary, // Burgundy color
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: theme.colorScheme.primary, // Slightly darker purple
                          ),
                          child: Text(
                            'Accept',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


Widget buildOptionBlock(
  BuildContext context,
  int teamId,
  String sport,
  String region,
  String time,
  String duration,
  bool isSelected,
  VoidCallback onTap,
) {
  final ThemeData theme = Theme.of(context);
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        // Option Circle
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: theme.colorScheme.primary)//Colors.black), // Black circle outline
          ),
          child: Center(
            child: Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? theme.colorScheme.primary : Colors.transparent, // Filled black circle
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0), // Add a little gap between circle and text
        // Text Block
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Team ID: $teamId',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sport,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
              ),
            ),
            Text(
              region,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
              ),
            ),
            Text(
              duration,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}}



class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            // First block
            Expanded(
              child: Container(
                color: theme.colorScheme.tertiary, // Burgundy color
                child: Stack(
                  children: [
                    SafeArea(
                      //alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'RhodiumLibre'
                        
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Second block
            Container(
              height: 400.0,
              color: Colors.white,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/main_page_bball.png', // Replace with your actual image file name
                    fit: BoxFit.cover,
                  ),
                  // Third block - Three purplish white background text frames
                  Positioned(
                    top: 30.0, // Adjust the top position based on your design
                    left: 20.0, // Adjust the left position based on your design
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Grayish white color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width - 70.0, // Adjust the width as needed
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // Grayish white color
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width: MediaQuery.of(context).size.width - 160.0, // Adjust the width as needed
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'We found matches!',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Tap to view your teams',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.0), // Adjust the spacing between the containers
                          Image.asset(
                            'assets/pic1.png', // Replace with your right image file name
                            height: 60.0, // Adjust the height as needed
                            width: 60.0, // Adjust the width as needed
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 125.0, // Adjust the top position based on your design
                    left: 20.0, // Adjust the left position based on your design
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Grayish white color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width - 70.0, // Adjust the width as needed
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // Grayish white color
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width: MediaQuery.of(context).size.width - 160.0, // Adjust the width as needed
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Complete your profile',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'We need more data to complete your profile',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.0), // Adjust the spacing between the containers
                          Image.asset(
                            'assets/pic2.png', // Replace with your right image file name
                            height: 60.0, // Adjust the height as needed
                            width: 60.0, // Adjust the width as needed
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 230.0, // Adjust the top position based on your design
                    left: 20.0, // Adjust the left position based on your design
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Grayish white color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width - 70.0, // Adjust the width as needed
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // Grayish white color
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width: MediaQuery.of(context).size.width - 160.0, // Adjust the width as needed
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create your own team!',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Tap the down left button to create your dream team!',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.0), // Adjust the spacing between the containers
                          Image.asset(
                            'assets/pic3.png', // Replace with your right image file name
                            height: 60.0, // Adjust the height as needed
                            width: 60.0, // Adjust the width as needed
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Third block
            Expanded(
              child: Container(
                color: theme.colorScheme.tertiary, // Burgundy color
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}


















