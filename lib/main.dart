import 'package:flutter/material.dart';

void main() {
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

// class MainPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         child: Column(
//           children: [
//             // First block
//             Expanded(
//               child: DefaultTextStyle(
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily,
//                 ),
//                 child: Container(
//                   color: Color(0xFF800000), // Burgundy color
//                   child: Stack(
//                     children: [
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.info,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             // Add your info icon tap logic here
//                           },
//                         ),
//                       ),
//                       Center(
//                         child: Text('Connecting Athletes'),
//                       ),
//                       Positioned(
//                         top: 16.0,
//                         right: 16.0,
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.info,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             // Add your info icon tap logic here
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             // Second block
//             Container(
//               height: 400.0,
//               color: Colors.white,
//               child: Image.asset(
//                 'assets/main_page_bball.png', // Replace with your actual image file name
//                 fit: BoxFit.cover,
//               ),
//             ),
//             // Third block
//             Expanded(
//               child: Container(
//                 color: Color(0xFF800000), // Burgundy color
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: 50.0, // Adjust the height as needed
//                       color: Color(0xFF800000), // Burgundy color
//                       child: Center(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => SearchTeamsPage(),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFF6A1B9A), // Slightly darker purple
//                           ),
//                           child: Text(
//                             'Search for teams!',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});

  @override
  State<MainNavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<MainNavigationBar> {
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

      body: <Widget>[
        Column(     /// Home page
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Add your info icon tap logic here
                          },
                        ),
                      ),
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
                            // Add your info icon tap logic here
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
                      height: 50.0, // Adjust the height as needed
                      color: theme.colorScheme.tertiary, // Burgundy color
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchTeamsPage(),
                              ),
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
        ),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}


class SearchTeamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            // First block
            Expanded(
              child: Container(
                color: Color(0xFF800000), // Burgundy color
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
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
                        'Find your teams',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
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
                  // Third block - Four purplish white background text frames
                  Positioned(
                    top: 30.0, // Adjust the top position based on your design
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
                          Text(
                            'What sport are you interested in',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 130.0, // Adjust the top position based on your design
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
                          Text(
                            'Where do you want to meet',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
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
                          Text(
                            'When are you available',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 330.0, // Adjust the top position based on your design
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
                          Text(
                            'For how long',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
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
                color: Color(0xFF800000), // Burgundy color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50.0, // Adjust the height as needed
                      color: Color(0xFF800000), // Burgundy color
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TeamsFoundPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF6A1B9A), // Slightly darker purple
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
                    Container(
                      height: 50.0, // Adjust the height as needed
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Add your create team logic here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateTeamPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF6A1B9A), // Slightly darker purple
                            ),
                            child: Icon(
                              Icons.create,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.home),
                            onPressed: () {
                              // Add your home logic here
                              Navigator.popUntil(
                                context,
                                ModalRoute.withName('/'),
                              );
                            },
                          ),
                          Stack(
                            children: [
                              IconButton(
                                icon: Icon(Icons.notifications),
                                onPressed: () {
                                  // Add your notifications logic here
                                },
                              ),
                              Positioned(
                                top: 5.0,
                                right: 5.0,
                                child: CircleAvatar(
                                  radius: 8.0,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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








class CreateTeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            // First block
            Expanded(
              child: Container(
                color: Color(0xFF800000), // Burgundy color
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
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
                          fontWeight: FontWeight.bold,
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
                              hintText: 'Enter sport',
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
                              hintText: 'Enter region',
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
                              hintText: 'Enter time',
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
                              hintText: 'Enter duration',
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
                color: Color(0xFF800000), // Burgundy color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50.0, // Adjust the height as needed
                      color: Color(0xFF800000), // Burgundy color
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchTeamsPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF6A1B9A), // Slightly darker purple
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
                    Container(
                      height: 50.0, // Adjust the height as needed
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Add your create team logic here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateTeamPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF6A1B9A), // Slightly darker purple
                            ),
                            child: Icon(
                              Icons.create,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.home),
                            onPressed: () {
                              // Add your home logic here
                              Navigator.popUntil(
                                context,
                                ModalRoute.withName('/'),
                              );
                            },
                          ),
                          Stack(
                            children: [
                              IconButton(
                                icon: Icon(Icons.notifications),
                                onPressed: () {
                                  // Add your notifications logic here
                                },
                              ),
                              Positioned(
                                top: 5.0,
                                right: 5.0,
                                child: CircleAvatar(
                                  radius: 8.0,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
  @override
  _TeamsFoundPageState createState() => _TeamsFoundPageState();
}

class _TeamsFoundPageState extends State<TeamsFoundPage> {
  bool isOptionSelected1 = false;
  bool isOptionSelected2 = false;
  bool isOptionSelected3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            // First block
            Expanded(
              child: Container(
                color: Color(0xFF800000), // Burgundy color
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
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
                        'Teams Found',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
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
                        buildOptionBlock(context, 'Team 1', 'Sport', 'Region', 'Time', 'Duration', isOptionSelected1),
                        SizedBox(height: 10.0), // Add a little gap between blocks
                        buildOptionBlock(context, 'Team 2', 'Sport', 'Region', 'Time', 'Duration', isOptionSelected2),
                        SizedBox(height: 10.0), // Add a little gap between blocks
                        buildOptionBlock(context, 'Team 3', 'Sport', 'Region', 'Time', 'Duration', isOptionSelected3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Third block
            Expanded(
              child: Container(
                color: Color(0xFF800000), // Burgundy color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50.0, // Adjust the height as needed
                      color: Color(0xFF800000), // Burgundy color
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchTeamsPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF6A1B9A), // Slightly darker purple
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
                    Container(
                      height: 50.0, // Adjust the height as needed
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Add your create team logic here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateTeamPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF6A1B9A), // Slightly darker purple
                            ),
                            child: Icon(
                              Icons.create,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.home),
                            onPressed: () {
                              // Add your home logic here
                              Navigator.popUntil(
                                context,
                                ModalRoute.withName('/'),
                              );
                            },
                          ),
                          Stack(
                            children: [
                              IconButton(
                                icon: Icon(Icons.notifications),
                                onPressed: () {
                                  // Add your notifications logic here
                                },
                              ),
                              Positioned(
                                top: 5.0,
                                right: 5.0,
                                child: CircleAvatar(
                                  radius: 8.0,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
















