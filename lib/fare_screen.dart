import 'dart:convert';

import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uber_scrape/fare_model.dart';
import 'package:uber_scrape/model.dart/ola_model.dart';
import 'package:uber_scrape/utils/credentails.dart';
import 'package:uber_scrape/utils/utils.dart';

class FareScreen extends StatefulWidget {
  final LatLng? pickUp,destination;
  const FareScreen({this.pickUp,this.destination});

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
  var data2;
  bool isFound = false;

  fetchFare()async{
    setState(() {
      isFound = true;
    });
    try {
   var res =  await http.post(Uri.parse(UBER_URL),body: jsonEncode(uberPayload(pickUp: widget.pickUp,destination: widget.destination)),headers: uberHeader() );
   var res1 =  await http.get(Uri.parse(olaURL(pickUp: widget.pickUp,destination: widget.destination)),headers: olaHeader() );
   var res2 =  await http.get(Uri.parse(olaURLFare(pickUp: widget.pickUp,destination: widget.destination)),headers: olaHeader() );
  var uberData = jsonDecode(res.body);
  var olaData = jsonDecode(res1.body);
  var olaDataFare = jsonDecode(res2.body);
  print(uberData);
    if(uberData['data'] != null){
    data = FareModel.fromJson(uberData);
    }
  
    if(olaData['data'] != null){
    data1 = OlaModel.fromJson(olaData);
    }
    if(olaDataFare['data'] != null){
    data2 = olaDataFare;
    }

   
    } catch (e) {
      print(e);
    }
     setState(() {
      isFound = false;
    });

  
  }

  olaFareCalculator(id){
    var fare = "";
    if(data2['data']['p2p']['categories'][id] != null){
      fare = data2['data']['p2p']['categories'][id]['price'];
    }
   return fare;
  }

  fareSpliter(fare){
    var farePrice =  fare.toString().split("â¹");
    print(farePrice);
    if(farePrice.length > 1){
    return farePrice[1];
    }else{
      farePrice =  farePrice[0].split('PKRÂ');
    return  (farePrice.length > 1) ?farePrice[1] : farePrice[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(title: Text("Fare Details"),centerTitle: true, ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        fetchFare();
      },),
      body: isFound ? Center(child: CircularProgressIndicator.adaptive()) : 
      SingleChildScrollView(
        child: Column(
          children: [
          data == null ? Center(child: Text("No Ride Found for UBER"),) :   ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data!.data!.products!.tiers![0].products!.length,
              itemBuilder: (context,index){
                Product tier =data!.data!.products!.tiers![0].products![index];
              return Card(child: ListTile(
                trailing: Text("${tier.etaStringShort}"),
                leading: Stack(
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(tier.productImageUrl!),radius: 30, ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar( backgroundColor: Colors.purple, backgroundImage: AssetImage("assets/images/uberLogo.png" ),radius: 10, ),
                            )            ],
                ),
                subtitle: Text("${tier.currencyCode} ${fareSpliter(tier.fare)}"),
                title: Row(
                  children: [
                    Text("${tier.displayName}"),
                    SizedBox(width: 20,),
                    Icon(Icons.person,size: 20,),
                    Text("${tier.capacity}"),
      
                  ],
                ),
              ));
            } ),
             data1 == null ? Center(child: Text("No Ride Found for OLA"),) :  ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data1!.data!.p2P!.categories!.length,
              itemBuilder: (context,index){
                Category tier = data1!.data!.p2P!.categories![index];
              return Card(child: ListTile(
                trailing: Text("${tier.eta!.value} ${tier.eta!.unit}"),
                leading: CircleAvatar(backgroundImage: AssetImage("assets/images/olaLogo.png"),radius: 30, ),
                subtitle: Text("${olaFareCalculator(tier.id)}"),
                title: Text("${tier.displayName}"),
              ));
            } ),
         
          ],
        ),
      ),
    );
  }
}