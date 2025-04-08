import 'package:spam_delection_app/lib.dart';

class MessageView extends StatelessWidget {
  final SmsDetail? sms;

  const MessageView({super.key, this.sms});

  @override
  Widget build(BuildContext context) {
    bool isSentMessage = sms?.messageKind?.toLowerCase() ==
        SmsMessageKind.Sent.name.toLowerCase();
    const double radius = 10;
    return Align(
      alignment: isSentMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        constraints: BoxConstraints(maxWidth: mq(context).width * .8),
        child: Wrap(
          // Use Wrap to size the inner container based on content
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSentMessage
                    ? AppColor.themeOrangeColor
                    : AppColor.whiteColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(radius),
                  bottomRight: const Radius.circular(radius),
                  topLeft: isSentMessage
                      ? const Radius.circular(radius)
                      : const Radius.circular(0),
                  topRight: isSentMessage
                      ? const Radius.circular(0)
                      : const Radius.circular(radius),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sms?.body ?? "",
                    softWrap: true,
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    // crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      if (sms?.isSpam == "1")
                        Text(
                          sms?.spamMessage ?? "",
                          style: textTheme(context)
                              .bodySmall
                              ?.copyWith(color: AppColor.redColor),
                        ),
                      5.width(),
                      Text(
                        sms?.date?.formatTime() ?? "",
                        style: textTheme(context)
                            .bodySmall
                            ?.copyWith(color: AppColor.greyColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
