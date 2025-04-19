import 'package:spam_delection_app/lib.dart';

//
// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: AppColor.darkPurpleColor,
//       child: ListView(
//         children: [
//           DrawerHeader(child: Image.asset(IconConstants.icBroadLogo)),
//           ListTile(
//             onTap: () {
//               Navigator.pushNamed(context, AppRoutes.planList);
//             },
//             //leading: const Icon(Icons.workspace_premium, color: Colors.white),
//             leading: Image.asset(
//               IconConstants.icPremiumData,
//               scale: 4,
//               color: Colors.white,
//             ),
//             title: Text(
//               appLocalization(context).subscription,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           BlocConsumer(
//             bloc: sharedPrefBloc,
//             listener: (context, state) {},
//             builder: (context, state) {
//               if (state is GetUserDataFromLocalState) {
//                 final user = state.user;
//                 final role = user.userRole?.toLowerCase();
//
//                 if (role == "user") {
//                   return Column(
//                     children: [
//                       10.height(),
//                       ListTile(
//                         onTap: () {
//                           Navigator.pushNamed(
//                               context, AppRoutes.familyMemberList);
//                         },
//                         //leading: const Icon(Icons.workspace_premium, color: Colors.white),
//                         leading: Icon(
//                           Icons.family_restroom_sharp,
//                           color: AppColor.whiteColor,
//                         ),
//
//                         title: Text(
//                           appLocalization(context).familyList,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//
//                 if (role == "corporate") {
//                   return Column(
//                     children: [
//                       10.height(),
//                       ListTile(
//                         onTap: () {
//                           Navigator.pushNamed(context, AppRoutes.staffMember);
//                         },
//                         //leading: const Icon(Icons.workspace_premium, color: Colors.white),
//                         leading: Icon(
//                           Icons.corporate_fare_sharp,
//                           color: AppColor.whiteColor,
//                         ),
//
//                         title: Text(
//                           appLocalization(context).staffList,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//               }
//
//               return const SizedBox.shrink(); // fallback for other states
//             },
//           ),
//           ListTile(
//             onTap: () {
//               _showEditOptions(context);
//             },
//             //leading: const Icon(Icons.workspace_premium, color: Colors.white),
//             leading: Icon(
//               Icons.language,
//               color: AppColor.whiteColor,
//             ),
//             title: Text(
//               appLocalization(context).changeLanguage,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               //Navigator.pushNamed(context, AppRoutes.planList);
//             },
//             //leading: const Icon(Icons.workspace_premium, color: Colors.white),
//             leading: Icon(
//               Icons.privacy_tip,
//               color: AppColor.whiteColor,
//             ),
//             title: Text(
//               appLocalization(context).termsAndConditions,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               //Navigator.pushNamed(context, AppRoutes.planList);
//             },
//             //leading: const Icon(Icons.workspace_premium, color: Colors.white),
//             leading: Icon(
//               Icons.privacy_tip,
//               color: AppColor.whiteColor,
//             ),
//             title: Text(
//               appLocalization(context).privacyPolicyTxt,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.pushNamed(context, AppRoutes.contactUS);
//               //Navigator.pushNamed(context, AppRoutes.planList);
//             },
//             //leading: const Icon(Icons.workspace_premium, color: Colors.white),
//             leading: Icon(
//               Icons.contacts_sharp,
//               color: AppColor.whiteColor,
//             ),
//             title: Text(
//               appLocalization(context).contactUS,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           ListTile(
//             onTap: () async {
//               showLogoutDialog(context);
//             },
//             leading: const Icon(Icons.logout, color: Colors.white),
//             title: Text(
//               appLocalization(context).logout,
//               style: const TextStyle(color: Colors.white),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   void _showEditOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 appLocalization(context).changeALanguage,
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               const SizedBox(height: 16.0),
//               FutureBuilder(
//                 future: fetchLanguages(),
//                 builder:
//                     (context, AsyncSnapshot<CountryLanguageResponse> snapshot) {
//                   if (snapshot.hasData) {
//                     var languages = snapshot.data?.languagelist ?? [];
//
//                     return ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: languages.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             leading:
//                                 const Icon(Icons.language, color: Colors.green),
//                             title: Text(languages[index].name ?? ""),
//                             onTap: () {
//                               localizationBloc.add(ChangeLocaleEvent(
//                                   Locale.fromSubtags(
//                                       languageCode:
//                                           languages[index].id ?? "")));
//                               Navigator.pop(context);
//
//                               // Navigator.pop(context);
//                               // Call your gallery function here
//                               //_chooseFromGallery();
//                             },
//                           );
//                         });
//                   }
//                   return const Loader();
//                 },
//               ),
//               const SizedBox(height: 8.0),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text(
//                   appLocalization(context).cancelTxt,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.darkPurpleColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Image.asset(IconConstants.icBroadLogo),
          ),
          _buildListTile(
            context,
            icon: IconConstants.icPremiumData,
            title: appLocalization(context).subscription,
            onTap: () => Navigator.pushNamed(context, AppRoutes.planList),
            isImageIcon: true,
          ),
          _buildListTile(
            context,
            icon: Icons.history,
            title: appLocalization(context).transactions,
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.transactionList),
            isImageIcon: false,
          ),
          BlocConsumer(
            bloc: sharedPrefBloc,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetUserDataFromLocalState) {
                final role = state.user.userRole?.toLowerCase();

                if (role == "user") {
                  return _buildListTile(
                    context,
                    icon: Icons.family_restroom_sharp,
                    title: appLocalization(context).familyList,
                    onTap: () => Navigator.pushNamed(
                        context, AppRoutes.familyMemberList),
                  );
                } else if (role == "corporate") {
                  return _buildListTile(
                    context,
                    icon: Icons.corporate_fare_sharp,
                    title: appLocalization(context).staffList,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.staffMember),
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
          _buildListTile(
            context,
            icon: Icons.language,
            title: appLocalization(context).changeLanguage,
            onTap: () => _showEditOptions(context),
          ),
          _buildListTile(
            context,
            icon: Icons.privacy_tip,
            title: appLocalization(context).termsAndConditions,
            onTap: () {
              // Add terms route or dialog
            },
          ),
          _buildListTile(
            context,
            icon: Icons.privacy_tip,
            title: appLocalization(context).privacyPolicyTxt,
            onTap: () {
              // Add privacy route or dialog
            },
          ),
          _buildListTile(
            context,
            icon: Icons.contacts_sharp,
            title: appLocalization(context).contactUS,
            onTap: () => Navigator.pushNamed(context, AppRoutes.contactUS),
          ),
          _buildListTile(
            context,
            icon: Icons.settings,
            title: appLocalization(context).settings,
            onTap: () => Navigator.pushNamed(context, AppRoutes.setting),
          ),
          _buildListTile(
            context,
            icon: Icons.logout,
            title: appLocalization(context).logout,
            onTap: () => showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required dynamic icon,
    required String title,
    required VoidCallback onTap,
    bool isImageIcon = false,
  }) {
    return ListTile(
      onTap: onTap,
      leading: isImageIcon
          ? Image.asset(
              icon,
              scale: 4,
              color: Colors.white,
            )
          : Icon(icon, color: AppColor.whiteColor),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  void _showEditOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                appLocalization(context).changeALanguage,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16.0),
              FutureBuilder(
                future: fetchLanguages(),
                builder:
                    (context, AsyncSnapshot<CountryLanguageResponse> snapshot) {
                  if (snapshot.hasData) {
                    final languages = snapshot.data?.languagelist ?? [];
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        final lang = languages[index];
                        return ListTile(
                          leading:
                              const Icon(Icons.language, color: Colors.green),
                          title: Text(lang.name ?? ""),
                          onTap: () {
                            localizationBloc.add(
                              ChangeLocaleEvent(Locale.fromSubtags(
                                  languageCode: lang.id ?? "")),
                            );
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                  return const Loader();
                },
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  appLocalization(context).cancelTxt,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
