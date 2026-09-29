import 'package:flutter_test/flutter_test.dart';
import 'package:paisa_pilot/domain/sms_parser/sms_parser.dart';

void main() {
  group('SmsParser - OTP Scrubbing', () {
    test('scrubs standard bank OTP alert', () {
      const sms =
          'Dear Customer, OTP for your transaction of INR 1,500.00 is 492018. Do NOT share with anyone.';
      final result = SmsParser.parse(sms);
      expect(result, isNull);
    });

    test('scrubs one-time password security alert', () {
      const sms =
          'Your One Time Password for card verification is 882910. Valid for 10 min. Do not share OTP.';
      final result = SmsParser.parse(sms);
      expect(result, isNull);
    });

    test('scrubs verification code alert', () {
      const sms =
          '481920 is your verification code for PaisaPilot login. Do not share.';
      final result = SmsParser.parse(sms);
      expect(result, isNull);
    });
  });

  group('SmsParser - HDFC Bank', () {
    test('parses HDFC UPI debit alert', () {
      const sms =
          'Sent Rs.450.00 from HDFC Bank A/C **8832 to SWIGGY on 24-09-26 via UPI Ref 426812839401.';
      final result = SmsParser.parse(sms);
      expect(result, isNotNull);
      expect(result!.amount, 450.0);
      expect(result.direction, 'debit');
      expect(result.merchant, 'SWIGGY');
      expect(result.bank, 'HDFC');
      expect(result.accountSuffix, '8832');
      expect(result.date.day, 24);
      expect(result.date.month, 9);
      expect(result.date.year, 2026);
    });

    test('parses HDFC salary/stipend credit alert', () {
      const sms =
          'Rs. 25000.00 credited to HDFC Bank A/C **8832 on 01-09-26 by TECHCORP via NEFT.';
      final result = SmsParser.parse(sms);
      expect(result, isNotNull);
      expect(result!.amount, 25000.0);
      expect(result.direction, 'credit');
      expect(result.merchant, 'TECHCORP');
      expect(result.bank, 'HDFC');
      expect(result.accountSuffix, '8832');
    });

    test('parses HDFC subscription debit alert', () {
      const sms =
          'Alert: Rs 199.00 debited from HDFC Bank A/C **8832 on 14-Sep-26 towards NETFLIX. Bal: Rs 12450.00';
      final result = SmsParser.parse(sms);
      expect(result, isNotNull);
      expect(result!.amount, 199.0);
      expect(result.direction, 'debit');
      expect(result.merchant, 'NETFLIX');
      expect(result.bank, 'HDFC');
    });
  });

  group('SmsParser - SBI (State Bank of India)', () {
    test('parses SBI UPI debit alert', () {
      const sms =
          'Dear SBI User, your A/C ending 4921 has been debited by Rs 380.00 on 22Sep26 transfer to Zomato UPI:4265192849.';
      final result = SmsParser.parse(sms);
      expect(result, isNotNull);
      expect(result!.amount, 380.0);
      expect(result.direction, 'debit');
      expect(result.merchant, 'Zomato');
      expect(result.bank, 'SBI');
      expect(result.accountSuffix, '4921');
    });

    test('parses SBI credit alert', () {
      const sms =
          'Your A/C XXXXXXXX4921 is credited by Rs 25,000.00 on 01Sep26 by TRANSFER from TECHCORP.';
      final result = SmsParser.parse(sms);
      expect(result, isNotNull);
      expect(result!.amount, 25000.0);
      expect(result.direction, 'credit');
      expect(result.merchant, 'TECHCORP');
      expect(result.bank, 'SBI');
      expect(result.accountSuffix, '4921');
    });

    test('parses SBI Rapido rides debit', () {
      const sms =
          'Dear SBI UPI User, A/C ..4921 debited by Rs 150.00 on 20/09/2026 to RAPIDO RIDES UPI Ref no 426312.';
      final result = SmsParser.parse(sms);
      expect(result, isNotNull);
      expect(result!.amount, 150.0);
      expect(result.direction, 'debit');
      expect(result.merchant, 'RAPIDO RIDES');
      expect(result.bank, 'SBI');
    });
  });

  group('SmsParser - ICICI Bank', () {
    test('parses ICICI debit alert with INR prefix', () {
      const sms =
          'Dear Customer, your Acct XX1029 is debited for INR 1,250.00 on 18-Sep-26 towards CULT FIT. UPI Ref: 426219.';
      final result = SmsParser.parse(sms);
      expect(result, isNotNull);
      expect(result!.amount, 1250.0);
      expect(result.direction, 'debit');
      expect(result.merchant, 'CULT FIT');
      expect(result.bank, 'ICICI');
      expect(result.accountSuffix, '1029');
    });

    test('parses ICICI credit alert', () {
      const sms =
          'Acct XX1029 credited with INR 5,000.00 on 15-Sep-26 by AAYAN SHAIKH UPI Ref 426019.';
      final result = SmsParser.parse(sms);
      expect(result, isNotNull);
      expect(result!.amount, 5000.0);
      expect(result.direction, 'credit');
      expect(result.merchant, 'AAYAN SHAIKH');
      expect(result.bank, 'ICICI');
    });

    test('parses ICICI Card spent alert at Amazon', () {
      const sms =
          'INR 350.00 spent on ICICI Bank Card ending 5012 at AMAZON INDIA on 12-Sep-26.';
      final result = SmsParser.parse(sms);
      expect(result, isNotNull);
      expect(result!.amount, 350.0);
      expect(result.direction, 'debit');
      expect(result.merchant, 'AMAZON INDIA');
      expect(result.bank, 'ICICI');
      expect(result.accountSuffix, '5012');
    });
  });

  group('SmsParser - Generic UPI & Multiple SMS', () {
    test('parses generic UPI paid message', () {
      const sms = 'Paid Rs. 120 to Chai Point using UPI on 25-09-2026. Txn ID 4269123847.';
      final result = SmsParser.parse(sms);
      expect(result, isNotNull);
      expect(result!.amount, 120.0);
      expect(result.direction, 'debit');
      expect(result.merchant, 'Chai Point');
    });

    test('parses generic GPay received message', () {
      const sms = 'Received Rs. 1,000 from Rohit on 26-09-2026 via Google Pay.';
      final result = SmsParser.parse(sms);
      expect(result, isNotNull);
      expect(result!.amount, 1000.0);
      expect(result.direction, 'credit');
      expect(result.merchant, 'Rohit');
    });

    test('parses generic debited message with info: prefix', () {
      const sms = 'Rs 850 debited from A/C *1234 on 21-09-26 info: BLINKIT.';
      final result = SmsParser.parse(sms);
      expect(result, isNotNull);
      expect(result!.amount, 850.0);
      expect(result.direction, 'debit');
      expect(result.merchant, 'BLINKIT');
    });

    test('parses multiple SMS messages in batch while filtering OTPs', () {
      const multiSms = '''
Sent Rs.450.00 from HDFC Bank A/C **8832 to SWIGGY on 24-09-26 via UPI Ref 426812839401.

Dear Customer, OTP for your txn of INR 1,500.00 is 492018. Do NOT share with anyone.

Dear SBI User, your A/C ending 4921 has been debited by Rs 380.00 on 22Sep26 transfer to Zomato UPI:4265192849.

INR 350.00 spent on ICICI Bank Card ending 5012 at AMAZON INDIA on 12-Sep-26.
''';
      final results = SmsParser.parseMultiple(multiSms);
      expect(results.length, 3); // 4 items minus 1 OTP = 3 parsed
      expect(results[0].merchant, 'SWIGGY');
      expect(results[1].merchant, 'Zomato');
      expect(results[2].merchant, 'AMAZON INDIA');
    });

    test('returns null on empty or gibberish text', () {
      expect(SmsParser.parse(''), isNull);
      expect(SmsParser.parse('Hey, how are you doing today?'), isNull);
    });
  });
}
