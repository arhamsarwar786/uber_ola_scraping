// ignore_for_file: avoid_print

import 'dart:convert';
import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uber_scrape/fare_model.dart';
import 'package:uber_scrape/model.dart/ola_model.dart';
import 'package:uber_scrape/utils/credentails.dart';

class FareScreen extends StatefulWidget {
  final LatLng? pickUp, destination;
  const FareScreen({super.key, this.pickUp, this.destination});

  @override
  State<FareScreen> createState() => _FareScreenState();
}

class _FareScreenState extends State<FareScreen> {
  @override
  void initState() {
    super.initState();

    fetchFare();
  }

  FareModel? data;
  OlaModel? data1;
  // ignore: prefer_typing_uninitialized_variables
  var data2;
  bool isFound = false;

  fetchFare() async {
    setState(() {
      isFound = true;
    });
    try {
      var res = await http.post(Uri.parse(UBER_URL),
          body: jsonEncode(uberPayload(
              pickUp: widget.pickUp, destination: widget.destination)),
          headers: uberHeader());
      var res1 = await http.get(
          Uri.parse(
              olaURL(pickUp: widget.pickUp, destination: widget.destination)),
          headers: olaHeader());
      // print(res1.body);
      var res2 = await http.get(
          Uri.parse(olaURLFare(
              pickUp: widget.pickUp, destination: widget.destination)),
          headers: olaHeader());
      // ignore: prefer_interpolation_to_compose_strings
      print(res2.body.toString() + "teishjadkas");
      var uberData = jsonDecode(res.body);
      var olaData = jsonDecode(res1.body);
      var olaDataFare = jsonDecode(res2.body);
      if (uberData['data'] != null) {
        data = FareModel.fromJson(uberData);
      }

      if (olaData['error'] == null) {
        print(olaData);
        data1 = OlaModel.fromJson(olaData);
        // print(data1);
      }
      if (olaDataFare['error'] == null) {
        data2 = olaDataFare;
      }

      print(olaData);
      print(olaDataFare);
    } catch (e) {
      print(e);
    }
    setState(() {
      isFound = false;
    });
  }

  olaFareCalculator(id) {
    var fare = "";
    // ignore: prefer_interpolation_to_compose_strings
    print(data2.toString() + "testing");
    if (data2['data']['p2p']['categories'][id] != null) {
      fare = data2['data']['p2p']['categories'][id]['price'];
    }
    return fare;
  }

  fareSpliter(fare) {
    var farePrice = fare.toString().split("â¹");
    print(farePrice);
    if (farePrice.length > 1) {
      // ignore: prefer_interpolation_to_compose_strings
      print(farePrice[1].toString() + "arham here");
      return farePrice[1];
    } else {
      farePrice = farePrice[0].split('PKRÂ');
      return (farePrice.length > 1) ? farePrice[1] : farePrice[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fare Details"),
        centerTitle: true,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     fetchFare();
      //   },
      // ),
      body: isFound
          ? const Center(child: CircularProgressIndicator.adaptive())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Uber Rides",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  data == null
                      ? const Center(
                          child: Text("No Ride Found for UBER"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              data!.data!.products!.tiers![0].products!.length,
                          itemBuilder: (context, index) {
                            Product tier = data!
                                .data!.products!.tiers![0].products![index];

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 10, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  tier.productImageUrl!),
                                              // image: SvgPicture.asset(
                                              //     'assets/images/olacars.svg'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                child: Text(
                                                  "${tier.displayName}",
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                decoration:
                                                    const BoxDecoration(),
                                                child: const Icon(
                                                    Icons.accessible),
                                              ),
                                              Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                child: Text(
                                                  "${tier.capacity}",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                child: const Text(
                                                  "Affordable rides",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                child: Text(
                                                  "in ${tier.etaStringShort}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 25, 0, 0),
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "${tier.currencyCode} ${fareSpliter(tier.fare)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                            //   return Card(
                            //       child: ListTile(
                            //     trailing: Text("${tier.etaStringShort}"),
                            //     leading: Stack(
                            //       children: [
                            //         CircleAvatar(
                            //           backgroundImage:
                            //               NetworkImage(tier.productImageUrl!),
                            //           radius: 30,
                            //         ),
                            //         const Positioned(
                            //           bottom: 0,
                            //           right: 0,
                            //           child: CircleAvatar(
                            //             backgroundColor: Colors.purple,
                            //             backgroundImage: AssetImage(
                            //                 "assets/images/uberLogo.png"),
                            //             radius: 10,
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //     subtitle: Text(
                            //         "${tier.currencyCode} ${fareSpliter(tier.fare)}"),
                            //     title: Row(
                            //       children: [
                            //         Text("${tier.displayName}"),
                            //         const SizedBox(
                            //           width: 20,
                            //         ),
                            //         const Icon(
                            //           Icons.person,
                            //           size: 20,
                            //         ),
                            //         Text("${tier.capacity}"),
                            //       ],
                            //     ),
                            //   ));
                          }),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "OLA Rides",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  data1 == null
                      ? const Center(
                          child: Text("No Ride Found for OLA"),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data1!.data!.p2P!.categories!.length,
                          itemBuilder: (context, index) {
                            Category tier =
                                data1!.data!.p2P!.categories![index];

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 10, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/olaLogo.png"),
                                              // image: SvgPicture.asset(
                                              //     'assets/images/olacars.svg'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                child: Text(
                                                  "${tier.displayName}",
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              // Container(
                                              //   alignment: Alignment.topLeft,
                                              //   decoration:
                                              //       const BoxDecoration(),
                                              //   child: const Icon(
                                              //       Icons.accessible),
                                              // ),
                                              // Container(
                                              //   decoration:
                                              //       const BoxDecoration(),
                                              //   child: Text(
                                              //     "${tier.capacity}",
                                              //     style: const TextStyle(
                                              //         fontSize: 15,
                                              //         fontWeight:
                                              //             FontWeight.w600),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                child: const Text(
                                                  "Affordable rides",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                child: Text(
                                                  "in ${tier.eta!.value} ${tier.eta!.unit}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 25, 0, 0),
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "${olaFareCalculator(tier.id)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );

                            // return Card(
                            //     child: ListTile(
                            //   trailing:
                            //       Text("${tier.eta!.value} ${tier.eta!.unit}"),
                            //   leading: const CircleAvatar(
                            //     backgroundImage:
                            //         AssetImage("assets/images/olaLogo.png"),
                            //     radius: 30,
                            //   ),
                            //   subtitle: Text("${olaFareCalculator(tier.id)}"),
                            //   title: Text("${tier.displayName}"),
                            // ));
                          }),
                ],
              ),
            ),
    );
  }
}
