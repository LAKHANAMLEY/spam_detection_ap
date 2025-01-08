import 'package:spam_delection_app/lib.dart';

class MessagesDetail extends StatelessWidget {
  final SmsMessage? sms;
  const MessagesDetail({super.key, this.sms});

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as MessagesDetail;
    var sms = arg.sms;
    return Scaffold(
      appBar: CustomAppBar(
        title: sms?.sender,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => MessageView(
          sms: sms,
        ),
      ),
    );
  }
}

class MessageView extends StatelessWidget {
  final SmsMessage? sms;
  const MessageView({super.key, this.sms});

  @override
  Widget build(BuildContext context) {
    const double radius = 10;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: sms?.kind == SmsMessageKind.sent
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(5),
              constraints: BoxConstraints(maxWidth: mq(context).width * .8),
              // width: mq(context).width * .8,
              decoration: BoxDecoration(
                color: sms?.kind == SmsMessageKind.sent
                    ? AppColor.orangeColor
                    : Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  topLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                ),
              ),
              child: Text(sms?.body ?? "")),
          // Text(
          //   sms?.dateSent?.formatRelativeDateTime() ?? "",
          //   style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          // ),
          Text(
            sms?.date?.formatRelativeDateTime() ?? "",
            style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
