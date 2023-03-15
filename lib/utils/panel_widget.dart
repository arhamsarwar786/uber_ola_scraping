import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_scrape/fare_screen.dart';
import 'package:uber_scrape/search_handler.dart';
import 'package:uber_scrape/utils/gloablState.dart';
import 'package:uber_scrape/utils/utils.dart';
import 'package:uber_scrape/widgets.dart';

final pickUpController = TextEditingController();
final destinationController = TextEditingController();

Widget buildDragHandle() => Center(
      child: Container(
        height: 5,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

// This page shows a Google Map plugin with all stations (HvD and Total). The markers are pulled from a Firebase database.

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        buildDragHandle(),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          color: Colors.white,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  handlePressButton(context, 'pickUp');
                  // Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchScreen('Pick Up') ));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(7, 10, 15, 0),
                  child: TextField(
                    style: const TextStyle(fontSize: 16),
                    controller: pickUpController,
                    enabled: false,
                    decoration: const InputDecoration(
                        icon: Icon(
                          Icons.accessibility_new,
                          color: Colors.black,
                        ),
                        hintText: "Pick Up",
                        border: InputBorder.none),
                  ),
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: SizedBox(
                      height: 20,
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 2.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.83,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchScreen('Destination') ));
                  handlePressButton(context, 'destination');
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(7, 0, 15, 0),
                  child: TextField(
                    style: const TextStyle(fontSize: 16),
                    controller: destinationController,
                    enabled: false,
                    decoration: const InputDecoration(
                        icon: Icon(
                          Icons.fmd_good_sharp,
                          color: Colors.red,
                        ),
                        hintText: "Destination",
                        border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Container(
                        width: 70,
                        height: 45,
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                          image: const DecorationImage(
                            image: AssetImage('assets/images/bike.png'),
                            fit: BoxFit.fill,
                          ),
                          // color: Colors.purple,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: .5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.05,
                          ),
                          borderRadius: BorderRadius.circular(17.5),
                        ),
                      ),
                      onTap: () {
                        print("Container is Tapped");
                      },
                    ),
                    InkWell(
                      child: Container(
                        width: 70,
                        height: 45,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/auto_rikshaw.png'),
                            fit: BoxFit.fill,
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: .5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.05,
                          ),
                          borderRadius: BorderRadius.circular(17.5),
                        ),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Container(
                        width: 70,
                        height: 45,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/small_car.jpg'),
                            fit: BoxFit.fill,
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: .5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.05,
                          ),
                          borderRadius: BorderRadius.circular(17.5),
                        ),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Container(
                        width: 70,
                        height: 45,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/big_car.jpg'),
                            fit: BoxFit.fill,
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: .5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.05,
                          ),
                          borderRadius: BorderRadius.circular(17.5),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 0, 7.5),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/ola_icon_full.png',
                                  ),
                                  radius: 15,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                child: Text(
                                  "Ola",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 190,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 218, 210, 231),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    "Login to see prices ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color:
                                            Color.fromARGB(255, 137, 92, 146)),
                                  ),
                                  const Icon(
                                    Icons.logout_rounded,
                                    size: 18,
                                    color: Color.fromARGB(255, 137, 92, 146),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 0, 7.5),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/uber_icon_full.png',
                                  ),
                                  radius: 17,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(11, 10, 0, 0),
                                child: Text(
                                  "Uber",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 190,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 218, 210, 231),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    "Login to see prices ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color:
                                            Color.fromARGB(255, 137, 92, 146)),
                                  ),
                                  const Icon(
                                    Icons.logout_rounded,
                                    size: 18,
                                    color: Color.fromARGB(255, 137, 92, 146),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 15, 0, 0),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/rapido.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(11, 10, 0, 0),
                                child: Text(
                                  "Rapido",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 190,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 218, 210, 231),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    "Login to see prices ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color:
                                            Color.fromARGB(255, 137, 92, 146)),
                                  ),
                                  const Icon(
                                    Icons.logout_rounded,
                                    size: 18,
                                    color: Color.fromARGB(255, 137, 92, 146),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 32.5,
                thickness: 0.5,
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 75,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bike.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: const Text("No options available for now..."),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
