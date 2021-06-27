import 'package:flutter/material.dart';
import 'package:greatdanic_logistics/shared/constants.dart';
import 'package:greatdanic_logistics/shared/customtext.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class CheckOut extends StatefulWidget {
  final String price;
  const CheckOut({Key key, this.price}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  var publicKey = 'pk_test_b03a040efdc3c592cc1f62892f394f26cfec1b31';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // int toActualPrice() {
    //   int result = int.parse(widget.price) * 100;
    // }

    List value = widget.price.split(",");
    String price = value[1];
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Container(
              height: MediaQuery.of(context).size.height * 1.0,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/check.png"),
                      )
                    ),
                  ),
                  CustomText(
                      text: "You're one step away!",
                      size: 30,
                      color: Colors.black),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          text: "Amount to be paid for delivery",
                          size: 17,
                          weight: FontWeight.bold,
                          color: Colors.black),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          text: price,
                          weight: FontWeight.bold,
                          size: 40,
                          color: primaryColor),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: RaisedButton(
                      child: CustomText(
                        text: "PAY NOW",
                        size: 16,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        Charge charge = Charge()
                          ..amount = int.parse(price) * 100
                          ..reference = DateTime.now()
                              .millisecondsSinceEpoch
                              .toString()
                          // or ..accessCode = _getAccessCodeFrmInitialization()
                          ..email = 'customer@email.com';
                        CheckoutResponse response =
                            await plugin.checkout(
                          context,
                          method: CheckoutMethod
                              .card, // Defaults to CheckoutMethod.selectable
                          charge: charge,
                        );
                      },
                      color: primaryColor,
                    ),
                  )
                  // Container(
                  //   height: 30,
                  //   width: 40,
                  //   decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //           image: AssetImage("images/logo.png"))),
                  // ),
                  // InkWell(
                  //   child: CustomText(
                  //     text: "PAY NOW",
                  //     size: 18,
                  //     color: Colors.black,
                  //   ),
                  // )
                ],
              ),
            )));
  }

  // void _checkPayment() {
  //   try {
  //     PaystackPayManager(context: context)
  //       ..setSecretKey("sk_test_999631381604afd0f88e0750a23df7035d71a2a9")
  //       // ..setCompanyAssetImage(Image(image: NetworkImage("YOUR-IMAGE-URL")))
  //       ..setAmount(100000)
  //       ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
  //       ..setCurrency("NGN")
  //       ..setEmail("jamespeter2225@gmail.com")
  //       ..setFirstName("Samuel")
  //       ..setLastName("Adekunle")
  //       ..setMetadata(
  //         {
  //           "custom_fields": [
  //             {
  //               "value": "TechWithSam",
  //               "display_name": "Payment_to",
  //               "variable_name": "Payment_to"
  //             }
  //           ]
  //         },
  //       )
  //       ..onSuccesful(_onPaymentSuccessful)
  //       ..onPending(_onPaymentPending)
  //       ..onFailed(_onPaymentFailed)
  //       ..onCancel(_onCancel)
  //       ..initialize();
  //   } catch (error) {
  //     print('Payment Error ==> $error');
  //   }
  // }

  // void _onPaymentSuccessful(Transaction transaction) {
  //   print('Transaction succesful');
  //   print(
  //       "Transaction message ==> ${transaction.message}, Ref ${transaction.refrenceNumber}");
  // }

  // void _onPaymentPending(Transaction transaction) {
  //   print('Transaction Pending');
  //   print("Transaction Ref ${transaction.refrenceNumber}");
  // }

  // void _onPaymentFailed(Transaction transaction) {
  //   print('Transaction Failed');
  //   print("Transaction message ==> ${transaction.message}");
  // }

  // void _onCancel(Transaction transaction) {
  //   print('Transaction Cancelled');
  // }
}
