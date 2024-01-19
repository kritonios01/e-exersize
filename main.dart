import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              // First block
              Container(
                height: (MediaQuery.of(context).size.height - 400) / 4,
                color: Colors.red[900], // Use a deep red color
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'Connecting Athletes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
              // Second block
              Container(
                height: 400.0,
                color: Colors.white,
                child: Image.asset(
                  'assets/main_page_bball.png', // Replace with your actual image file name
                  fit: BoxFit.cover,
                ),
              ),
              // Third block
              Container(
                height: (MediaQuery.of(context).size.height - 400) / 4,
                color: Colors.red[900], // Use a deep red color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 50.0, // Adjust the height as needed
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.create),
                            onPressed: () {
                              // Add your create team logic here
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.home),
                            onPressed: () {
                              // Add your home logic here
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
                    Container(
                      height: (MediaQuery.of(context).size.height - 400) / 4 - 50.0, // Adjust the height as needed
                      color: Colors.purple, // Use your desired color here
                      child: Center(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


