import 'package:flutter_test/flutter_test.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

void main() {
  test("Phone parser", () {
    var phone =
        PhoneNumber.parse("9406801801", callerCountry: IsoCode.fromJson("IN"));
    expect("91", phone.countryCode);
  });
}
