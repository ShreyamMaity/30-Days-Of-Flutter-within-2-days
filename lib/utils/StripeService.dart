// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:test_application/widgets/themeCrontoller.dart';

class StripeService{

  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(context) async {
    paymentIntentData = await createPaymentIntent('20','inr');
    
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        googlePay: true,
        style: themeController().theme,
        merchantCountryCode: 'IN',
        merchantDisplayName: 'Rey',
      ),
      );
      displayPaymentSheet(context);
  }

    Future<void> displayPaymentSheet(context) async{
        try {
          await Stripe.instance.presentPaymentSheet(
            parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!['client_secret'],
              confirmPayment: true,
              ),
          );
          paymentIntentData = null;

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Payment Successful'),
          ));
        } on StripeException catch(e){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Payment Failed'),
          ));
        }
    }

    createPaymentIntent(String amount,String currency) async {

      try {
        Map<String, dynamic> body = {
          'amount': calculateAmoung(amount),
          'currency': currency,
          'payment_method_types[]': 'card',
        };

        var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ${dotenv.env['stripeSecKey'].toString()}',
          'Content-Type': 'application/x-www-form-urlencoded',
        }
        );
        return jsonDecode(response.body.toString());
      } catch (e) {
        print(e.toString());
      }
      }

      calculateAmoung(String amount){
        final price = int.parse(amount) * 100;
        return price.toString();
      }

    }

