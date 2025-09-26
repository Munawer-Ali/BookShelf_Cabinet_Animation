import 'package:flutter/material.dart';
import 'widgets/book_shelf_widget.dart';
import 'widgets/animated_tab_selector.dart';
import 'utils/elastic_curve.dart';

// Define the second color as a constant
const Color secondaryColor = Color(0xFF1d1d1d);
const Color thirdColor = Color(0xff252525);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookshelf Cabinet Animation',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF111111),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF111111),
          brightness: Brightness.dark,
          background: const Color(0xFF111111),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MyHomePage(title: 'Bookshelf Cabinet Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool _isFurnitureExpanded = false;
  bool _isLighteningExpanded = false;
  int _selectedShelves = 0;
  int _selectedLightening = 0;
  int _selectedSize = 0;
  List<bool> woodVisible = [true, true, true];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ 
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding:  EdgeInsets.symmetric(horizontal: _selectedSize == 0? 25 : _selectedSize == 2  ? 70 :0
              ,vertical: 30,),
              child: Column(
                children: [
                  BookShelfWidget(woodVisible: woodVisible, lighteningVisible: _selectedLightening == 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Image.asset('assets/foot.png'),
                  ),
                 ],
              ),
            )),
         
         
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                //Furniture
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFurnitureExpanded = !_isFurnitureExpanded;
                      _isLighteningExpanded = !_isFurnitureExpanded;

                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1500),
                    curve: const CustomElasticOutCurve(),
                    width: double.infinity,
                    height: _isFurnitureExpanded ? 300 : 70,
              
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Make your furniture",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // Custom plus icon with horizontal and vertical containers
                              SizedBox(
                                width: 28,
                                height: 28,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Horizontal line
                                    Container(
                                      width: 20,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(1.5),
                                      ),
                                    ),
                                    // Vertical line
                                    AnimatedRotation(
                                      turns: _isFurnitureExpanded ? 0.25 : 0.0,
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      child: Container(
                                        width: 3,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(1.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            
                            SizedBox(height: 30),
                           //Shelves
                            Text(" Shelves", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                            SizedBox(height: 15),
                                      
                            AnimatedTabSelector(
                          labels: const ['One', 'Two', 'Three'],
                          selectedIndex: _selectedShelves,
                          onTabSelected: (index) {
                            setState(() {
                              _selectedShelves = index;
                              if(index == 0) {
                                woodVisible[0] = true;
                                woodVisible[1] = false;
                                woodVisible[2] = false;
                              } else if(index == 1) {
                                woodVisible[0] = true;
                                woodVisible[1] = false;
                                woodVisible[2] = true;
                              } else if(index == 2) {
                                woodVisible[0] = true;
                                woodVisible[1] = true;
                                woodVisible[2] = true;
                              }
                            });
                          },
                          backgroundColor: thirdColor,
                          indicatorColor: Colors.white,
                          selectedTextColor: secondaryColor,
                          unselectedTextColor: Colors.white,
                          height: 44,
                          borderRadius: 8,
                          duration: const Duration(milliseconds: 1500),
                          curve: const CustomElasticOutCurve(),
                        ),
                                      
                           
                            SizedBox(height: 30),
                           //Size
                            Text(" Size", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                            SizedBox(height: 15),
                                      
                            AnimatedTabSelector(
                          labels: const ['Square', 'Wide', 'Tall'],
                          selectedIndex: _selectedSize,
                          onTabSelected: (index) {

                             List<bool> oldwoodVisible = woodVisible;
                             woodVisible = [
                                false,
                                false,
                                false,
                                  ];

                            setState(() {
                            });

                            Future.delayed(const Duration(milliseconds: 600), () {
                              _selectedSize = index;
                              setState(() {
                              });
                            });
                          
                             Future.delayed(const Duration(milliseconds: 1200), () {
                              woodVisible = oldwoodVisible;
                              setState(() {
                              });
                             });

                          },
                          backgroundColor: thirdColor,
                          indicatorColor: Colors.white,
                          selectedTextColor: secondaryColor,
                          unselectedTextColor: Colors.white,
                          height: 44,
                          borderRadius: 8,
                          duration: const Duration(milliseconds: 1500),
                          curve: const CustomElasticOutCurve(),
                        ),
                                      
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                //lightening
                    GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLighteningExpanded = !_isLighteningExpanded;
                      _isFurnitureExpanded = !_isLighteningExpanded;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1500),
                    curve: const CustomElasticOutCurve(),
                    width: double.infinity,
                    height: _isLighteningExpanded ? 190 : 70,
              
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Choose Lightening",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // Custom plus icon with horizontal and vertical containers
                              SizedBox(
                                width: 28,
                                height: 28,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Horizontal line
                                    Container(
                                      width: 20,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(1.5),
                                      ),
                                    ),
                                    // Vertical line
                                    AnimatedRotation(
                                      turns: _isLighteningExpanded ? 0.25 : 0.0,
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      child: Container(
                                        width: 3,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(1.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            
                            SizedBox(height: 30),
                           //Shelves
                            Text(" Lightening", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                            SizedBox(height: 15),
                                      
                            AnimatedTabSelector(
                          labels: const ['None', 'Bulb', 'Strip'],
                          selectedIndex: _selectedLightening,
                          onTabSelected: (index) {
                            setState(() {
                              _selectedLightening = index;
                            });
                          },
                          backgroundColor: thirdColor,
                          indicatorColor: Colors.white,
                          selectedTextColor: secondaryColor,
                          unselectedTextColor: Colors.white,
                          height: 44,
                          borderRadius: 8,
                          duration: const Duration(milliseconds: 1500),
                          curve: const CustomElasticOutCurve(),
                        ),
                                
                        ],
                      ),
                    ),
                  ),
                ),
                        
                ],
                        ),
            ),),
      ],
      ),
    
    );
  }
}
