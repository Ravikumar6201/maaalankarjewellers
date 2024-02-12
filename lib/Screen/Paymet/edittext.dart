// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:MaaAlankar/class/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class PaymentModeWidget extends StatefulWidget {
  final total_price;
  final shipping_mode, payment_method, shipping_address;

  const PaymentModeWidget(
      {Key? key,
      this.total_price,
      this.shipping_mode,
      this.payment_method,
      this.shipping_address})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return paymentModeWidget();
  }
}

class paymentModeWidget extends State<PaymentModeWidget> {
  static const platform = const MethodChannel("razorpay_flutter");
  late Razorpay _razorpay;
  var store_api_token, Url = Constant(), balance, credit, cod, total = 0.0;
  late int store_id;
  late int add_amount;
  bool _load = false;
  var mode_shipping, mode_pay;
  late List list;
  bool _credit = false;
  bool _cod = false;
  bool _balance = false;
  bool _balanceCondition = true;

  @override
  void initState() {
    getStringValuesSF();
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  getStringValuesSF() async {
    setState(() {
      _load = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    store_api_token = prefs.getString('store_api_token');
    store_id = prefs.getInt('store_id')!;
    final response1 = await http.post((Url.url + "customer/wallet") as Uri,
        headers: {HttpHeaders.authorizationHeader: "$store_api_token"});
    if (response1.statusCode == 200) {
      var result1 = json.decode(response1.body);

      if (result1['success'] == true) {
        setState(() {
          balance = result1['balance'];
          credit = result1['credit'];
          cod = result1['cod'];
//          //print(list);
        });
      } else {
//          final snackBar = SnackBar(content: Text(result['message']));
//          _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    } else {
      throw Exception('Failed to load photos');
    }

    setState(() {
      _load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon:
        //       Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Checkout',
        ),
        actions: <Widget>[
          // ShoppingCartButtonWidget(
          //     iconColor: Theme.of(context).hintColor,
          //     labelColor: Theme.of(context).accentColor),
          Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(300),
                onTap: () {
                  Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('img/user2.jpg'),
                ),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _wallet(context);
        },
        child: Icon(Icons.account_balance_wallet),
      ),
      body: _load
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      // leading: Icon(
                      // UiIcons.money,
                      // color: Theme.of(context).hintColor,
                      // ),
                      title: Text(
                        'Payment Method',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'Select your prefered payment method',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      SizedBox(
                        width: 320,
                        child: ElevatedButton(
                          onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => CheckoutDoneWidget()),
//                      );
                            CreateOrder("COD", widget.shipping_mode);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Cash On Delivery',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Rs ' +
                              (double.parse(widget.total_price) - total)
                                  .toString(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      SizedBox(
                        width: 320,
                        child: ElevatedButton(
                          onPressed: () {
                            _launchURL();
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => CheckoutDoneWidget()),
//                      );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'SBI Connect',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Rs ' +
                              (double.parse(widget.total_price) - total)
                                  .toString(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      SizedBox(
                        width: 320,
                        child: ElevatedButton(
                          onPressed: () {
                            double razoramount =
                                double.parse(widget.total_price) - total;
                            openCheckout(
                                razoramount, "razorpay", widget.shipping_mode);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'razorpay',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Rs ' +
                              (double.parse(widget.total_price) - total)
                                  .toString(),
                        ),
                      )
                    ],
                  ),

//            SizedBox(
//              width: 320,
//              child: FlatButton(
//                onPressed: () {
//                  openCheckout(double.parse(widget.total_price),"razorpay",widget.shipping_mode);
//
////                  Navigator.push(
////                    context,
////                    MaterialPageRoute(builder: (context) => CheckoutDoneWidget()),
////                  );
//                },
//                padding: EdgeInsets.symmetric(vertical: 14),
//
//
//                child: Container(
//                  width: double.infinity,
//                  padding: const EdgeInsets.symmetric(horizontal: 20),
//                  child: Text(
//                    'Razorpay',
//                    textAlign: TextAlign.start,
//                    style: TextStyle(color: Theme.of(context).primaryColor),
//                  ),
//                ),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 20),
//              child: Text(
//                'Rs '+ (double.parse(widget.total_price) - total).toString(),
//
//              ),
//            ),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  TextEditingController creditController = TextEditingController(text: "0");
  TextEditingController codController = TextEditingController(text: "0");
  TextEditingController balanceController = TextEditingController(text: "0");
  void _wallet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Card(
                  elevation: 0.5,
                  child: ListTile(
                    title: Text("Credit :- Rs $credit"),
                    subtitle: TextField(
                      enabled: int.parse(credit) == 0 ? false : true,
                      controller: creditController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Use Credit Amount',
                        enabledBorder: UnderlineInputBorder(),
                        // focusedBorder: UnderlineInputBorder(
                        //     borderSide: BorderSide(
                        //         color: Theme.of(context).accentColor)),
                      ),
                      onChanged: (value) {
                        if (int.parse(value) >= int.parse(credit)) {
                          // showToast(
                          //     "Please enter amount smaller than Credit Amount",
                          //     duration: Toast.LENGTH_LONG,
                          //     gravity: Toast.TOP);
                          setState(() {
                            _balanceCondition = false;
                          });
                        } else {
                          _balanceCondition = true;
                        }
                      },
                    ),
                  ),
//                  child: CheckboxListTile(
//                    value: _credit,
//                    title: Text("Credit",style: TextStyle(fontFamily: 'Poppins')),
//                    subtitle: Text("Rs $credit",style: TextStyle(fontFamily: 'Poppins')),
//                    onChanged: (value)
//                    {
//                      if(value == true)
//                      {
//                        setState(() {
//                          _credit = true;
////                          total_price -= double.parse(credit);
//                        });
//                        Navigator.of(context).pop();
//                      }
//                      else
//                      {
//                        setState(() {
//                          _credit = false;
////                          total_price += double.parse(credit);
//                        });
//                        Navigator.of(context).pop();
//                      }
//                    },
//                  ),
                ),
                Card(
                    elevation: 0.5,
                    child: ListTile(
                      title: Text("COD :- Rs $cod"),
                      subtitle: TextField(
                        enabled: int.parse(cod) == 0 ? false : true,
                        controller: codController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Use COD Amount',
                          enabledBorder: UnderlineInputBorder(),
                          // focusedBorder: UnderlineInputBorder(
                          //     borderSide: BorderSide(
                          //         color: Theme.of(context).accentColor)),
                        ),
                        onChanged: (value) {
                          if (int.parse(value) >= int.parse(cod)) {
                            // showToast(
                            //     "Please enter amount smaller than COD Amount",
                            //     duration: Toast.LENGTH_LONG,
                            //     gravity: Toast.TOP);
                            setState(() {
                              _balanceCondition = false;
                            });
                          } else {
                            _balanceCondition = true;
                          }
                        },
                      ),
                    )
//                  child: CheckboxListTile(
//                    value: _cod,
//                    title: Text("COD",style: TextStyle(fontFamily: 'Poppins')),
//                    subtitle: Text("Rs $cod",style: TextStyle(fontFamily: 'Poppins')),
//                    onChanged: (value)
//                    {
//                      if(value == true)
//                      {
//                        setState(() {
//                          _cod = true;
////                          total_price -= double.parse(cod);
//                        });
//                      }
//                      else
//                      {
//                        setState(() {
//                          _cod = false;
////                          total_price += double.parse(cod);
//
//                        });
//                      }
//                      Navigator.of(context).pop();
//                    },
//                  ),
                    ),
                Card(
                    elevation: 0.5,
                    child: ListTile(
                      title: Text("Balance :- Rs $balance"),
                      subtitle: TextField(
                        enabled: int.parse(balance) == 0 ? false : true,
                        controller: balanceController,
                        //
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Use Balance Amount',
                          enabledBorder: UnderlineInputBorder(),
                          // focusedBorder: UnderlineInputBorder(
                          //     borderSide: BorderSide(
                          //         color: Theme.of(context).accentColor)),
                        ),
                        onChanged: (value) {
                          if (int.parse(value) >= int.parse(balance)) {
                            // showToast(
                            // "Please enter amount smaller than Balance Amount",
                            // duration: Toast.LENGTH_LONG,
                            // gravity: Toast.TOP);
                            setState(() {
                              _balanceCondition = false;
                            });
                          } else {
                            _balanceCondition = true;
                          }
                        },
                      ),
                    )
//                  child: CheckboxListTile(
//                    value: _balance,
//                    title: Text("Balance",style: TextStyle(fontFamily: 'Poppins')),
//                    subtitle: Text("Rs $balance",style: TextStyle(fontFamily: 'Poppins')),
//                    onChanged: (value)
//                    {
//                      if(value == true)
//                      {
//                        setState(() {
//                          _balance = true;
////                          total_price -= double.parse(balance);
//
//                        });
//                      }
//                      else
//                      {
//                        setState(() {
//                          _balance = false;
////                          total_price += double.parse(balance);
//
//                        });
//                      }
//                      Navigator.of(context).pop();
//                    },
//                  ),
                    ),
                _balanceCondition
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.00),
                        child: ElevatedButton(
                          child: Text(
                            "Apply",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () {
                            if (creditController.text == "") {
                              creditController.text = "0";
                            }
                            if (codController.text == "") {
                              codController.text = "0";
                            }
                            if (balanceController.text == "") {
                              balanceController.text = "0";
                            }
                            setState(() {
                              total = double.parse(creditController.text) +
                                  double.parse(codController.text) +
                                  double.parse(balanceController.text);
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    : Container()
              ],
            ),
          );
        });
  }

  _launchURL() async {
    const url = 'https://www.onlinesbi.com/sbicollect/icollecthome.htm';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  CreateOrder(String payment_mode, int shipping_mode) async {
    setState(() {
      _load = true;
    });
    switch (shipping_mode) {
      case 1:
        setState(() {
          mode_shipping = "Bus";
        });
        break;
      case 2:
        setState(() {
          mode_shipping = "Auto";
        });
        break;
      case 3:
        setState(() {
          mode_shipping = "Self Pickup";
        });
        break;
      case 4:
        setState(() {
          mode_shipping = "Thela Gadi";
        });
        break;
      case 5:
        setState(() {
          mode_shipping = "Transport";
        });
        break;
    }
    Map payment_method = {
      '"credit"': creditController.text,
      '"cod"': codController.text,
      '"balance"': balanceController.text
    };
    Map data = {
      'shipping_mode': mode_shipping,
      'payment_mode': payment_mode,
      'shipping_address': widget.shipping_address,
      'payment_method': [payment_method].toString()
    };

    print(data);
    final response = await http.post((Url.url + "customer/order") as Uri,
        body: data,
        headers: {HttpHeaders.authorizationHeader: "$store_api_token"});
    print(data);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['success'] == true) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => CheckoutDoneWidget()),
        // );
      } else {
        print("Error");
      }
    } else {
      throw Exception('Failed to load photos' + response.body);
    }

    setState(() {
      _load = false;
    });
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    // Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(
      double amount, String payment_mode, int shipping_mode) async {
    setState(() {
      _load = true;
    });
    switch (shipping_mode) {
      case 1:
        setState(() {
          mode_shipping = "Bus";
        });
        break;
      case 2:
        setState(() {
          mode_shipping = "Auto";
        });
        break;
      case 3:
        setState(() {
          mode_shipping = "Self Pickup";
        });
        break;
      case 4:
        setState(() {
          mode_shipping = "Thela Gadi";
        });
        break;
      case 5:
        setState(() {
          mode_shipping = "Transport";
        });
        break;
    }
    setState(() {
      mode_pay = payment_mode;
      add_amount = amount.round() * 100;
    });
    var options = {
      'key': 'rzp_test_BDncflNBx3gzqG',
//      'amount': add_amount.toString(),
      'amount': add_amount.toString(),
      'name': 'Wallet',
      'description': 'Add Money',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('$e');
    }

    setState(() {
      _load = false;
    });
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("kkk" + add_amount.toString());
    Map payment_method = {
      '"credit"': creditController.text,
      '"cod"': codController.text,
      '"balance"': balanceController.text
    };
    Map data = {
      'shipping_mode': mode_shipping,
      'payment_mode': mode_pay,
      'shipping_address': widget.shipping_address,
      'payment_method': [payment_method].toString(),
//      'amount' : "241664.0",
      'amount': add_amount.toString(),
      'razorpay_id': response.paymentId.toString(),
      'order_id': response.orderId.toString(),
    };
    final resp = await http.post((Url.url + "customer/order") as Uri,
        body: data,
        headers: {HttpHeaders.authorizationHeader: "$store_api_token"});
    //var resp = await http.post("https://6a3cf0a5.ngrok.io/tournament/public/api/add/balance",body: data);
    if (resp.statusCode == 200) {
      var result = json.decode(resp.body);
      if (result['success'] == true) {
        // showToast(result['message'],
        //     duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => CheckoutDoneWidget()),
        // );
      }
    } else {
      print(resp.body);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // showToast("ERROR", duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // showToast("EXTERNAL_WALLET",
    //     duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
  }
}
