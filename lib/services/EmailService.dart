import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendMail(String userEmail) async {
  String username = 'compox123@gmail.com';
  String password = 'Morning246';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, "Compox")
    ..recipients.add(userEmail)
    ..subject = 'Compox Purchase'
    ..text = 'Thank you for working with CompoX'
    ..html =
        "<h1>Compox</h1>\n<p>Your items in the cart have been paid for.Thank You for shopping with us</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    print(e);
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
