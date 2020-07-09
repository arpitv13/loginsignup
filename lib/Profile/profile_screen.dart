import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginapp/Auth/signin_number.dart';
import 'package:loginapp/app_data.dart';
import 'package:loginapp/home_page.dart';
import 'package:loginapp/order_page.dart';
import 'package:loginapp/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'bottom_container.dart';
import 'package:loginapp/Widgets/commonWidgets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String username = Provider.of<ProfileData>(context, listen: false).username;
    String email = Provider.of<ProfileData>(context, listen: false).email;
    int ordersLength = (orders.length > 7) ? 7 : orders.length;
    File ImageFile = Provider.of<ProfileData>(context, listen: false).ImageFile;
    print(ImageFile);
    return (!gettingOrdersCompleted)
        ? Center(child: CircularProgressIndicator())
       :Builder(
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(11.0, 10.0, 11.0, 11.0),
  //      child: SingleChildScrollView(
          child: Column(
          children: [
            Material(
              elevation: 0,
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
              //      mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      (ImageFile == null)
                          ? Icon(
                              Icons.account_circle,
                              size: 90,
                            )
                          : Image.file(
                              ImageFile,
                              height: 100,
                              width: 150,
                            ),
                    ],),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: (username == null)
                            ? Text(
                                'ACHA AADMI',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )
                            : Text(
                                username,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                      ),
                      
                      Align(
                        alignment: Alignment.topLeft,
                          child: (email == null)
                              ? Text('achaadmisince1997@gmail.com',overflow: TextOverflow.ellipsis,)
                              : Text(email,))
                    ],
                  ),
                  
                     Align(
                       alignment: Alignment.topRight,
         //         padding: const EdgeInsets.all(0.0),
                  child: GestureDetector(
                    child: Text('Edit Profile'),
                    onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomContainer()));
                        },  
                  ),
                ),
                    
      
                ],
              ),
            ),
             Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new arrowCard(
                          cardTitle: 'My Account',
                          cardItems:
                          'Manage Addresses, Payment Method, My Favourites',
                        ),
                        new arrowCard(
                          cardTitle: 'Support Center',
                          cardItems: 'Help, Send Feedback, Rate us, Report, FAQ',
                        ),
                        new arrowCard(
                          cardTitle: 'About',
                          cardItems: 'Privacy Policy, Terms of service, Licenses',
                        ),
                      ],
                    ),

             Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Row(
                        children: <Widget>[
                          Text('Order History'),
                        ],
                      ),
                    ),
                                    (orders.length != 0)
                      ? Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return (index < ordersLength)
                                  ? OrdersHistoryTile(
                                      orders[orders.length - 1 - index]
                                          ['total_amount'],
                                      '${orders[orders.length - 1 - index]['customer_location']['address']},${orders[orders.length - 1 - index]['customer_location']['city']}',
                                      orders[orders.length - index - 1]
                                          ['date_created'],
                                      orders[orders.length - index - 1]
                                          ['products_order'])
                                  : FloatingActionButton(
                                      onPressed: () async {
                                        SharedPreferences preference =
                                            await SharedPreferences
                                                .getInstance();

                                        preference.remove('isLogin');

                                        Navigator.pop(context);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));

                                        setState(() {
                                          index = 0;

                                          cartList = [];

                                          orders = [];

                                          Provider.of<ProfileData>(context,
                                                  listen: false)
                                              .updateAuth(null, null);
                                        });
                                      },
                                      child:
                                          FaIcon(FontAwesomeIcons.signOutAlt));
                            },
                            itemCount: ordersLength + 1,
                          ),
                        )
                      : Text('No orders yet'),  
          ]
      //  )
        )
      )
    );
  }
}

class OrdersHistoryTile extends StatelessWidget {
  double mrp;
  String address;
  String datetime;
  List products;
  String productAndQuantity = '';

  OrdersHistoryTile(this.mrp, this.address, this.datetime, this.products);
  @override
  Widget build(BuildContext context) {
    if (products.length < 2) {
      for (int i = 0; i < products.length; i++) {
        productAndQuantity +=
            '${products[i]['product']['item_desc']} X ${products[i]['quantity']}, ';
      }
    } else {
      for (int i = 0; i < 2; i++) {
        productAndQuantity +=
            '${products[i]['product']['item_desc']} X ${products[i]['quantity']}, ';
      }
      productAndQuantity += 'and ${products.length - 3} more';
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ITEMS',
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  Text('TOTAL', style: TextStyle(color: Colors.grey.shade400))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        '$productAndQuantity',
                        style: kTextStyle.copyWith(fontSize: 13, height: 1.3),
                      ),
                    ),
                  ),
                  Text(
                    '$mrp',
                    style: kHeadingStyle,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$address',
                  style: TextStyle(color: Colors.grey.shade400)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                  '${datetime.substring(11, 16)} on ${datetime.substring(0, 10)}',
                  style: TextStyle(color: Colors.grey.shade400)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      Text(
                        'Order Confirmed',
                        style: kTextStyle,
                      ),
                    ],
                  ),
                  Text(
                    'Repeat order',
                    style: kTextStyle.copyWith(color: Colors.green),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
