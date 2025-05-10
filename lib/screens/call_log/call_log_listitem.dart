import 'package:flutter_svg/svg.dart';
import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/utils/call_type_helper/call_type_helpers.dart';

class CallLogListItem extends StatelessWidget {
  final CallLogData callLog;
  final bool showPopupMenuBtn;
  final void Function()? onTap;
  final bool fromDetail;

  const CallLogListItem({
    super.key,
    required this.callLog,
    this.showPopupMenuBtn = true,
    this.onTap,
    this.fromDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
        onTap: onTap ??
            () {
              Navigator.pushNamed(context, AppRoutes.contactDetail,
                  arguments: ContactDetail(
                    contact: ContactData(
                      countryCode: callLog.countryCode,
                      mobileNo: callLog.mobileNo,
                      name: callLog.name,
                      numberType: callLog.callType,
                      id: callLog.contactListId,
                      isSpam: callLog.isSpam,
                      isBlocked: callLog.isBlocked,
                      markspambyuser: callLog.markSpamByUser,
                      callHistory: [callLog],
                      isMarkedSpamByMe: callLog.isMarkSpamByMe,
                    ),
                  ));
            },
        leading: CircleAvatar(
          backgroundColor: AppColor.graphiteColor,
          // backgroundImage: AssetImage(
          //   getIcon(callLog),
          // ),
          child: SvgPicture.asset(
            CallTypeHelper.getSvgImageByCallType(callLog),
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            placeholderBuilder: (context) => Loader(),
          ),
          // child: Image.asset(
          //   getCallTypeImage(callLog),
          // fit: BoxFit.scaleDown,
          // ),
        ),
        // leading: Icon(getCallTypeIcon(callLog.callType),
        //     color: getCallTypeColor(callLog.callType)),
        title: Text(
          fromDetail
              ? callLog.callTime?.formatRelativeDay() ?? ""
              : (callLog.name?.isNotEmpty ?? false)
                  ? callLog.name ?? ""
                  : callLog.countryCode?.isNotEmpty ?? false
                      ? "+${callLog.countryCode} ${callLog.mobileNo ?? ""}"
                      : callLog.mobileNo ?? callLog.id ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: textTheme(context).titleMedium,
        ),
        subtitle: (callLog.callType?.isEmpty ?? true) &&
                (callLog.markSpamByUser == null ||
                    callLog.markSpamByUser == 0) &&
                (callLog.isSpam == null || callLog.isSpam == 0) &&
                (callLog.callDuration == null ||
                    callLog.callDuration!.isEmpty) &&
                (callLog.callTime == null)
            ? null
            : Row(
                children: [
                  if (callLog.callType?.isNotEmpty ?? false)
                    Icon(
                      CallTypeHelper.getCallTypeIcon(callLog.callType),
                      color:
                          CallTypeHelper.getCallTypeIconColor(callLog.callType),
                      size: 15,
                    ),
                  5.width(),
                  if ((callLog.markSpamByUser != null &&
                          callLog.markSpamByUser != 0) ||
                      (callLog.isSpam != null && callLog.isSpam != 0)) ...[
                    Text(
                      "${callLog.markSpamByUser ?? 0} ${appLocalization(context).spamReports}",
                      style: textTheme(context)
                          .bodySmall
                          ?.copyWith(color: Colors.red),
                    )
                  ] else ...[
                    Text(
                      callLog.callType ?? "",
                      style: textTheme(context).bodySmall?.copyWith(
                          color: CallTypeHelper.getCallTypeTextColor(
                              callLog.callType)),
                    ),
                  ],
                  if (callLog.callDuration != null) const Circle(),
                  // 2.width(),
                  Text(
                    callLog.callDuration?.convertInMinSec() ?? "",
                    style: textTheme(context)
                        .bodySmall
                        ?.copyWith(color: Colors.grey),
                  ),
                  if (callLog.callTime != null) const Circle(),

                  Text(
                    callLog.callTime?.formatTime() ?? "",
                    style: textTheme(context)
                        .bodySmall
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
        trailing: !showPopupMenuBtn
            ? null
            : PopupMenuButton(
                padding: EdgeInsets.zero,
                menuPadding: EdgeInsets.zero,
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onSelected: (value) {
                  switch (value) {
                    case 'spam':
                      if (callLog.isMarkSpamByMe) {
                        markSpamBloc.add(
                            RemoveSpamEvent(contactId: callLog.mobileNo ?? ""));
                      } else {
                        showModalBottomSheet(
                          showDragHandle: true,
                          isScrollControlled: true,
                          backgroundColor: AppColor.whiteColor,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0)),
                          ),
                          useSafeArea: true,
                          builder: (_) => ReportView(
                            contact: ContactData(
                              id: callLog.contactListId,
                              mobileNo: callLog.mobileNo,
                              name: callLog.name,
                              isSpam: callLog.isSpam,
                              countryCode: callLog.countryCode,
                            ),
                          ),
                        );
                      }
                      break;

                    case 'block':
                      markSpamBloc.add(BlockUnBlockEvent(
                        contactId: callLog.mobileNo ?? "",
                        comments: callLog.isBlocked == 1
                            ? appLocalization(context).unblock
                            : appLocalization(context).block,
                      ));
                      break;

                    case 'delete':
                      Future.delayed(Duration.zero, () {
                        showCustomDialog(
                          context,
                          dialogType: DialogType.delete,
                          title: appLocalization(context).delete,
                          subTitle: appLocalization(context).areYouWantDelete,
                          showCancelBtn: true,
                          okBtnTxt: appLocalization(context).delete,
                          cancelBtnTxt: appLocalization(context).cancel,
                          okBtnColor: Colors.redAccent,
                          onOkPressed: () {
                            context
                                .read<CallLogDBBloc>()
                                .add(DeleteDBCallLog(callLog.id ?? ""));
                            Navigator.pop(context);
                          },
                        );
                      });
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'spam',
                    child: Text(
                      callLog.isMarkSpamByMe
                          ? appLocalization(context).unmarkSpam
                          : appLocalization(context).reportText,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'block',
                    child: Text(
                      callLog.isBlocked == 1
                          ? appLocalization(context).unblock
                          : appLocalization(context).block,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(appLocalization(context).delete),
                  ),
                ],
              )

        // trailing: Text(callLog.callTime?.formatDateTime() ?? ""),
        );
  }
}
