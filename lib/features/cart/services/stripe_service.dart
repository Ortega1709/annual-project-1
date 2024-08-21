import 'dart:convert';
import 'package:e_commerce/core/utils/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  Map<String, dynamic>? paymentIntent;

  StripeService._();

  static final StripeService instance = StripeService._();

  Future<String> makePayment(BuildContext context, double amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');

      // get payment ID from the server
      final paymentIntentId = paymentIntent!['id'];

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          googlePay: const PaymentSheetGooglePay(
            testEnv: true,
            currencyCode: "USD",
            merchantCountryCode: "USD",
          ),
          merchantDisplayName: 'E-commerce',
        ),
      );

      // ignore: use_build_context_synchronously
      await displayPaymentSheet(context: context);
      final response =
          await checkSuccessPayment(paymentIntentId: paymentIntentId);
      if (response) {
        return paymentIntentId.toString();
      }
    } catch (e) {
      debugPrint("exception $e");
      if (e is StripeConfigException) {
        debugPrint("Stripe exception ${e.message}");
      } else {
        debugPrint("exception $e");
      }
    }
    return '';
  }

  displayPaymentSheet({required BuildContext context}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      paymentIntent = null;
    } on StripeException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  createPaymentIntent(double amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': _calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var secretKey = Secrets.stripeSecretKey;
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      debugPrint('Payment Intent Body: ${response.body.toString()}');
      return jsonDecode(response.body.toString());
    } catch (err) {
      debugPrint('Error charging user: ${err.toString()}');
    }
  }

  Future<bool> checkSuccessPayment({
    required String paymentIntentId,
  }) async {
    var secretKey = Secrets.stripeSecretKey;
    try {
      http.Response response = await http.get(
          Uri.parse(
            'https://api.stripe.com/v1/payment_intents/$paymentIntentId',
          ),
          headers: {
            "Authorization": "Bearer $secretKey",
            "Content-Type": "application/x-www-form-urlencoded"
          });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['status'] == 'succeeded') ? true : false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return false;
  }

  String _calculateAmount(double amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toInt().toString();
  }
}
