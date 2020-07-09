import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:loginapp/Address/address_page.dart';
import 'package:loginapp/Auth/signin_number.dart';
import 'package:loginapp/Profile/profile_screen.dart';
import 'package:loginapp/Widgets/appbar_widgets.dart';
import 'package:loginapp/app_data.dart';
import 'package:loginapp/constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loginapp/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:loginapp/Widgets/appbar_widgets.dart';
Logger logger = Logger('home-logger');
Placemark address;
int index = 0;
dynamic orderData;
String authToken;
bool isLoading=true;
bool gettingOrdersCompleted=false;
ConnectivityResult connectivityResult;
StreamSubscription connectivityStream;
RefreshController refreshController=RefreshController();
List orders=[];
List<OrderTile> cartOrderTiles=[];
Future addToCart(String id, int quantity,BuildContext buildContext) async {
  logger.info('adding to cart');


  try {
    http.Response response =
        await http.post('$baseurl/api/v1/cart/add-update-cart/', headers: {
      'Authorization': 'Bearer $authToken',
    }, body: {
      'product_id': '$id',
      'quantity': '$quantity'
    });
    print(response.statusCode);
    print(response.body);


  if (response.statusCode>=200&&response.statusCode<300)
    {Scaffold.of(buildContext).showSnackBar(SnackBar(content: Text('${response.body}')));
    }
  else{
    Scaffold.of(buildContext).showSnackBar(SnackBar(content: Text('error in adding to cart')));
  }

  } catch (e) {
    logger.severe('Error in adding/updating cart');
    logger.severe(e);
  }
}

Future removeFromCart(String id,BuildContext buildContext) async {
  logger.info('Deleting');
  try {
    String uri = '$baseurl/api/v1/cart/remove-from-cart/';

    http.Request request = http.Request('DELETE', Uri.parse(uri))
      ..headers.addAll({"Authorization": "Bearer $authToken"});
    request.bodyFields = {"product_id": "$id"};
    var response = await http.Client().send(request);
    print(response.request);
    print(response.headers);
    print(response.statusCode);
    if (response.statusCode>=200&&response.statusCode<300)
    {Scaffold.of(buildContext).showSnackBar(SnackBar(content: Text('Removed from cart!')));
    }
    else{
      Scaffold.of(buildContext).showSnackBar(SnackBar(content: Text('error in removing from cart!')));
    }

  } catch (e) {
    logger.severe('error in removing from cart');
    logger.severe(e);
  }
}

Future createOrder(int id) async {
  logger.info('Creating order');
  print(jsonEncode(OrderModel(cartList, id)));
  try {
    http.Response response =
        await http.post('$baseurl/api/v1/order/create-order/',
            headers: {
              'Authorization': 'Bearer $authToken',
              "Accept": "application/json",
              "content-type": "application/json"
            },
            body: jsonEncode(OrderModel(cartList, id)));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      orderData = jsonEncode(response.body);
      getOrders();
      return jsonDecode(response.body);
    }
    else{
      return false;
    }

  } catch (e) {
    logger.severe('error in creating order');
    logger.severe(e);
  return false;
  }
}

Future getOrders() async {
  logger.info('getting orders');
  try {
    http.Response response = await http.get('$baseurl/api/v1/order/get-orders/',
        headers: {"Authorization": "Bearer $authToken"});
    print('getting orders');
    print(response.statusCode);
    var data = jsonDecode(response.body);
    orders = data;
    print(orders.length);
    print(data);
  } catch (e) {
    logger.severe('error in getting orders');
    logger.severe(e);

  }
}


Future getCartData() async {
  logger.info('getting cart data');
  try {
    http.Response response =
        await http.get('$baseurl/api/v1/cart/get-cart/', headers: {
      'Authorization': 'Bearer $authToken',
    });
    print(response.statusCode);
    var data = jsonDecode(response.body);
    cartList = [];
    for (var product in data['products_cart']) {
      totalItemPrice=0;
      cartList.add(
        Order(
            product['product']['item_id'],
            product['product']['item_desc'],
            product['product']['quantity'][0]['bottle_mrp_rate'].toString(),
            product['quantity'],
            product['product']['category']['subtype']['subtype_name']),
      );
      totalItemPrice += product['product']['quantity'][0]['bottle_mrp_rate'];

    }
    print(cartList.length);
    for (var data in cartList)
      {
        cartOrderTiles.add(OrderTile( cartList[index].id,
          data.name,
          data.mrp,
          data.quantity,
          true,
          true,
          data.category,));

      }
  } catch (e) {
    logger.severe('error in removing from cart');
    logger.severe(e);
  }
}


class Order {
  String id;
  String name;
  String mrp;
  int quantity;
  String category;
  Order(this.id, this.name, this.mrp, this.quantity, this.category);
}

List<Order> orderList = [];

List<Order> cartList = [];

class HomePage extends StatefulWidget {
  String token;
  HomePage(this.token);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
Future getData()async{
print("GETTING DATA LOADING SCREEN");

 await getCartData().then((value) => getProductData().then((value) => getOrders().then((value) => setState(() {
   gettingOrdersCompleted=true;
 }))));


}


  Future getProductData() async {

  setState(() {
    isLoading=true;
  });
  try{  http.Response response =
        await http.get('$baseurl/api/v1/products/products-list/');
    print(response.statusCode);
    var data = jsonDecode(response.body);
    print('product');
    print(data);
    for (var product in data) {
      setState(() {
        orderList.add(Order(
            product['item_id'],
            product['item_desc'],
            product['quantity'][0]['bottle_mrp_rate'].toString(),
            1,
            product['category']['subtype']['subtype_name']));
      });

    }

  }
    catch(e){

    print('error in getting products:$e');

    }
setState(() {
  isLoading=false;
});
}

  Future loggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      authToken = (preferences.getString('isLogin') == null)
          ? this.widget.token
          : preferences.getString('isLogin');
    });
    print('${preferences.getString('isLogin')} auth');
  }
  Future checkConnectivity() async{
    ConnectivityResult result=await Connectivity().checkConnectivity();
    setState(() {
     connectivityResult=result;
     print(connectivityResult);
   });


  }

  void updateSearchList(List<Order> updated) {
    setState(() {
      itemList = updated;
    });
  }

  Widget child;
  DateTime date = DateTime.now();

  @override
  void initState() {

    setState(() {
      authToken=Provider.of<ProfileData>(context,listen: false).token;
print(authToken);
      checkConnectivity().then((value) {
          if (connectivityResult==ConnectivityResult.none)
      {
        isLoading=false;
      }

      else{
      if (this.widget.token!=null&&authToken!=null)
      {setState(() {
      print('token:$authToken');
      getData();
      });
      }

      else if(authToken==null&&this.widget.token==null) {
      setState(() {
      gettingOrdersCompleted=true;
      });

      getProductData();
      /* connectivityStream=Connectivity().onConnectivityChanged.listen((event) {
    setState(() {
      connectivityResult=event;
      if (connectivityResult!=ConnectivityResult.none){
getProductData();

      }
    });

  });*/

      }}}



      );
      print('connectivityresult:$connectivityResult');


      
    });

    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        {
          child = (connectivityResult==ConnectivityResult.none)?Container(
            child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Could not connect to internet'),
                FlatButton(onPressed: (){
                  checkConnectivity().then((value) {
                    setState(() {
                      isLoading=true;
                      (connectivityResult!=ConnectivityResult.none)?getData():
                      isLoading=false;
                    });


                  });
                },color: Colors.blue, child: Text('Try Again'))
              ],
            ),),

          ):((orderList.length!=0)?HomeWidget():ErrorWidget(null));
        }
        break;
      case 1:
        {
          child =(connectivityResult==ConnectivityResult.none)?Container(
            child: Center(child: Column(
              children: [
                Text('Could not connect to internet'),
                FlatButton(onPressed: (){
                  setState(() {
                    isLoading=true;
                    checkConnectivity().then((value) => (connectivityResult!=ConnectivityResult.none)?getData().then((value) => isLoading=false):isLoading=false);
                  });

                }, child: Text('Try Again'))
              ],
            ),),

          ): CartWidget();
        }
        break;
      case 2:
        break;
      case 3:
        {
          child =(connectivityResult==ConnectivityResult.none)?Container(
            child: Center(child: Column(
              children: [
                Text('Could not connect to internet'),
                FlatButton(onPressed: (){
                  checkConnectivity().then((value) => (connectivityResult!=ConnectivityResult.none)?getData():null);
                }, child: Text('Try Again'))
              ],
            ),),

          ): ProfileScreen();
        }
        break;
      default:
        null;
    }
print(orderList.length);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade700,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.home,
                ),
                title: Text('Home', style: TextStyle(color: Colors.black))
        ),
            BottomNavigationBarItem(
                icon:
                    FaIcon(FontAwesomeIcons.shoppingCart, ),
                title: Text(
                  'Cart',
                  style: TextStyle(color: Colors.black),
                )),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.search, ),
                title: Text('Search', style: TextStyle(color: Colors.black))),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.userAlt, ),
                title: Text('Profile', style: TextStyle(color: Colors.black))),
          ],
          onTap: (i) {
            setState(() {
              index = i;
              if (i == 2) {
                showSearch(context: context, delegate: DataSearch());
              }
            });
          },
          currentIndex: index,
        ),
        appBar: AppBar(
automaticallyImplyLeading: false,
          title: Text('$address'),
          centerTitle: true,
        ),
        body: (isLoading)?Center(child: CircularProgressIndicator()):child);

  }
}

class OrderModel {
  List<Order> orders;
  int locationId;
  OrderModel(this.orders, this.locationId);
  Map toJson() => {
        "products":
            orders.map((e) => Orders(e.id, e.quantity).toJson()).toList(),
        "location_id": locationId
      };
}

class Orders {
  var order_id;
  var quantity;
  Orders(this.order_id, this.quantity);

  Map toJson() => {"product_id": order_id, "quantity": quantity};
}
class ErrorWidget extends StatelessWidget {
 Future<dynamic> function;
  ErrorWidget(this.function);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text('Something went wrong'),

          ),

          FlatButton(onPressed: (){
          print('implementing');
          }, child: Text('Try Again after some time'))
        ],
      ),
    );
  }
}
