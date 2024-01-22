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


void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final database = openDatabase(
  //   join(await getDatabasesPath(), 'sports.db'),
  //   onCreate: (db, version) {
  //     return db.execute(
  //       'CREATE TABLE sports(game_id INTEGER PRIMARY KEY, sport TEXT, region TEXT, time TEXT, duration INTEGER)',
  //     );
  //   },
  //   version: 1,
  // );

  // // Define a function that inserts dogs into the database
  // Future<void> insertSport(List<dynamic> sport) async {
  //   final db = await database;

  //   var sportMap = {
  //     'game_id': sport[0],
  //     'sport': sport[1],
  //     'region': sport[2],
  //     'time': sport[3],
  //     'duration': sport[4]
  //   };

  //   await db.insert(
  //     'sports',
  //     sportMap,
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  // Future<List<dynamic>> getSports() async {
  //   // Get a reference to the database.
  //   final db = await database;

  //   // Query the table for all The Dogs.
  //   final List<Map<String, dynamic>> maps = await db.query('sports');

  //   // Convert the List<Map<String, dynamic> into a List<Dog>.
  //   return [
  //     maps[0]['game_id'] as int,
  //     maps[1]['sport'] as String,
  //     maps[2]['region'] as String,
  //     maps[3]['time'] as String,
  //     maps[4]['duration'] as int
  //   ];
  // }

  // await insertSport([1, 'Volleyball', 'Zografou', '2024-01-22 12:30:00', 60]);
  // print(await getSports());

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
                  // Commenting out the info icon at the top left
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: IconButton(
                  //     icon: Icon(
                  //       Icons.info,
                  //       color: Colors.white,
                  //     ),
                  //     onPressed: () {
                  //       // Add your info icon tap logic here
                  //     },
                  //   ),
                  // ),
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
  var inputData = ['', '', '', ''];

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
                  // Commenting out the info icon at the top left
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: IconButton(
                  //     icon: Icon(
                  //       Icons.info,
                  //       color: Colors.white,
                  //     ),
                  //     onPressed: () {
                  //       // Add your info icon tap logic here
                  //     },
                  //   ),
                  // ),
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
                  // Positioned(
                  //   top: 1.0,
                  //   right: 16.0,
                  //   child: SafeArea(child:
                  //     IconButton(
                  //       icon: Icon(
                  //         Icons.info,
                  //         color: Colors.white,
                  //       ),
                  //       onPressed: () {
                  //         // Navigating to the InfoPage when the top right info icon is pressed
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => InfoPage(),
                  //           ),
                  //         );
                  //       },
                  //   ),)
                  // ),
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
                              inputData[3] = value;
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
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
  final List<String> params;
  const TeamsFoundPage({super.key, required this.params});
  @override
  _TeamsFoundPageState createState() => _TeamsFoundPageState();
}

class _TeamsFoundPageState extends State<TeamsFoundPage> {
  bool isOptionSelected1 = false;
  bool isOptionSelected2 = false;
  bool isOptionSelected3 = false;

  // Future fetchData() async {
  //   try {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     final database = openDatabase(
  //       join(await getDatabasesPath(), 'sports.db'),
  //       onCreate: (db, version) {
  //         return db.execute(
  //           'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
  //         );
  //       },
  //     );


  //     final conn = await MySqlConnection.connect(settings);
  //     var results = await conn.query(
  //       'SELECT * FROM Entries WHERE sport = ? AND region = ? AND time = ? AND duration = ?', widget.params);
  
  //     for (var row in results) {
  //       print('Sport: ${row[1]}, Region: ${row[2]} Time: ${row[3]} Duration: ${row[4]}');
  //     }

  //     await conn.close();
  //     setState(() {
  //       data = results;
  //     });
  //   } catch (e) {
  //       print(e);
  //   }
  // }

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
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: IconButton(
                    //     icon: Icon(
                    //       Icons.arrow_back,
                    //       color: Colors.white,
                    //     ),
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //   ),
                    // ),
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
                      children: [
                        buildOptionBlock(context, 'Team 1', 'Sport: Basketball', 'Region: Zografou, Athens', 'Time: 18:00 every day', 'Duration: 1 hour', isOptionSelected1),
                        SizedBox(height: 10.0), // Add a little gap between blocks
                        buildOptionBlock(context, 'Team 2', 'Sport: Running', 'Region: Glyfada, Athens', 'Time: 18:00, 5/12/24', 'Duration: 2 hours', isOptionSelected2),
                        SizedBox(height: 10.0), // Add a little gap between blocks
                        buildOptionBlock(context, 'Team 3', 'Sport: Volleyball', 'Region: Palaio Faliro, Athens', 'Time: 19:00 every Friday', 'Duration: 1,5 hours', isOptionSelected3),
                      ],
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
                    // Container(
                    //   height: 50.0, // Adjust the height as needed
                    //   color: Colors.white,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Add your create team logic here
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => CreateTeamPage(),
                    //             ),
                    //           );
                    //         },
                    //         style: ElevatedButton.styleFrom(
                    //           primary: Color(0xFF6A1B9A), // Slightly darker purple
                    //         ),
                    //         child: Icon(
                    //           Icons.create,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       IconButton(
                    //         icon: Icon(Icons.home),
                    //         onPressed: () {
                    //           // Add your home logic here
                    //           Navigator.popUntil(
                    //             context,
                    //             ModalRoute.withName('/'),
                    //           );
                    //         },
                    //       ),
                    //       Stack(
                    //         children: [
                    //           IconButton(
                    //             icon: Icon(Icons.notifications),
                    //             onPressed: () {
                    //               Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => NotificationsPage(),
                    //           ),
                    //         );
                    //               // Add your notifications logic here
                    //             },
                    //           ),
                    //           Positioned(
                    //             top: 5.0,
                    //             right: 5.0,
                    //             child: CircleAvatar(
                    //               radius: 8.0,
                    //               backgroundColor: Colors.red,
                    //               child: Text(
                    //                 '3',
                    //                 style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 10.0,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOptionBlock(BuildContext context, String team, String sport, String region, String time, String duration, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (team == 'Team 1') {
            isOptionSelected1 = !isOptionSelected1;
          } else if (team == 'Team 2') {
            isOptionSelected2 = !isOptionSelected2;
          } else if (team == 'Team 3') {
            isOptionSelected3 = !isOptionSelected3;
          }
        });
      },
      child: Row(
        children: [
          // Option Circle
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black), // Black circle outline
            ),
            child: Center(
              child: Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.black : Colors.transparent, // Filled black circle
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
                team,
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
  }
}



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
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //       height: 50.0, // Adjust the height as needed
                //       color: Color(0xFF800000), // Burgundy color
                //     ),
                //     Container(
                //       height: 50.0, // Adjust the height as needed
                //       color: Colors.white,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           ElevatedButton(
                //             onPressed: () {
                //               // Add your create team logic here
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                   builder: (context) => CreateTeamPage(),
                //                 ),
                //               );
                //             },
                //             style: ElevatedButton.styleFrom(
                //               primary: Color(0xFF6A1B9A), // Slightly darker purple
                //             ),
                //             child: Icon(
                //               Icons.create,
                //               color: Colors.white,
                //             ),
                //           ),
                //           IconButton(
                //             icon: Icon(Icons.home),
                //             onPressed: () {
                //               // Add your home logic here
                //               Navigator.popUntil(
                //                 context,
                //                 ModalRoute.withName('/'),
                //               );
                //             },
                //           ),
                //           Stack(
                //             children: [
                //               IconButton(
                //                 icon: Icon(Icons.notifications),
                //                 onPressed: () {
                //                   // Add your notifications logic here
                //                 },
                //               ),
                //               Positioned(
                //                 top: 5.0,
                //                 right: 5.0,
                //                 child: CircleAvatar(
                //                   radius: 8.0,
                //                   backgroundColor: Colors.red,
                //                   child: Text(
                //                     '3',
                //                     style: TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 10.0,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


















