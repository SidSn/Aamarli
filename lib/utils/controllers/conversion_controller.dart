import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:get/get.dart';

class ConvertController extends GetxController {
  var usdtoDzd = ''.obs;
  var eurotoDzd = ''.obs;
  var cadtoDzd = ''.obs;
  var gptoDzd = ''.obs;
  var jptoDzd = ''.obs;
  var austoDzd = ''.obs;
  @override
  onInit() {
    super.onInit();
    converterRates();
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
    var cadConvert = await CurrencyConverter.convert(
      from: Currency.cad,
      to: Currency.dzd,
      amount: 1,
    );
    cadtoDzd.value = cadConvert.toString();
    var gpConvert = await CurrencyConverter.convert(
      from: Currency.gbp,
      to: Currency.dzd,
      amount: 1,
    );
    gptoDzd.value = gpConvert.toString();
    var ausConvert = await CurrencyConverter.convert(
      from: Currency.aud,
      to: Currency.dzd,
      amount: 1,
    );
    austoDzd.value = ausConvert.toString();
    var jpConvert = await CurrencyConverter.convert(
      from: Currency.cad,
      to: Currency.dzd,
      amount: 1,
    );
    jptoDzd.value = jpConvert.toString();
  }
}
