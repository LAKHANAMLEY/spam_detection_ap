import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/lib.dart';

class DeviceCallLogs extends StatefulWidget {
  final bool? showAppBar;
  final String filterBy;

  const DeviceCallLogs({super.key, this.showAppBar = true, this.filterBy = ""});

  @override
  State<DeviceCallLogs> createState() => _DeviceCallLogsState();
}

class _DeviceCallLogsState extends State<DeviceCallLogs> {
  final searchController = TextEditingController();
  final scrollController = ScrollController();
  List<CallLogData> callLogs = [];
  List<CallLogData> filteredCallLogs = [];

  // bool isVisible = false;
  // final showHideTextFieldBloc = SelectionBloc(SelectBoolState(true));
  final searchBloc = SelectionBloc(SelectStringState(""));

  // callLogsListBloc.add(GetCallLogsEvent());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CallLogDBBloc>().add(LoadDBCallLogs());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as DeviceCallLogs?;
    return Scaffold(
      appBar: (widget.showAppBar ?? arg?.showAppBar ?? false)
          ? CustomAppBar(
              title: appLocalization(context).callLogs,
            )
          : null,
      body: Column(
        children: [
          PermissionWidget(
            permission: Permission.phone,
          ),
          Expanded(
            child: BlocConsumer<CallLogDBBloc, CallLogDBState>(
                listener: (context, callLogDBState) {
              if (callLogDBState is CallLogDBLoaded) {
                callLogs = callLogDBState.callLogs;
                filteredCallLogs = filter("", callLogs);
              }
              if (callLogDBState is CallLogDBError) {
                if (callLogDBState.exception is UnauthorizedException) {
                  // return Text(callLogDBState.toString());
                  sessionExpired(context, callLogDBState.message);
                }
              }
            }, builder: (context, callLogDBState) {
              if (callLogDBState is CallLogDBError) {
                //   if (callLogDBState.exception is PermissionException) {
                //     return Center(
                //         child:
                //             Text(appLocalization(context).permissionNotAllowed));
                //   }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        callLogDBState.message,
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CallLogDBBloc>().add(SyncDBCallLogs());
                        },
                        child: Text(appLocalization(context).sync),
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       context
                      //           .read<CallLogDBBloc>()
                      //           .add(DeleteDBCallLogs());
                      //     },
                      //     child: Text("Delete DB"))
                    ],
                  ),
                );
              }
              if (callLogDBState is CallLogDBInitial) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CallLogDBBloc>().add(SyncDBCallLogs());
                    },
                    child: Text("Load call logs"),
                  ),
                );
              }
              // if (callLogDBState is CallLogDBLoaded) {
              //   callLogs = callLogDBState.callLogs;
              //   filteredCallLogs = filter("", callLogs);
              return BlocConsumer(
                  bloc: markSpamBloc,
                  listener: (context, state) {
                    if (state is MarkSpamState) {
                      if (state.value.statusCode == 200) {
                        showCustomDialog(
                          context,
                          dialogType: DialogType.success,
                          subTitle: state.value.message,
                        );

                        ///TODO: sync only that is marked spam

                        context.read<CallLogDBBloc>().add(SyncDBCallLogs());
                        // callLogsListBloc.add(GetCallLogsEvent());
                      } else if (state.value.statusCode ==
                          HTTPStatusCodes.sessionExpired) {
                        sessionExpired(context, state.value.message ?? "");
                      } else {
                        showCustomDialog(
                          context,
                          dialogType: DialogType.failed,
                          subTitle: state.value.message,
                        );
                      }
                    }
                    if (state is RemoveSpamState) {
                      if (state.value.statusCode == 200) {
                        showCustomDialog(context,
                            dialogType: DialogType.success,
                            subTitle: state.value.message);
                      } else if (state.value.statusCode ==
                          HTTPStatusCodes.sessionExpired) {
                        sessionExpired(context, state.value.message);
                      } else {
                        showCustomDialog(context,
                            dialogType: DialogType.failed,
                            subTitle: state.value.message);
                      }
                      // callLogsListBloc.add(GetCallLogsEvent());
                      context.read<CallLogDBBloc>().add(SyncDBCallLogs());
                      // markSpamBloc.add(GetSpamEvent());
                    }
                    if (state is BlockUnBlockState) {
                      if (state.value.statusCode == 200) {
                        showCustomDialog(context,
                            dialogType: DialogType.success,
                            subTitle: state.value.message);
                      } else if (state.value.statusCode ==
                          HTTPStatusCodes.sessionExpired) {
                        sessionExpired(context, state.value.message);
                      } else {
                        showCustomDialog(context,
                            dialogType: DialogType.failed,
                            subTitle: state.value.message.toString());
                      }
                      // callLogsListBloc.add(GetCallLogsEvent());
                      context.read<CallLogDBBloc>().add(SyncDBCallLogs());

                      // markSpamBloc.add(GetSpamEvent());
                    }
                  },
                  builder: (context, markSpamState) {
                    return Column(
                      children: [
                        CustomTextField(
                          controller: searchController,
                          fillColor: AppColor.whiteColor,
                          prefix: const Icon(
                            Icons.search,
                            color: AppColor.redColor,
                          ),
                          hintText: appLocalization(context).searchMore,
                          //textAlign: TextAlign.center,

                          onChanged: (p0) {
                            // filter();
                            searchBloc.add(SelectStringEvent(p0));
                          },
                          suffix: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  onTap: () {
                                    // callLogsListBloc.add(GetDeviceCallLogEvent());
                                    context
                                        .read<CallLogDBBloc>()
                                        .add(SyncDBCallLogs());
                                  },
                                  child: Text(
                                      appLocalization(context).synCallLogs)),
                              PopupMenuItem(
                                  onTap: () {
                                    // callLogsListBloc.add(DeleteAllCallLogEvent());
                                    context
                                        .read<CallLogDBBloc>()
                                        .add(DeleteAllDBCallLog());
                                  },
                                  child: Text(appLocalization(context)
                                      .deleteAllCallLogs)),
                            ],
                          ),
                        ),
                        if (!(widget.showAppBar ?? arg?.showAppBar ?? false))
                          SizedBox(
                            height: 35,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: ScrollPhysics(),
                              children: [
                                10.width(),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.callLogs,
                                        arguments: DeviceCallLogs(
                                            filterBy: CallType.outgoing.name));
                                  },
                                  label: Text(
                                      appLocalization(context).outgoingCalls,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  icon: Image.asset(
                                    IconConstants.icOutgoingCall,
                                    scale: 2.5,
                                  ),
                                  // icon: const Icon(Icons.contacts_outlined),
                                  // style: ElevatedButton.styleFrom(
                                  //   minimumSize: const Size(20, 40),
                                  // ),
                                ),
                                10.width(),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.callLogs,
                                        arguments: DeviceCallLogs(
                                            filterBy: CallType.incoming.name));
                                  },
                                  label: Text(
                                      appLocalization(context).incomingCalls,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  icon: Image.asset(
                                    IconConstants.icIncomingCall,
                                    scale: 2.5,
                                  ),
                                ),
                                10.width(),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.callLogs,
                                        arguments: DeviceCallLogs(
                                            filterBy: CallType.missed.name));
                                  },
                                  label: Text(
                                      appLocalization(context).missedCalls,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  icon: Image.asset(
                                    IconConstants.icMissCall,
                                    scale: 2.5,
                                  ),
                                ),
                                10.width(),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.blockedCalls);
                                  },
                                  label: Text(
                                      appLocalization(context).blockedCalls,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  icon: Image.asset(
                                    IconConstants.icBlockedCall,
                                    scale: 2.5,
                                  ),
                                ),
                                10.width(),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // callLogsListBloc.add(DeleteAllCallLogEvent());
                                    Future.delayed(Duration.zero, () {
                                      showCustomDialog(context,
                                          dialogType: DialogType.delete,
                                          title: appLocalization(context)
                                              .deleteMember,
                                          subTitle: appLocalization(context)
                                              .areYouWantDelete,
                                          showCancelBtn: true,
                                          okBtnTxt:
                                              appLocalization(context).delete,
                                          cancelBtnTxt:
                                              appLocalization(context).cancel,
                                          okBtnColor: Colors.red,
                                          onOkPressed: () {
                                        context
                                            .read<CallLogDBBloc>()
                                            .add(DeleteAllDBCallLog());
                                        Navigator.pop(context);
                                      });
                                    });
                                  },
                                  label: Text(
                                      appLocalization(context).deleteCalls,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  icon: Image.asset(
                                    IconConstants.icDeleteCall,
                                    color: Colors.red,
                                    scale: 2.5,
                                  ),
                                  // style: ElevatedButton.styleFrom(
                                  //   // elevation: 3,
                                  //   // shape: RoundedRectangleBorder(
                                  //   //     borderRadius: BorderRadius.circular(32.0)),
                                  //   minimumSize: const Size(20, 40),
                                  // ),
                                )
                              ],
                            ),
                          ),
                        Expanded(
                          child: Builder(
                              // bloc: callLogsListBloc,
                              // listener: (context, state) {
                              //   if (state is ApiBlocInitialState) {
                              //     callLogsListBloc.add(GetCallLogsEvent());
                              //   }
                              //   if (state is GetDeviceCallLogState) {
                              //     var deviceCallLogs = state.value;
                              //     callLogs = deviceCallLogs
                              //         .map((e) => CallLogData(
                              //               mobileNo: e.number,
                              //               callDuration: e.duration.toString(),
                              //               name: e.name,
                              //               callType: e.callType?.name,
                              //               callTime: e.timestamp?.toDateTime(),
                              //             ))
                              //         .toList();
                              //     filteredCallLogs = filter("", callLogs);
                              //     callLogsListBloc.add(
                              //         SyncCallLogEvent(callLogs: deviceCallLogs));
                              //   }
                              //   if (state is GetCallLogsState) {
                              //     if (state.value.statusCode == 200) {
                              //       callLogs = state.value.callloglist ?? [];
                              //       filteredCallLogs = filter("", callLogs);
                              //     } else if (state.value.statusCode ==
                              //         HTTPStatusCodes.sessionExpired) {
                              //       sessionExpired(
                              //           context, state.value.message ?? "");
                              //     } else {
                              //       showToast(state.value.message ?? "");
                              //     }
                              //   }
                              //   if (state is SyncCallLogState) {
                              //     if (state.value.statusCode == 200) {
                              //       showToast(state.value.message);
                              //     } else if (state.value.statusCode ==
                              //         HTTPStatusCodes.sessionExpired) {
                              //       sessionExpired(
                              //           context, state.value.message ?? "");
                              //     } else {
                              //       showToast(state.value.message);
                              //     }
                              //     callLogsListBloc.add(GetCallLogsEvent());
                              //   }
                              //   if (state is DeleteAllCallLogState) {
                              //     if (state.value.statusCode == 200) {
                              //       showCustomDialog(context,
                              //           dialogType: DialogType.success,
                              //           subTitle: state.value.message ?? "");
                              //     } else if (state.value.statusCode ==
                              //         HTTPStatusCodes.sessionExpired) {
                              //       sessionExpired(
                              //           context, state.value.message ?? "");
                              //     } else {
                              //       showToast(state.value.message);
                              //     }
                              //     callLogsListBloc.add(GetCallLogsEvent());
                              //   }
                              //   if (state is DeleteCallLogState) {
                              //     if (state.value.statusCode == 200) {
                              //       showCustomDialog(context,
                              //           dialogType: DialogType.success,
                              //           subTitle: state.value.message);
                              //     } else if (state.value.statusCode ==
                              //         HTTPStatusCodes.sessionExpired) {
                              //       sessionExpired(context, state.value.message);
                              //     } else {
                              //       showCustomDialog(context,
                              //           dialogType: DialogType.failed,
                              //           subTitle: state.value.message.toString());
                              //     }
                              //     callLogsListBloc.add(GetCallLogsEvent());
                              //     // markSpamBloc.add(GetSpamEvent());
                              //   }
                              // },
                              builder: (context) {
                            // if (state is GetCallLogsState) {

                            // if (filteredCallLogs.isEmpty) {
                            //   return Center(
                            //       child:
                            //           Text(appLocalization(context).noContacts));
                            // }
                            return ModalProgressHUD(
                                inAsyncCall: //state is ApiLoadingState ||
                                    markSpamState is ApiLoadingState,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BlocConsumer(
                                      bloc: searchBloc,
                                      listener: (context, state) {
                                        if (state is SelectStringState) {
                                          filteredCallLogs = filter(
                                              state.value ?? "", callLogs);
                                        }
                                      },
                                      builder: (context, searchState) {
                                        return (filteredCallLogs.isEmpty &&
                                                searchController
                                                    .text.isNotEmpty)
                                            ? SizedBox(
                                                height: 80,
                                                child: CallLogListItem(
                                                    // showPopupMenuBtn: false,
                                                    callLog: CallLogData(
                                                  mobileNo:
                                                      searchController.text,
                                                )),
                                              )
                                            // Center(
                                            //     child: Text(appLocalization(context)
                                            //         .noData),
                                            //   )
                                            : (callLogDBState
                                                        is CallLogDBLoading &&
                                                    filteredCallLogs.isEmpty)
                                                ? Loader()
                                                : filteredCallLogs.isEmpty
                                                    ? Center(
                                                        child: Text(
                                                            appLocalization(
                                                                    context)
                                                                .noData),
                                                      )
                                                    : ListView.builder(
                                                        shrinkWrap: true,
                                                        controller:
                                                            scrollController,
                                                        itemCount:
                                                            filteredCallLogs
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) =>
                                                                CallLogListItem(
                                                                  callLog:
                                                                      filteredCallLogs[
                                                                          index],
                                                                ));
                                      }),
                                ));
                            // }
                            // return const Loader();
                          }),
                        ),
                      ],
                    );
                  });
              // }
              // return Loader();
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.darkPurpleColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Image.asset(
            IconConstants.icDialPad,
            scale: 16,
            color: AppColor.whiteColor,
          ),
          onPressed: () {
            // Navigator.pushNamed(context, AppRoutes.dialPadScreen);
            showModalBottomSheet(
                showDragHandle: true,

                // enableDrag: true,
                isScrollControlled: true,
                backgroundColor: AppColor.whiteColor,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                useSafeArea: true,
                builder: (BuildContext context) {
                  return const DialPad();
                });
          }),
    );
  }

  List<CallLogData> filter(String searchText, List<CallLogData> callLogs) {
    return callLogs
        .where((e) =>
            ((e.name?.toLowerCase().contains(searchText.toLowerCase()) ??
                    false) ||
                (e.mobileNo?.toLowerCase().contains(searchText.toLowerCase()) ??
                    false)) &&
            (e.callType
                    ?.toLowerCase()
                    .contains(widget.filterBy.toLowerCase() ?? "") ??
                false))
        .toList();
    // setState(() {});
  }
}

// class ActionButton extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final void Function()? onTap;
//
//   const ActionButton({
//     super.key,
//     required this.label,
//     required this.icon,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min, // Ensures buttons fit the row properly
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundColor: Colors.grey.shade300,
//             child: Icon(icon,
//                 color: AppColor.redColor, size: 28), // Icon size adjusted
//           ),
//           const SizedBox(height: 8),
//           DefaultTextStyle(
//             style: const TextStyle(
//                 color: AppColor.primaryColor,
//                 fontSize: 12,
//                 fontFamily: AppFont.fontFamily,
//                 fontWeight: FontWeight.w600),
//             child: Text(label),
//           )
//         ],
//       ),
//     );
//   }
// }
