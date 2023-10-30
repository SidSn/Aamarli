// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:get/get.dart';
import 'package:spelling_number/spelling_number.dart';

class ControllerText extends GetxController {
  var userInput = ''.obs;
  var answer = 0.obs;
  var converted = ''.obs;
  var lang = 1.obs;
  var isShowen = false.obs;
  var usdtoDzd = ''.obs;
  var eurotoDzd = ''.obs;
  var firstNumber = ''.obs;
  var secondNumber = ''.obs;
  var firstCurrency = 'USD'.obs;
  var secondCurrency = 'EUR'.obs;

  @override
  onInit() {
    super.onInit();
    converterRates();
  }

  Future<void> convertCurrency() async {
    if (firstNumber.value.isNotEmpty) {
      double amount = double.tryParse(firstNumber.value) ?? 0;
      var convertedAmount = await CurrencyConverter.convert(
        from: _getCurrencyEnum(firstCurrency.value),
        to: _getCurrencyEnum(secondCurrency.value),
        amount: amount,
      );
      secondNumber.value = convertedAmount!.toStringAsFixed(2);
    } else {
      secondNumber.value = '';
    }
  }

  void swapCurrencies() {
    var temp = firstCurrency.value;
    firstCurrency.value = secondCurrency.value;
    secondCurrency.value = temp;
    convertCurrency();
  }

  void updateFirstCurrency(String? newValue) {
    if (newValue != null) {
      firstCurrency.value = newValue;
      _updateConversion();
    }
  }

  void updateSecondCurrency(String? newValue) {
    if (newValue != null) {
      secondCurrency.value = newValue;
      _updateConversion();
    }
  }

  void _updateConversion() {
    convertCurrency();
  }

  Currency _getCurrencyEnum(String currencyCode) {
    switch (currencyCode) {
      case 'USD':
        return Currency.usd;
      case 'EUR':
        return Currency.eur;
      case 'GBP':
        return Currency.gbp;
      case 'JPY':
        return Currency.jpy;
      case 'CAD':
        return Currency.cad;
      case 'AUD':
        return Currency.aud;
      case 'DZD':
        return Currency.dzd;

      default:
        return Currency.usd; // Default to USD if the code is not recognized
    }
  }

  converterRates() async {
    var usdConvert = await CurrencyConverter.convert(
      from: Currency.usd,
      to: Currency.dzd,
      amount: 1,
    );
    usdtoDzd.value = usdConvert.toString();
    var euroConvert = await CurrencyConverter.convert(
      from: Currency.eur,
      to: Currency.dzd,
      amount: 1,
    );
    eurotoDzd.value = euroConvert.toString();
  }

  addNumber(String input) {
    if (userInput.value.length < 9) {
      userInput.value += input;
      converterToNumbers();
    } else {
      if (lang.value == 1) {
        converted.value = "Number too large";
      } else if (lang.value == 2) {
        converted.value = "Nombre trop large";
      } else {
        converted.value = "الرقم كبير جدًا";
      }
    }
  }

  subNumber() {
    if (userInput.value.isEmpty) {
    } else {
      userInput.value =
          userInput.value.substring(0, userInput.value.length - 1);
    }
    converterToNumbers();
  }

  converterToNumbers() {
    if (userInput.value.length < 9) {
      if (lang.value == 1) {
        if (userInput.value.isEmpty) {
        } else {
          answer.value = int.parse(userInput.value);
          answer.value = int.parse(userInput.value);
          converted.value = SpellingNumber(lang: 'en').convert(answer.value) +
              "  algerian dinar";
        }
      } else if (lang.value == 2) {
        answer.value = int.parse(userInput.value);
        converted.value = SpellingNumber(lang: 'fr').convert(answer.value) +
            " dinar algerien";
      } else {
        answer.value = int.parse(userInput.value);
        converted.value =
            SpellingNumber(lang: 'ar').convert(answer.value) + " دينار جزائري ";
      }
    } else {
      if (lang.value == 1) {
        converted.value = "Number too large";
      } else if (lang.value == 2) {
        converted.value = "Nombre trop large";
      } else {
        converted.value = "الرقم كبير جدًا";
      }
    }
  }
}
