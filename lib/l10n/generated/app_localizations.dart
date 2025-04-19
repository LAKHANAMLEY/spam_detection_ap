import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @aadharCard.
  ///
  /// In en, this message translates to:
  /// **'Aadhar card'**
  String get aadharCard;

  /// No description provided for @acceptedHere.
  ///
  /// In en, this message translates to:
  /// **'ACCEPTED HERE'**
  String get acceptedHere;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @accountAddedOn.
  ///
  /// In en, this message translates to:
  /// **'Account added on'**
  String get accountAddedOn;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account created !'**
  String get accountCreated;

  /// No description provided for @accountDetail.
  ///
  /// In en, this message translates to:
  /// **'Account detail'**
  String get accountDetail;

  /// No description provided for @accountHolderName.
  ///
  /// In en, this message translates to:
  /// **'Account holder name'**
  String get accountHolderName;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account number'**
  String get accountNumber;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @addAlternativeEmail.
  ///
  /// In en, this message translates to:
  /// **'Add alternative email'**
  String get addAlternativeEmail;

  /// No description provided for @addBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Add bank account'**
  String get addBankAccount;

  /// No description provided for @addBeneficiary.
  ///
  /// In en, this message translates to:
  /// **'Add beneficiary'**
  String get addBeneficiary;

  /// No description provided for @addContact.
  ///
  /// In en, this message translates to:
  /// **'Add Contact'**
  String get addContact;

  /// No description provided for @addFamilyMember.
  ///
  /// In en, this message translates to:
  /// **'Add Family Member'**
  String get addFamilyMember;

  /// No description provided for @addMember.
  ///
  /// In en, this message translates to:
  /// **'Add Member'**
  String get addMember;

  /// No description provided for @addMemberText.
  ///
  /// In en, this message translates to:
  /// **'Add Member'**
  String get addMemberText;

  /// No description provided for @addPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Add phone number'**
  String get addPhoneNumber;

  /// No description provided for @addStaffMember.
  ///
  /// In en, this message translates to:
  /// **'Add Staff Member'**
  String get addStaffMember;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @address1.
  ///
  /// In en, this message translates to:
  /// **'Address 1'**
  String get address1;

  /// No description provided for @address2.
  ///
  /// In en, this message translates to:
  /// **'Address 2'**
  String get address2;

  /// No description provided for @addressVerification.
  ///
  /// In en, this message translates to:
  /// **'Address verification'**
  String get addressVerification;

  /// No description provided for @addressVerificationDesc.
  ///
  /// In en, this message translates to:
  /// **'In order to completed your KYC, please upload a copy of your address proof'**
  String get addressVerificationDesc;

  /// No description provided for @adminCommision.
  ///
  /// In en, this message translates to:
  /// **'Admin commision: '**
  String get adminCommision;

  /// No description provided for @adminFee.
  ///
  /// In en, this message translates to:
  /// **'Admin fee'**
  String get adminFee;

  /// No description provided for @alignQRCodeWithinFrameToScan.
  ///
  /// In en, this message translates to:
  /// **'Align QR code within frame to scan'**
  String get alignQRCodeWithinFrameToScan;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @allSpamCalls.
  ///
  /// In en, this message translates to:
  /// **'All Spam Calls Are Currently Being Blocked From Calling Your Telephone Number, You May Miss Important Call If The Caller Number Is Flagged By The Network As Spam.'**
  String get allSpamCalls;

  /// No description provided for @allSpamCallsAreCurrentlyBeingBlockedFromCallingYourTelephoneNumberYouMayMissImportantCallIfTheCallerNumberIsFlaggedByTheNetworkAsSpam.
  ///
  /// In en, this message translates to:
  /// **'All spam calls are currently being blocked from calling your telephone number you may miss important call if the caller number is flagged by the network as spam.'**
  String get allSpamCallsAreCurrentlyBeingBlockedFromCallingYourTelephoneNumberYouMayMissImportantCallIfTheCallerNumberIsFlaggedByTheNetworkAsSpam;

  /// No description provided for @allTransactions.
  ///
  /// In en, this message translates to:
  /// **'All transactions'**
  String get allTransactions;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **' Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @alreadyPaid.
  ///
  /// In en, this message translates to:
  /// **'Already paid'**
  String get alreadyPaid;

  /// No description provided for @alternativeEmail.
  ///
  /// In en, this message translates to:
  /// **'Alternative Email'**
  String get alternativeEmail;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @amountRequestedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Amount requested successfully'**
  String get amountRequestedSuccessfully;

  /// No description provided for @amountShouldBeGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Amount should be greater than 0'**
  String get amountShouldBeGreaterThanZero;

  /// No description provided for @anErrorOccurredDuringGoogleSignIn.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during Google Sign-In.'**
  String get anErrorOccurredDuringGoogleSignIn;

  /// No description provided for @areYouWantDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete?'**
  String get areYouWantDelete;

  /// No description provided for @asPerDocument.
  ///
  /// In en, this message translates to:
  /// **'As per document'**
  String get asPerDocument;

  /// No description provided for @authenticationIsRequiredToAccessTheBCTPayApp.
  ///
  /// In en, this message translates to:
  /// **'Authentication is required to access the BCTPay app'**
  String get authenticationIsRequiredToAccessTheBCTPayApp;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get availableBalance;

  /// No description provided for @bCTPayCanHelpYouReachAWideUserBaseWithTargetedCampaignsDesignedToMeetYourBusinessNeeds.
  ///
  /// In en, this message translates to:
  /// **'BCTPay can help you reach a wide user-base with targeted campaigns designed to meet your business needs.'**
  String get bCTPayCanHelpYouReachAWideUserBaseWithTargetedCampaignsDesignedToMeetYourBusinessNeeds;

  /// No description provided for @bCTPayIsLocked.
  ///
  /// In en, this message translates to:
  /// **'BCTPay is locked'**
  String get bCTPayIsLocked;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @backImage.
  ///
  /// In en, this message translates to:
  /// **'Back image'**
  String get backImage;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @balanceBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'You will go to the accounts list for checking balance by pressing Balance button.'**
  String get balanceBtnDescription;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @bankCode.
  ///
  /// In en, this message translates to:
  /// **'Bank code'**
  String get bankCode;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank name'**
  String get bankName;

  /// No description provided for @bankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank transfer'**
  String get bankTransfer;

  /// No description provided for @banksAndWallets.
  ///
  /// In en, this message translates to:
  /// **'Banks & Wallets'**
  String get banksAndWallets;

  /// No description provided for @bctPayFee.
  ///
  /// In en, this message translates to:
  /// **'BCTPay fee'**
  String get bctPayFee;

  /// No description provided for @beneficiaryDetail.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary detail'**
  String get beneficiaryDetail;

  /// No description provided for @beneficiaryList.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary list'**
  String get beneficiaryList;

  /// No description provided for @beneficiaryName.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary name'**
  String get beneficiaryName;

  /// No description provided for @biggestScholarshipCandidates.
  ///
  /// In en, this message translates to:
  /// **'Biggest scholarship test for Gate candidates.'**
  String get biggestScholarshipCandidates;

  /// No description provided for @billers.
  ///
  /// In en, this message translates to:
  /// **'Billers'**
  String get billers;

  /// No description provided for @billsNSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Bills & Subscriptions'**
  String get billsNSubscriptions;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @blockAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Block all scam, telemarketing and fraud calls thanks to AI -blocking accuracy.'**
  String get blockAccuracy;

  /// No description provided for @blockSms.
  ///
  /// In en, this message translates to:
  /// **'Block SMS'**
  String get blockSms;

  /// No description provided for @blockSmsSpam.
  ///
  /// In en, this message translates to:
  /// **'Block Sms As Spam'**
  String get blockSmsSpam;

  /// No description provided for @blockedCalls.
  ///
  /// In en, this message translates to:
  /// **'Blocked Calls'**
  String get blockedCalls;

  /// No description provided for @blockedNumber.
  ///
  /// In en, this message translates to:
  /// **'Blocked Numbers'**
  String get blockedNumber;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @callHistory.
  ///
  /// In en, this message translates to:
  /// **'Call history'**
  String get callHistory;

  /// No description provided for @callHistoryText.
  ///
  /// In en, this message translates to:
  /// **'Call History'**
  String get callHistoryText;

  /// No description provided for @callLogs.
  ///
  /// In en, this message translates to:
  /// **'Call logs'**
  String get callLogs;

  /// No description provided for @callProtection.
  ///
  /// In en, this message translates to:
  /// **'Call Protection'**
  String get callProtection;

  /// No description provided for @callSMSBundle.
  ///
  /// In en, this message translates to:
  /// **'Call & SMS Bundle'**
  String get callSMSBundle;

  /// No description provided for @calls.
  ///
  /// In en, this message translates to:
  /// **'Calls'**
  String get calls;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancelText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelText;

  /// No description provided for @cancelTxt.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelTxt;

  /// No description provided for @cantAddMoreAccountsForThisBankYouHaveReachedTheLimit.
  ///
  /// In en, this message translates to:
  /// **'Can\'t add more accounts for this bank. You\'ve reached the limit.'**
  String get cantAddMoreAccountsForThisBankYouHaveReachedTheLimit;

  /// No description provided for @capture.
  ///
  /// In en, this message translates to:
  /// **'Capture'**
  String get capture;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @changeALanguage.
  ///
  /// In en, this message translates to:
  /// **'Change a Language'**
  String get changeALanguage;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @changeSecurity.
  ///
  /// In en, this message translates to:
  /// **'Change Security Pin'**
  String get changeSecurity;

  /// No description provided for @checkBalance.
  ///
  /// In en, this message translates to:
  /// **'Check balance'**
  String get checkBalance;

  /// No description provided for @checkBalanceBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Check Wallet balance as well as bank account balance or you can manage your accounts like you can add, active, inactive, set primary account or you can delete account.'**
  String get checkBalanceBtnDescription;

  /// No description provided for @chooseGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseGallery;

  /// No description provided for @chooseOption.
  ///
  /// In en, this message translates to:
  /// **'Choose an option'**
  String get chooseOption;

  /// No description provided for @chooseYourPlan.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Plan '**
  String get chooseYourPlan;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @clearAllNotifications.
  ///
  /// In en, this message translates to:
  /// **'Clear all notifications'**
  String get clearAllNotifications;

  /// No description provided for @clientId.
  ///
  /// In en, this message translates to:
  /// **'Client ID'**
  String get clientId;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @closeQuery.
  ///
  /// In en, this message translates to:
  /// **'Close query'**
  String get closeQuery;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company name'**
  String get companyName;

  /// No description provided for @completeMth.
  ///
  /// In en, this message translates to:
  /// **'\$14.99/mth'**
  String get completeMth;

  /// No description provided for @completeProtectionBundle.
  ///
  /// In en, this message translates to:
  /// **'Complete Protection Bundle'**
  String get completeProtectionBundle;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirmContactDialogDesc.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the contact number'**
  String get confirmContactDialogDesc;

  /// No description provided for @confirmNewPass.
  ///
  /// In en, this message translates to:
  /// **'Confirm new Password'**
  String get confirmNewPass;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @confirmSecurityPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm security pin'**
  String get confirmSecurityPin;

  /// No description provided for @congratulationsCreated.
  ///
  /// In en, this message translates to:
  /// **'Congratulations, your account has been successfully created.'**
  String get congratulationsCreated;

  /// No description provided for @congratulationsSuccessfullyCreated.
  ///
  /// In en, this message translates to:
  /// **'Congratulations, your account has been successfully created.'**
  String get congratulationsSuccessfullyCreated;

  /// No description provided for @congratulationsYourAccountHasBeenSuccessfullyCreated.
  ///
  /// In en, this message translates to:
  /// **'Congratulations, your account has been successfully created.'**
  String get congratulationsYourAccountHasBeenSuccessfullyCreated;

  /// No description provided for @congratulationsYourAccountHasBeenSuccessfullyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Congratulations, your account has been successfully updated.'**
  String get congratulationsYourAccountHasBeenSuccessfullyUpdated;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contact;

  /// No description provided for @contactList.
  ///
  /// In en, this message translates to:
  /// **'Contact List'**
  String get contactList;

  /// No description provided for @contactPermission.
  ///
  /// In en, this message translates to:
  /// **'Contact permission'**
  String get contactPermission;

  /// No description provided for @contactText.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactText;

  /// No description provided for @contactUS.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUS;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// No description provided for @contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contacts;

  /// No description provided for @continuePurchase.
  ///
  /// In en, this message translates to:
  /// **'Continue to Purchase'**
  String get continuePurchase;

  /// No description provided for @continueTxt.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueTxt;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @corporateEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Corporate Edit Profile'**
  String get corporateEditProfile;

  /// No description provided for @corporateID.
  ///
  /// In en, this message translates to:
  /// **'Corporate ID'**
  String get corporateID;

  /// No description provided for @corporateName.
  ///
  /// In en, this message translates to:
  /// **'Corporate Name'**
  String get corporateName;

  /// No description provided for @corporateProtection.
  ///
  /// In en, this message translates to:
  /// **'Corporate Protection'**
  String get corporateProtection;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @countryCode.
  ///
  /// In en, this message translates to:
  /// **'Country code'**
  String get countryCode;

  /// No description provided for @coupons.
  ///
  /// In en, this message translates to:
  /// **'Coupons'**
  String get coupons;

  /// No description provided for @crnId.
  ///
  /// In en, this message translates to:
  /// **'Crn Id'**
  String get crnId;

  /// No description provided for @currentPass.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPass;

  /// No description provided for @currentSecurityPin.
  ///
  /// In en, this message translates to:
  /// **'Current security pin'**
  String get currentSecurityPin;

  /// No description provided for @customerId.
  ///
  /// In en, this message translates to:
  /// **'Customer ID'**
  String get customerId;

  /// No description provided for @cylinder.
  ///
  /// In en, this message translates to:
  /// **'Cylinder'**
  String get cylinder;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @dataBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore purchasing data packages before your visit to potentially benefit from discounted rates.'**
  String get dataBtnDescription;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @dearApplicantToday.
  ///
  /// In en, this message translates to:
  /// **'Dear Applicant,the last date to apply today.'**
  String get dearApplicantToday;

  /// No description provided for @dearCustomerMissedCall.
  ///
  /// In en, this message translates to:
  /// **'Dear Customer, You have one missed call.'**
  String get dearCustomerMissedCall;

  /// No description provided for @dearUserShortlisted.
  ///
  /// In en, this message translates to:
  /// **'Dear User your profile is shortlisted.'**
  String get dearUserShortlisted;

  /// No description provided for @debitedFrom.
  ///
  /// In en, this message translates to:
  /// **'Debited from'**
  String get debitedFrom;

  /// No description provided for @defaultPhone.
  ///
  /// In en, this message translates to:
  /// **'Default Phone App'**
  String get defaultPhone;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete all'**
  String get deleteAll;

  /// No description provided for @deleteAllCallLogs.
  ///
  /// In en, this message translates to:
  /// **'Delete All Call Logs'**
  String get deleteAllCallLogs;

  /// No description provided for @deleteCallLogs.
  ///
  /// In en, this message translates to:
  /// **'Delete call logs'**
  String get deleteCallLogs;

  /// No description provided for @deleteCalls.
  ///
  /// In en, this message translates to:
  /// **'Delete all Calls'**
  String get deleteCalls;

  /// No description provided for @deleteConversation.
  ///
  /// In en, this message translates to:
  /// **'Delete Conversation'**
  String get deleteConversation;

  /// No description provided for @deleteMember.
  ///
  /// In en, this message translates to:
  /// **'Delete Member'**
  String get deleteMember;

  /// No description provided for @deleteStaffMember.
  ///
  /// In en, this message translates to:
  /// **'Delete Staff Member'**
  String get deleteStaffMember;

  /// No description provided for @deleteText.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteText;

  /// No description provided for @deleteTxt.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteTxt;

  /// No description provided for @deletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Deleted successfully!'**
  String get deletedSuccessfully;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description: '**
  String get description;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @developerModeDialogDiscription.
  ///
  /// In en, this message translates to:
  /// **'Developer mode is enabled, please disable to access the BCTPay app'**
  String get developerModeDialogDiscription;

  /// No description provided for @didReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Did\'t recieve Code?'**
  String get didReceiveCode;

  /// No description provided for @didTxt.
  ///
  /// In en, this message translates to:
  /// **'Did\'t recieve Code?'**
  String get didTxt;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @doYouReallyWantToDeleteThisAccount.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this account ?'**
  String get doYouReallyWantToDeleteThisAccount;

  /// No description provided for @doYouReallyWantToExitTheApp.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to exit the app ?'**
  String get doYouReallyWantToExitTheApp;

  /// No description provided for @doYouReallyWantToLogout.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to logout ?'**
  String get doYouReallyWantToLogout;

  /// No description provided for @doYouReallyWantToUpdateProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to update profile image ?'**
  String get doYouReallyWantToUpdateProfileImage;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dob;

  /// No description provided for @docIdNumber.
  ///
  /// In en, this message translates to:
  /// **'Document ID number'**
  String get docIdNumber;

  /// No description provided for @docType.
  ///
  /// In en, this message translates to:
  /// **'Doc type'**
  String get docType;

  /// No description provided for @documentType.
  ///
  /// In en, this message translates to:
  /// **'Document type'**
  String get documentType;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @dontWorryItHappensPleaseEnterTheAddressAssociatedWithYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry! it happens. Please enter the adress associated with your account.'**
  String get dontWorryItHappensPleaseEnterTheAddressAssociatedWithYourAccount;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @drawerBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Get list of settings in the side menu.'**
  String get drawerBtnDescription;

  /// No description provided for @drivingLicence.
  ///
  /// In en, this message translates to:
  /// **'Driving licence'**
  String get drivingLicence;

  /// No description provided for @dth.
  ///
  /// In en, this message translates to:
  /// **'DTH'**
  String get dth;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get dueDate;

  /// No description provided for @dueOn.
  ///
  /// In en, this message translates to:
  /// **'Due on'**
  String get dueOn;

  /// No description provided for @easiestWayToManage.
  ///
  /// In en, this message translates to:
  /// **'Easiest way to manage'**
  String get easiestWayToManage;

  /// No description provided for @editContact.
  ///
  /// In en, this message translates to:
  /// **'Edit Contact'**
  String get editContact;

  /// No description provided for @editCorporateProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Corporate Profile'**
  String get editCorporateProfile;

  /// No description provided for @editMember.
  ///
  /// In en, this message translates to:
  /// **'Edit Member'**
  String get editMember;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @editSecurityPin.
  ///
  /// In en, this message translates to:
  /// **'Edit security pin'**
  String get editSecurityPin;

  /// No description provided for @editStaffMember.
  ///
  /// In en, this message translates to:
  /// **'Edit Staff Member'**
  String get editStaffMember;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @electricity.
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get electricity;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @emailProtection.
  ///
  /// In en, this message translates to:
  /// **'Email Protection'**
  String get emailProtection;

  /// No description provided for @enjoy.
  ///
  /// In en, this message translates to:
  /// **'Enjoy'**
  String get enjoy;

  /// No description provided for @enjoyMember.
  ///
  /// In en, this message translates to:
  /// **'Enjoy all the benefits of being an explorer member'**
  String get enjoyMember;

  /// No description provided for @enterAccountHolderName.
  ///
  /// In en, this message translates to:
  /// **'Enter account holder name'**
  String get enterAccountHolderName;

  /// No description provided for @enterAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter account number'**
  String get enterAccountNumber;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter address'**
  String get enterAddress;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @enterBankCode.
  ///
  /// In en, this message translates to:
  /// **'Enter bank code'**
  String get enterBankCode;

  /// No description provided for @enterBankName.
  ///
  /// In en, this message translates to:
  /// **'Enter bank name'**
  String get enterBankName;

  /// No description provided for @enterBeneficiaryName.
  ///
  /// In en, this message translates to:
  /// **'Enter beneficiary name'**
  String get enterBeneficiaryName;

  /// No description provided for @enterCity.
  ///
  /// In en, this message translates to:
  /// **'Enter city'**
  String get enterCity;

  /// No description provided for @enterClientId.
  ///
  /// In en, this message translates to:
  /// **'Enter client ID'**
  String get enterClientId;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6 digit code that you received on your email'**
  String get enterCode;

  /// No description provided for @enterConfirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm new password'**
  String get enterConfirmNewPassword;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password'**
  String get enterConfirmPassword;

  /// No description provided for @enterCountry.
  ///
  /// In en, this message translates to:
  /// **'Enter country'**
  String get enterCountry;

  /// No description provided for @enterDOB.
  ///
  /// In en, this message translates to:
  /// **'Enter DOB'**
  String get enterDOB;

  /// No description provided for @enterDocId.
  ///
  /// In en, this message translates to:
  /// **'Enter document ID number'**
  String get enterDocId;

  /// No description provided for @enterEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get enterEmailAddress;

  /// No description provided for @enterInstitutionCode.
  ///
  /// In en, this message translates to:
  /// **'Enter institution code'**
  String get enterInstitutionCode;

  /// No description provided for @enterInstitutionName.
  ///
  /// In en, this message translates to:
  /// **'Enter institution name'**
  String get enterInstitutionName;

  /// No description provided for @enterMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter message'**
  String get enterMessage;

  /// No description provided for @enterMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter mobile number'**
  String get enterMobileNumber;

  /// No description provided for @enterMomoId.
  ///
  /// In en, this message translates to:
  /// **'Enter MOMO ID'**
  String get enterMomoId;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPassword;

  /// No description provided for @enterOTPSent.
  ///
  /// In en, this message translates to:
  /// **'Enter the OTP Sent to'**
  String get enterOTPSent;

  /// No description provided for @enterOldPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter old password'**
  String get enterOldPassword;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @enterPaymentNote.
  ///
  /// In en, this message translates to:
  /// **'Enter payment note'**
  String get enterPaymentNote;

  /// No description provided for @enterPhoneScreenLockPatternPINPasswordOrFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone screen lock pattern, PIN, password or fingerprint'**
  String get enterPhoneScreenLockPatternPINPasswordOrFingerprint;

  /// No description provided for @enterPinCode.
  ///
  /// In en, this message translates to:
  /// **'Enter pincode'**
  String get enterPinCode;

  /// No description provided for @enterTxnId.
  ///
  /// In en, this message translates to:
  /// **'Enter transaction ID'**
  String get enterTxnId;

  /// No description provided for @enterVerificationProcess.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address for the verificationm process. We will send 4 digite code to your email.'**
  String get enterVerificationProcess;

  /// No description provided for @enterWalletPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter wallet phone number'**
  String get enterWalletPhoneNumber;

  /// No description provided for @enterYourFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get enterYourFirstName;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourFullName;

  /// No description provided for @enterYourLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get enterYourLastName;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @exploreHomePage.
  ///
  /// In en, this message translates to:
  /// **'Explore Home Page'**
  String get exploreHomePage;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed...'**
  String get failed;

  /// No description provided for @familyList.
  ///
  /// In en, this message translates to:
  /// **'Family List'**
  String get familyList;

  /// No description provided for @familySharing.
  ///
  /// In en, this message translates to:
  /// **'Family Sharing'**
  String get familySharing;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @faster.
  ///
  /// In en, this message translates to:
  /// **'Faster'**
  String get faster;

  /// No description provided for @feeDetails.
  ///
  /// In en, this message translates to:
  /// **'Fee details'**
  String get feeDetails;

  /// No description provided for @fees.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get fees;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @fileDownloaded.
  ///
  /// In en, this message translates to:
  /// **'File downloaded'**
  String get fileDownloaded;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @forYou.
  ///
  /// In en, this message translates to:
  /// **'For you'**
  String get forYou;

  /// No description provided for @forgotPassDetails.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address for the verification process. We will send 6 digit code to your email or sms.'**
  String get forgotPassDetails;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordText.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordText;

  /// No description provided for @freeTrialForNewSubscribers.
  ///
  /// In en, this message translates to:
  /// **'3 days free trial for new subscribers only'**
  String get freeTrialForNewSubscribers;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @fromNowOnYouArePartOfUs.
  ///
  /// In en, this message translates to:
  /// **'From now on you are part of us!'**
  String get fromNowOnYouArePartOfUs;

  /// No description provided for @fromUs.
  ///
  /// In en, this message translates to:
  /// **'from now on, you are part of us!'**
  String get fromUs;

  /// No description provided for @frontImage.
  ///
  /// In en, this message translates to:
  /// **'Front image'**
  String get frontImage;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @getOtp.
  ///
  /// In en, this message translates to:
  /// **'Get OTP'**
  String get getOtp;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @giftCard.
  ///
  /// In en, this message translates to:
  /// **'Gift card'**
  String get giftCard;

  /// No description provided for @giftCardBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the specific gift card brand and desired value based on your needs and preferences.'**
  String get giftCardBtnDescription;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @googleSignFailedPleaseAgain.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In failed. Please try again.'**
  String get googleSignFailedPleaseAgain;

  /// No description provided for @grossTotal.
  ///
  /// In en, this message translates to:
  /// **'Gross total'**
  String get grossTotal;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Have an Account'**
  String get haveAccount;

  /// No description provided for @haveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Have an account?'**
  String get haveAnAccount;

  /// No description provided for @helloThereSignInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Hello there sign in to continue'**
  String get helloThereSignInToContinue;

  /// No description provided for @helpNSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get helpNSupport;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @historyBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'You will go to the Transaction history list by pressing History button.'**
  String get historyBtnDescription;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @homeBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'You will go to the Dashboard by pressing Home button.'**
  String get homeBtnDescription;

  /// No description provided for @homeFax.
  ///
  /// In en, this message translates to:
  /// **'Home Fax'**
  String get homeFax;

  /// No description provided for @homeText.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeText;

  /// No description provided for @howMuchYouWantToSend.
  ///
  /// In en, this message translates to:
  /// **'How much you want to send ?'**
  String get howMuchYouWantToSend;

  /// No description provided for @idVerificationDesc.
  ///
  /// In en, this message translates to:
  /// **'In order to completed your KYC, please upload a copy of your identity document'**
  String get idVerificationDesc;

  /// No description provided for @identityVerification.
  ///
  /// In en, this message translates to:
  /// **'Identity verification'**
  String get identityVerification;

  /// No description provided for @importQRCode.
  ///
  /// In en, this message translates to:
  /// **'Import QR code'**
  String get importQRCode;

  /// No description provided for @inActive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inActive;

  /// No description provided for @inIndiaViewedYourProfileRecently.
  ///
  /// In en, this message translates to:
  /// **'127 people(127 in india) viewed your profile recently'**
  String get inIndiaViewedYourProfileRecently;

  /// No description provided for @includesALetterDigitAndSpecialCharacter.
  ///
  /// In en, this message translates to:
  /// **'Includes a letter, digit, and special character'**
  String get includesALetterDigitAndSpecialCharacter;

  /// No description provided for @incoming.
  ///
  /// In en, this message translates to:
  /// **'Incoming'**
  String get incoming;

  /// No description provided for @incomingCalls.
  ///
  /// In en, this message translates to:
  /// **'Incoming Calls'**
  String get incomingCalls;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @institutionCode.
  ///
  /// In en, this message translates to:
  /// **'Institution code'**
  String get institutionCode;

  /// No description provided for @institutionName.
  ///
  /// In en, this message translates to:
  /// **'Institution name'**
  String get institutionName;

  /// No description provided for @invalidVerificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP or verification failed'**
  String get invalidVerificationFailed;

  /// No description provided for @invoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoice;

  /// No description provided for @invoiceAlreadyPaid.
  ///
  /// In en, this message translates to:
  /// **'Invoice already paid. View payment details'**
  String get invoiceAlreadyPaid;

  /// No description provided for @invoiceDate.
  ///
  /// In en, this message translates to:
  /// **'Invoice date'**
  String get invoiceDate;

  /// No description provided for @invoiceDetail.
  ///
  /// In en, this message translates to:
  /// **'Invoice detail'**
  String get invoiceDetail;

  /// No description provided for @invoiceGeneratedBy.
  ///
  /// In en, this message translates to:
  /// **'Invoice generated by'**
  String get invoiceGeneratedBy;

  /// No description provided for @invoiceItems.
  ///
  /// In en, this message translates to:
  /// **'Invoice items'**
  String get invoiceItems;

  /// No description provided for @invoiceNote.
  ///
  /// In en, this message translates to:
  /// **'Invoice note'**
  String get invoiceNote;

  /// No description provided for @issuedOn.
  ///
  /// In en, this message translates to:
  /// **'Issued on'**
  String get issuedOn;

  /// No description provided for @joinedUsBefore.
  ///
  /// In en, this message translates to:
  /// **'Joined us before ?'**
  String get joinedUsBefore;

  /// No description provided for @kyc.
  ///
  /// In en, this message translates to:
  /// **'KYC'**
  String get kyc;

  /// No description provided for @kycDetails.
  ///
  /// In en, this message translates to:
  /// **'KYC details'**
  String get kycDetails;

  /// No description provided for @kycHistory.
  ///
  /// In en, this message translates to:
  /// **'KYC history'**
  String get kycHistory;

  /// No description provided for @kycNotApprovedDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Your KYC is not approved yet, please update your KYC to make transactions.'**
  String get kycNotApprovedDialogMessage;

  /// No description provided for @kycPending.
  ///
  /// In en, this message translates to:
  /// **'KYC pending'**
  String get kycPending;

  /// No description provided for @kycStatus.
  ///
  /// In en, this message translates to:
  /// **'KYC status'**
  String get kycStatus;

  /// No description provided for @kycType.
  ///
  /// In en, this message translates to:
  /// **'KYC type'**
  String get kycType;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @lastAllTime.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get lastAllTime;

  /// No description provided for @lastDays.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get lastDays;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @lastSixMonths.
  ///
  /// In en, this message translates to:
  /// **'Last 6 months'**
  String get lastSixMonths;

  /// No description provided for @lastThirtyDays.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get lastThirtyDays;

  /// No description provided for @lastThisYear.
  ///
  /// In en, this message translates to:
  /// **'This year'**
  String get lastThisYear;

  /// No description provided for @lastThreeMonths.
  ///
  /// In en, this message translates to:
  /// **'Last 3 months'**
  String get lastThreeMonths;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @leaveUsAMessageAboutYourQuestionsOrInquiriesAndSomeoneFromOurTeamWillBeInTouchSoon.
  ///
  /// In en, this message translates to:
  /// **'Leave us a message about your questions or inquiries and someone from our team will be in touch soon.'**
  String get leaveUsAMessageAboutYourQuestionsOrInquiriesAndSomeoneFromOurTeamWillBeInTouchSoon;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @linkedAccounts.
  ///
  /// In en, this message translates to:
  /// **'Linked accounts'**
  String get linkedAccounts;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Login now'**
  String get loginNow;

  /// No description provided for @loginWithApple.
  ///
  /// In en, this message translates to:
  /// **' Login With Apple'**
  String get loginWithApple;

  /// No description provided for @loginWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Login with email'**
  String get loginWithEmail;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get loginWithGoogle;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @makeOnline.
  ///
  /// In en, this message translates to:
  /// **'Make online'**
  String get makeOnline;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @maximumTransferLimitIs.
  ///
  /// In en, this message translates to:
  /// **'Maximum transfer limit is {code}'**
  String maximumTransferLimitIs(Object code);

  /// No description provided for @meetYourBusiness.
  ///
  /// In en, this message translates to:
  /// **'Meet your business'**
  String get meetYourBusiness;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @messagesSpam.
  ///
  /// In en, this message translates to:
  /// **'Messages moved  to spam'**
  String get messagesSpam;

  /// No description provided for @minimumCharactersRequired.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters are required.'**
  String get minimumCharactersRequired;

  /// No description provided for @minimumOrderValueIs.
  ///
  /// In en, this message translates to:
  /// **'Minimum order value is'**
  String get minimumOrderValueIs;

  /// No description provided for @minimumTransferLimitIs.
  ///
  /// In en, this message translates to:
  /// **'Minimum transfer limit is {code}'**
  String minimumTransferLimitIs(Object code);

  /// No description provided for @missed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get missed;

  /// No description provided for @missedCalls.
  ///
  /// In en, this message translates to:
  /// **'Missed Calls'**
  String get missedCalls;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @mobileNo.
  ///
  /// In en, this message translates to:
  /// **'Mobile No.'**
  String get mobileNo;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get mobileNumber;

  /// No description provided for @mobileNumberDoesntExist.
  ///
  /// In en, this message translates to:
  /// **'Mobile number doesn\'t exist'**
  String get mobileNumberDoesntExist;

  /// No description provided for @mobileOperators.
  ///
  /// In en, this message translates to:
  /// **'Mobile operators'**
  String get mobileOperators;

  /// No description provided for @mobileRecharge.
  ///
  /// In en, this message translates to:
  /// **'Mobile recharge'**
  String get mobileRecharge;

  /// No description provided for @momoId.
  ///
  /// In en, this message translates to:
  /// **'MOMO ID'**
  String get momoId;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get month;

  /// No description provided for @monthlyPlan.
  ///
  /// In en, this message translates to:
  /// **'MONTHLY PLAN'**
  String get monthlyPlan;

  /// No description provided for @moreAvailable.
  ///
  /// In en, this message translates to:
  /// **'More info available'**
  String get moreAvailable;

  /// No description provided for @mtnMoMo.
  ///
  /// In en, this message translates to:
  /// **'MTN MoMo'**
  String get mtnMoMo;

  /// No description provided for @mustLowercaseLetter.
  ///
  /// In en, this message translates to:
  /// **'Must include at least one lowercase letter.'**
  String get mustLowercaseLetter;

  /// No description provided for @mustSpecialCharacter.
  ///
  /// In en, this message translates to:
  /// **'Must include at least one special character.'**
  String get mustSpecialCharacter;

  /// No description provided for @mustUppercaseLetter.
  ///
  /// In en, this message translates to:
  /// **'Must include at least one uppercase letter'**
  String get mustUppercaseLetter;

  /// No description provided for @myBills.
  ///
  /// In en, this message translates to:
  /// **'My bills'**
  String get myBills;

  /// No description provided for @myBlockList.
  ///
  /// In en, this message translates to:
  /// **'My Block List'**
  String get myBlockList;

  /// No description provided for @myContact.
  ///
  /// In en, this message translates to:
  /// **'My contact'**
  String get myContact;

  /// No description provided for @mySubscriptions.
  ///
  /// In en, this message translates to:
  /// **'My subscriptions'**
  String get mySubscriptions;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name: '**
  String get name;

  /// No description provided for @newContact.
  ///
  /// In en, this message translates to:
  /// **'New contact'**
  String get newContact;

  /// No description provided for @newPass.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPass;

  /// No description provided for @newPassConfirmPass.
  ///
  /// In en, this message translates to:
  /// **'New Password and Confirm Password do not match.'**
  String get newPassConfirmPass;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @newSecurityPin.
  ///
  /// In en, this message translates to:
  /// **'New security pin'**
  String get newSecurityPin;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'No account'**
  String get noAccount;

  /// No description provided for @noBeneficiary.
  ///
  /// In en, this message translates to:
  /// **'No beneficiary'**
  String get noBeneficiary;

  /// No description provided for @noCategoriesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No categories available.'**
  String get noCategoriesAvailable;

  /// No description provided for @noContacts.
  ///
  /// In en, this message translates to:
  /// **'No contacts'**
  String get noContacts;

  /// No description provided for @noCountry.
  ///
  /// In en, this message translates to:
  /// **'No country'**
  String get noCountry;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @noDocumentTypeAvailable.
  ///
  /// In en, this message translates to:
  /// **'No document type available'**
  String get noDocumentTypeAvailable;

  /// No description provided for @noKycHistory.
  ///
  /// In en, this message translates to:
  /// **'No KYC history'**
  String get noKycHistory;

  /// No description provided for @noMessages.
  ///
  /// In en, this message translates to:
  /// **'No Messages'**
  String get noMessages;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @noNotificationsText.
  ///
  /// In en, this message translates to:
  /// **'No Notifications'**
  String get noNotificationsText;

  /// No description provided for @noPermissionToUpdateText.
  ///
  /// In en, this message translates to:
  /// **'Looking like you don\'t have permission to update or you have not added mandatory data'**
  String get noPermissionToUpdateText;

  /// No description provided for @noPlans.
  ///
  /// In en, this message translates to:
  /// **'No plans'**
  String get noPlans;

  /// No description provided for @noPrimaryAccount.
  ///
  /// In en, this message translates to:
  /// **'No primary account'**
  String get noPrimaryAccount;

  /// No description provided for @noProviders.
  ///
  /// In en, this message translates to:
  /// **'No providers'**
  String get noProviders;

  /// No description provided for @noQuery.
  ///
  /// In en, this message translates to:
  /// **'No query'**
  String get noQuery;

  /// No description provided for @noRegions.
  ///
  /// In en, this message translates to:
  /// **'No regions'**
  String get noRegions;

  /// No description provided for @noRequest.
  ///
  /// In en, this message translates to:
  /// **'No request'**
  String get noRequest;

  /// No description provided for @noStaff.
  ///
  /// In en, this message translates to:
  /// **'No Staff'**
  String get noStaff;

  /// No description provided for @noThanks.
  ///
  /// In en, this message translates to:
  /// **'No thanks'**
  String get noThanks;

  /// No description provided for @noTransaction.
  ///
  /// In en, this message translates to:
  /// **'No transaction'**
  String get noTransaction;

  /// No description provided for @noValidityFound.
  ///
  /// In en, this message translates to:
  /// **'No validity found'**
  String get noValidityFound;

  /// No description provided for @noWallet.
  ///
  /// In en, this message translates to:
  /// **'No wallet'**
  String get noWallet;

  /// No description provided for @notAMember.
  ///
  /// In en, this message translates to:
  /// **'Not a member ?'**
  String get notAMember;

  /// No description provided for @notActive.
  ///
  /// In en, this message translates to:
  /// **'Not active'**
  String get notActive;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get notFound;

  /// No description provided for @notSpam.
  ///
  /// In en, this message translates to:
  /// **'Not spam'**
  String get notSpam;

  /// No description provided for @notVerified.
  ///
  /// In en, this message translates to:
  /// **'Not verified'**
  String get notVerified;

  /// No description provided for @noteDocFormates.
  ///
  /// In en, this message translates to:
  /// **'Note: Document formates are png, jpg, jpeg'**
  String get noteDocFormates;

  /// No description provided for @notePlatformFeeWillBeImposedOnSenderForThisTransaction.
  ///
  /// In en, this message translates to:
  /// **'Note: Platform fee will be imposed on sender for this transaction.'**
  String get notePlatformFeeWillBeImposedOnSenderForThisTransaction;

  /// No description provided for @notificationList.
  ///
  /// In en, this message translates to:
  /// **'Notifications List'**
  String get notificationList;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'You will go to the Notifications list by pressing Notifications button.'**
  String get notificationsBtnDescription;

  /// No description provided for @numberType.
  ///
  /// In en, this message translates to:
  /// **'Number Type'**
  String get numberType;

  /// No description provided for @ohNoTheOTPTimedOutPleaseRequestANewCodeAndTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Oh no! The OTP timed out. Please request a new code and try again.'**
  String get ohNoTheOTPTimedOutPleaseRequestANewCodeAndTryAgain;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old password'**
  String get oldPassword;

  /// No description provided for @oopsNoInternet.
  ///
  /// In en, this message translates to:
  /// **'OOPS!\nNo internet'**
  String get oopsNoInternet;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @openAccount.
  ///
  /// In en, this message translates to:
  /// **'Open account'**
  String get openAccount;

  /// No description provided for @openAppSetting.
  ///
  /// In en, this message translates to:
  /// **'Open app setting'**
  String get openAppSetting;

  /// No description provided for @openXpressAccount.
  ///
  /// In en, this message translates to:
  /// **'Open Ecobank Xpress account'**
  String get openXpressAccount;

  /// No description provided for @openXpressAccountViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Open an Ecobank Xpress account instantly with BCTPay'**
  String get openXpressAccountViewTitle;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @orTxt.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get orTxt;

  /// No description provided for @orangeMoney.
  ///
  /// In en, this message translates to:
  /// **'Orange Money'**
  String get orangeMoney;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @otherText.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get otherText;

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otp;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **' OTP Verification'**
  String get otpVerification;

  /// No description provided for @outgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get outgoing;

  /// No description provided for @outgoingCalls.
  ///
  /// In en, this message translates to:
  /// **'Outgoing Calls'**
  String get outgoingCalls;

  /// No description provided for @ownedBy.
  ///
  /// In en, this message translates to:
  /// **'Owned by'**
  String get ownedBy;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @paidTo.
  ///
  /// In en, this message translates to:
  /// **'Paid to'**
  String get paidTo;

  /// No description provided for @panCard.
  ///
  /// In en, this message translates to:
  /// **'PAN card'**
  String get panCard;

  /// No description provided for @passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get passport;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordIsNotMatching.
  ///
  /// In en, this message translates to:
  /// **'Password is not matching'**
  String get passwordIsNotMatching;

  /// No description provided for @passwordValid.
  ///
  /// In en, this message translates to:
  /// **'Password is valid.'**
  String get passwordValid;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @payWith.
  ///
  /// In en, this message translates to:
  /// **'Pay with'**
  String get payWith;

  /// No description provided for @payableAmount.
  ///
  /// In en, this message translates to:
  /// **'Payable amount'**
  String get payableAmount;

  /// No description provided for @paymentDate.
  ///
  /// In en, this message translates to:
  /// **'Payment date'**
  String get paymentDate;

  /// No description provided for @paymentDateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Payment date and time'**
  String get paymentDateAndTime;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment details'**
  String get paymentDetails;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @paymentN.
  ///
  /// In en, this message translates to:
  /// **'Payment &'**
  String get paymentN;

  /// No description provided for @paymentNote.
  ///
  /// In en, this message translates to:
  /// **'Payment note'**
  String get paymentNote;

  /// No description provided for @paymentRequests.
  ///
  /// In en, this message translates to:
  /// **'Payment requests'**
  String get paymentRequests;

  /// No description provided for @paymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment status'**
  String get paymentStatus;

  /// No description provided for @paymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment success!'**
  String get paymentSuccess;

  /// No description provided for @permissionNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Permission not allowed'**
  String get permissionNotAllowed;

  /// No description provided for @personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get personal;

  /// No description provided for @personalMth.
  ///
  /// In en, this message translates to:
  /// **'\$7.99/mth'**
  String get personalMth;

  /// No description provided for @personalProtection.
  ///
  /// In en, this message translates to:
  /// **'Personal Protection'**
  String get personalProtection;

  /// No description provided for @phoneAutomaticallySigned.
  ///
  /// In en, this message translates to:
  /// **'Phone number automatically verified and signed in!'**
  String get phoneAutomaticallySigned;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberOps.
  ///
  /// In en, this message translates to:
  /// **'Phone Number(optional)'**
  String get phoneNumberOps;

  /// No description provided for @pinCode.
  ///
  /// In en, this message translates to:
  /// **'Pincode'**
  String get pinCode;

  /// No description provided for @pinNumberMustContainOnlDigits.
  ///
  /// In en, this message translates to:
  /// **'Pin number must contain only digits'**
  String get pinNumberMustContainOnlDigits;

  /// No description provided for @pinNumberMustDigits.
  ///
  /// In en, this message translates to:
  /// **'Pin number must be 6 digits'**
  String get pinNumberMustDigits;

  /// No description provided for @pleasNewPasswordSecure.
  ///
  /// In en, this message translates to:
  /// **'Please enter a new password to secure your account.'**
  String get pleasNewPasswordSecure;

  /// No description provided for @pleaseAcceptTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Please accept Terms & Conditions'**
  String get pleaseAcceptTermsAndConditions;

  /// No description provided for @pleaseActiveYourSubscription.
  ///
  /// In en, this message translates to:
  /// **'Please Active Your Subscription'**
  String get pleaseActiveYourSubscription;

  /// No description provided for @pleaseAddAtleastOneactiveAccount.
  ///
  /// In en, this message translates to:
  /// **'Please add atleast one active account'**
  String get pleaseAddAtleastOneactiveAccount;

  /// No description provided for @pleaseAlternativeEmail.
  ///
  /// In en, this message translates to:
  /// **'Please all alternative email'**
  String get pleaseAlternativeEmail;

  /// No description provided for @pleaseCheckMail.
  ///
  /// In en, this message translates to:
  /// **'Please check your mail'**
  String get pleaseCheckMail;

  /// No description provided for @pleaseCheckYourNetworkConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your network connection.'**
  String get pleaseCheckYourNetworkConnection;

  /// No description provided for @pleaseCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Please enter company name'**
  String get pleaseCompanyName;

  /// No description provided for @pleaseConfirmPass.
  ///
  /// In en, this message translates to:
  /// **'Please enter confirm new password'**
  String get pleaseConfirmPass;

  /// No description provided for @pleaseConfirmSecurityPin.
  ///
  /// In en, this message translates to:
  /// **'Please enter confirm security pin'**
  String get pleaseConfirmSecurityPin;

  /// No description provided for @pleaseCorporateID.
  ///
  /// In en, this message translates to:
  /// **'Please enter your valid Email / Corporate ID'**
  String get pleaseCorporateID;

  /// No description provided for @pleaseCorporateIDText.
  ///
  /// In en, this message translates to:
  /// **'Please enter corporate ID'**
  String get pleaseCorporateIDText;

  /// No description provided for @pleaseCorporateName.
  ///
  /// In en, this message translates to:
  /// **'Please enter corporate name'**
  String get pleaseCorporateName;

  /// No description provided for @pleaseCrnId.
  ///
  /// In en, this message translates to:
  /// **'Please enter Crn ID'**
  String get pleaseCrnId;

  /// No description provided for @pleaseCurrentPass.
  ///
  /// In en, this message translates to:
  /// **'Please enter current password'**
  String get pleaseCurrentPass;

  /// No description provided for @pleaseCurrentSecurityPin.
  ///
  /// In en, this message translates to:
  /// **'Please enter current security pin'**
  String get pleaseCurrentSecurityPin;

  /// No description provided for @pleaseEnterAccountHolderName.
  ///
  /// In en, this message translates to:
  /// **'Please enter account holder name'**
  String get pleaseEnterAccountHolderName;

  /// No description provided for @pleaseEnterAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter account number'**
  String get pleaseEnterAccountNumber;

  /// No description provided for @pleaseEnterBeneficiaryName.
  ///
  /// In en, this message translates to:
  /// **'Please enter beneficiary name'**
  String get pleaseEnterBeneficiaryName;

  /// No description provided for @pleaseEnterCategory.
  ///
  /// In en, this message translates to:
  /// **'Please enter Category'**
  String get pleaseEnterCategory;

  /// No description provided for @pleaseEnterClientID.
  ///
  /// In en, this message translates to:
  /// **'Please enter client ID'**
  String get pleaseEnterClientID;

  /// No description provided for @pleaseEnterComments.
  ///
  /// In en, this message translates to:
  /// **'Please enter any comments'**
  String get pleaseEnterComments;

  /// No description provided for @pleaseEnterFields.
  ///
  /// In en, this message translates to:
  /// **'Please enter all the fields.'**
  String get pleaseEnterFields;

  /// No description provided for @pleaseEnterInstitutionCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter institution code'**
  String get pleaseEnterInstitutionCode;

  /// No description provided for @pleaseEnterMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter message'**
  String get pleaseEnterMessage;

  /// No description provided for @pleaseEnterNumberType.
  ///
  /// In en, this message translates to:
  /// **'Please enter Number Type'**
  String get pleaseEnterNumberType;

  /// No description provided for @pleaseEnterOTP.
  ///
  /// In en, this message translates to:
  /// **'Please enter OTP'**
  String get pleaseEnterOTP;

  /// No description provided for @pleaseEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Phone Number'**
  String get pleaseEnterPhone;

  /// No description provided for @pleaseEnterPosition.
  ///
  /// In en, this message translates to:
  /// **'Please enter position'**
  String get pleaseEnterPosition;

  /// No description provided for @pleaseEnterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid amount'**
  String get pleaseEnterValidAmount;

  /// No description provided for @pleaseEnterValidMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid mobile number'**
  String get pleaseEnterValidMobileNumber;

  /// No description provided for @pleaseEnterValidValue.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid value'**
  String get pleaseEnterValidValue;

  /// No description provided for @pleaseEnterValidWalletPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid wallet phone number'**
  String get pleaseEnterValidWalletPhoneNumber;

  /// No description provided for @pleaseEnterWalletPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter wallet phone number'**
  String get pleaseEnterWalletPhoneNumber;

  /// No description provided for @pleaseEnterYourAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter your address'**
  String get pleaseEnterYourAddress;

  /// No description provided for @pleaseEnterYourCity.
  ///
  /// In en, this message translates to:
  /// **'Please enter your city'**
  String get pleaseEnterYourCity;

  /// No description provided for @pleaseEnterYourConfirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your confirm new password'**
  String get pleaseEnterYourConfirmNewPassword;

  /// No description provided for @pleaseEnterYourConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your confirm password'**
  String get pleaseEnterYourConfirmPassword;

  /// No description provided for @pleaseEnterYourCountry.
  ///
  /// In en, this message translates to:
  /// **'Please enter your country'**
  String get pleaseEnterYourCountry;

  /// No description provided for @pleaseEnterYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get pleaseEnterYourEmailAddress;

  /// No description provided for @pleaseEnterYourFirstName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get pleaseEnterYourFirstName;

  /// No description provided for @pleaseEnterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get pleaseEnterYourFullName;

  /// No description provided for @pleaseEnterYourLastName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name'**
  String get pleaseEnterYourLastName;

  /// No description provided for @pleaseEnterYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your mobile number'**
  String get pleaseEnterYourMobileNumber;

  /// No description provided for @pleaseEnterYourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your new password'**
  String get pleaseEnterYourNewPassword;

  /// No description provided for @pleaseEnterYourOldPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your old password'**
  String get pleaseEnterYourOldPassword;

  /// No description provided for @pleaseEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterYourPassword;

  /// No description provided for @pleaseEnterYourValidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid email address'**
  String get pleaseEnterYourValidEmailAddress;

  /// No description provided for @pleaseEnterZipCode.
  ///
  /// In en, this message translates to:
  /// **'please Enter Zip Code'**
  String get pleaseEnterZipCode;

  /// No description provided for @pleaseFirstName.
  ///
  /// In en, this message translates to:
  /// **'Please enter first name'**
  String get pleaseFirstName;

  /// No description provided for @pleaseLastName.
  ///
  /// In en, this message translates to:
  /// **'Please enter last name'**
  String get pleaseLastName;

  /// No description provided for @pleaseLoginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please login to continue'**
  String get pleaseLoginToContinue;

  /// No description provided for @pleaseNewPass.
  ///
  /// In en, this message translates to:
  /// **'Please enter New password'**
  String get pleaseNewPass;

  /// No description provided for @pleaseNewPinSecure.
  ///
  /// In en, this message translates to:
  /// **'Please enter a new pin to secure your account.'**
  String get pleaseNewPinSecure;

  /// No description provided for @pleaseNewSecurityPin.
  ///
  /// In en, this message translates to:
  /// **'Please enter new security pin'**
  String get pleaseNewSecurityPin;

  /// No description provided for @pleaseRelation.
  ///
  /// In en, this message translates to:
  /// **'Please enter relation'**
  String get pleaseRelation;

  /// No description provided for @pleaseSecureAccount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a new password to secure your account.'**
  String get pleaseSecureAccount;

  /// No description provided for @pleaseSelectAllMandatoryField.
  ///
  /// In en, this message translates to:
  /// **'Please select all mandatory field'**
  String get pleaseSelectAllMandatoryField;

  /// No description provided for @pleaseSelectBackImage.
  ///
  /// In en, this message translates to:
  /// **'Please select back image'**
  String get pleaseSelectBackImage;

  /// No description provided for @pleaseSelectCountryPhoneCode.
  ///
  /// In en, this message translates to:
  /// **'Please select country phone code'**
  String get pleaseSelectCountryPhoneCode;

  /// No description provided for @pleaseSelectDOB.
  ///
  /// In en, this message translates to:
  /// **'please select date of birth'**
  String get pleaseSelectDOB;

  /// No description provided for @pleaseSelectFrontImage.
  ///
  /// In en, this message translates to:
  /// **'Please select front image'**
  String get pleaseSelectFrontImage;

  /// No description provided for @pleaseSelectInstitutionName.
  ///
  /// In en, this message translates to:
  /// **'Please select institution name'**
  String get pleaseSelectInstitutionName;

  /// No description provided for @pleaseSelectYourState.
  ///
  /// In en, this message translates to:
  /// **'Please select your state'**
  String get pleaseSelectYourState;

  /// No description provided for @pleaseSignUpToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please sign up to continue'**
  String get pleaseSignUpToContinue;

  /// No description provided for @pleaseSupportPin.
  ///
  /// In en, this message translates to:
  /// **'Please enter support pin'**
  String get pleaseSupportPin;

  /// No description provided for @pleaseTxt.
  ///
  /// In en, this message translates to:
  /// **'Please select the type of account you will be setting up today.'**
  String get pleaseTxt;

  /// No description provided for @pleaseVerify.
  ///
  /// In en, this message translates to:
  /// **'Please enter your valid phone number, We will send you a 4 digit code to verify.'**
  String get pleaseVerify;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @poweredBy.
  ///
  /// In en, this message translates to:
  /// **'2024 @ Powered by BCTPay'**
  String get poweredBy;

  /// No description provided for @prev.
  ///
  /// In en, this message translates to:
  /// **'Prev'**
  String get prev;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @primary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get primary;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicyTxt.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTxt;

  /// No description provided for @proceedToPay.
  ///
  /// In en, this message translates to:
  /// **'Proceed to pay'**
  String get proceedToPay;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product name'**
  String get productName;

  /// No description provided for @productTax.
  ///
  /// In en, this message translates to:
  /// **'Product TAX'**
  String get productTax;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @protectAIEmail.
  ///
  /// In en, this message translates to:
  /// **'Protect AI email'**
  String get protectAIEmail;

  /// No description provided for @protectAIMessages.
  ///
  /// In en, this message translates to:
  /// **'Protect AI messages'**
  String get protectAIMessages;

  /// No description provided for @protectionType.
  ///
  /// In en, this message translates to:
  /// **'Protection Type'**
  String get protectionType;

  /// No description provided for @qrscan.
  ///
  /// In en, this message translates to:
  /// **'QR scan'**
  String get qrscan;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @quarterlyPlan.
  ///
  /// In en, this message translates to:
  /// **'QUARTERLY PLAN'**
  String get quarterlyPlan;

  /// No description provided for @queries.
  ///
  /// In en, this message translates to:
  /// **'Queries'**
  String get queries;

  /// No description provided for @queryHistory.
  ///
  /// In en, this message translates to:
  /// **'Query history'**
  String get queryHistory;

  /// No description provided for @queryType.
  ///
  /// In en, this message translates to:
  /// **'Query type'**
  String get queryType;

  /// No description provided for @readAllNotifications.
  ///
  /// In en, this message translates to:
  /// **'Read all notifications'**
  String get readAllNotifications;

  /// No description provided for @recapture.
  ///
  /// In en, this message translates to:
  /// **'Recapture'**
  String get recapture;

  /// No description provided for @receivableAccount.
  ///
  /// In en, this message translates to:
  /// **'Receivable account'**
  String get receivableAccount;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// No description provided for @receivedBy.
  ///
  /// In en, this message translates to:
  /// **'Received by'**
  String get receivedBy;

  /// No description provided for @receivedInto.
  ///
  /// In en, this message translates to:
  /// **'Received into'**
  String get receivedInto;

  /// No description provided for @receiverDetails.
  ///
  /// In en, this message translates to:
  /// **'Receiver details'**
  String get receiverDetails;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @recentText.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recentText;

  /// No description provided for @recentTransaction.
  ///
  /// In en, this message translates to:
  /// **'Recent Transaction'**
  String get recentTransaction;

  /// No description provided for @recharge.
  ///
  /// In en, this message translates to:
  /// **'Recharge'**
  String get recharge;

  /// No description provided for @rechargeBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Recharge any mobile by entering mobile number or by choosing contact from your contact list.'**
  String get rechargeBtnDescription;

  /// No description provided for @rechargeHasBeenSuccessfullyDone.
  ///
  /// In en, this message translates to:
  /// **'Recharge has been successfully done'**
  String get rechargeHasBeenSuccessfullyDone;

  /// No description provided for @recoverPassword.
  ///
  /// In en, this message translates to:
  /// **'Recover password'**
  String get recoverPassword;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get registerNow;

  /// No description provided for @registerWithApple.
  ///
  /// In en, this message translates to:
  /// **'Register with Apple'**
  String get registerWithApple;

  /// No description provided for @registerWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Register with email'**
  String get registerWithEmail;

  /// No description provided for @registerWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Register with Google'**
  String get registerWithGoogle;

  /// No description provided for @registrationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Registration Successful'**
  String get registrationSuccessful;

  /// No description provided for @registrationSuccessfulText.
  ///
  /// In en, this message translates to:
  /// **'Registration Successful'**
  String get registrationSuccessfulText;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @relation.
  ///
  /// In en, this message translates to:
  /// **'Relation'**
  String get relation;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @removeSpam.
  ///
  /// In en, this message translates to:
  /// **'Remove Spam'**
  String get removeSpam;

  /// No description provided for @rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rent;

  /// No description provided for @renterPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter Password'**
  String get renterPassword;

  /// No description provided for @replyingIsNotSupportedByThisSender.
  ///
  /// In en, this message translates to:
  /// **'Replying is not supported by this sender'**
  String get replyingIsNotSupportedByThisSender;

  /// No description provided for @reportMessageExperience.
  ///
  /// In en, this message translates to:
  /// **'Report the message to improve the experience for millions users like you'**
  String get reportMessageExperience;

  /// No description provided for @reportNumberSpam.
  ///
  /// In en, this message translates to:
  /// **'Report Number As Spam'**
  String get reportNumberSpam;

  /// No description provided for @reportSpam.
  ///
  /// In en, this message translates to:
  /// **'Report spam'**
  String get reportSpam;

  /// No description provided for @reportSpamLabel.
  ///
  /// In en, this message translates to:
  /// **'This sender will be marked and labeled as spam in the conversation.'**
  String get reportSpamLabel;

  /// No description provided for @reportText.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get reportText;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @requestAgain.
  ///
  /// In en, this message translates to:
  /// **'Request again'**
  String get requestAgain;

  /// No description provided for @requestAmount.
  ///
  /// In en, this message translates to:
  /// **'Request amount'**
  String get requestAmount;

  /// No description provided for @requestDetails.
  ///
  /// In en, this message translates to:
  /// **'Request detail'**
  String get requestDetails;

  /// No description provided for @requestOTP.
  ///
  /// In en, this message translates to:
  /// **'Request OTP'**
  String get requestOTP;

  /// No description provided for @requestPayment.
  ///
  /// In en, this message translates to:
  /// **'Request payment'**
  String get requestPayment;

  /// No description provided for @requestPermission.
  ///
  /// In en, this message translates to:
  /// **'Request permission'**
  String get requestPermission;

  /// No description provided for @requestTo.
  ///
  /// In en, this message translates to:
  /// **'Request to'**
  String get requestTo;

  /// No description provided for @requestToPay.
  ///
  /// In en, this message translates to:
  /// **'Request to pay'**
  String get requestToPay;

  /// No description provided for @requestingFrom.
  ///
  /// In en, this message translates to:
  /// **'Requesting from'**
  String get requestingFrom;

  /// No description provided for @rescan.
  ///
  /// In en, this message translates to:
  /// **'Rescan'**
  String get rescan;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend Otp'**
  String get resendOtp;

  /// No description provided for @resendVerificationLink.
  ///
  /// In en, this message translates to:
  /// **'Resend verification link'**
  String get resendVerificationLink;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @roaming.
  ///
  /// In en, this message translates to:
  /// **'Roaming'**
  String get roaming;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saveMonths.
  ///
  /// In en, this message translates to:
  /// **'Save 23%'**
  String get saveMonths;

  /// No description provided for @saveText.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveText;

  /// No description provided for @saveYear.
  ///
  /// In en, this message translates to:
  /// **'Save 25%'**
  String get saveYear;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @scanBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Scan QR codes and make transactions.'**
  String get scanBtnDescription;

  /// No description provided for @scanPayUsingBCTPayApp.
  ///
  /// In en, this message translates to:
  /// **'Scan & pay using BCTPay app'**
  String get scanPayUsingBCTPayApp;

  /// No description provided for @scanQR.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQR;

  /// No description provided for @scratchHere.
  ///
  /// In en, this message translates to:
  /// **'Scratch here'**
  String get scratchHere;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchCountry.
  ///
  /// In en, this message translates to:
  /// **'Search country'**
  String get searchCountry;

  /// No description provided for @searchHere.
  ///
  /// In en, this message translates to:
  /// **'Search here...'**
  String get searchHere;

  /// No description provided for @searchInConversation.
  ///
  /// In en, this message translates to:
  /// **'Search in conversation'**
  String get searchInConversation;

  /// No description provided for @searchMore.
  ///
  /// In en, this message translates to:
  /// **'Search numbers,names & more'**
  String get searchMore;

  /// No description provided for @secureEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter an alternative email to secure your account.'**
  String get secureEmail;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @seeQueryHistory.
  ///
  /// In en, this message translates to:
  /// **'See query history'**
  String get seeQueryHistory;

  /// No description provided for @selectAccount.
  ///
  /// In en, this message translates to:
  /// **'Select account'**
  String get selectAccount;

  /// No description provided for @selectAccountToReceiveInto.
  ///
  /// In en, this message translates to:
  /// **'Select account to receive into'**
  String get selectAccountToReceiveInto;

  /// No description provided for @selectBankAccountToTransferFrom.
  ///
  /// In en, this message translates to:
  /// **'Select bank account to transfer from'**
  String get selectBankAccountToTransferFrom;

  /// No description provided for @selectBankAccountToTransferTo.
  ///
  /// In en, this message translates to:
  /// **'Select bank account to transfer to'**
  String get selectBankAccountToTransferTo;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select a category'**
  String get selectCategory;

  /// No description provided for @selectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select country'**
  String get selectCountry;

  /// No description provided for @selectCountryText.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get selectCountryText;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @selectState.
  ///
  /// In en, this message translates to:
  /// **'Select state'**
  String get selectState;

  /// No description provided for @selectValidity.
  ///
  /// In en, this message translates to:
  /// **'Select validity'**
  String get selectValidity;

  /// No description provided for @selectYourDocumentType.
  ///
  /// In en, this message translates to:
  /// **'Select your document type'**
  String get selectYourDocumentType;

  /// No description provided for @selfTransfer.
  ///
  /// In en, this message translates to:
  /// **'Self transfer'**
  String get selfTransfer;

  /// No description provided for @selfieVerification.
  ///
  /// In en, this message translates to:
  /// **'Selfie verification'**
  String get selfieVerification;

  /// No description provided for @selfieVerificationDesc.
  ///
  /// In en, this message translates to:
  /// **'In order to completed your KYC, please capture your selfie'**
  String get selfieVerificationDesc;

  /// No description provided for @selfieVerificationPurpose.
  ///
  /// In en, this message translates to:
  /// **'The selfie is being checked for accuracy. If it\'s not correct, you should either recapture it or proceed with the existing image.'**
  String get selfieVerificationPurpose;

  /// No description provided for @selfieVerificationTnC.
  ///
  /// In en, this message translates to:
  /// **'Hold your phone at eye level and look directly into the camera and press capture button to take a photo'**
  String get selfieVerificationTnC;

  /// No description provided for @sendMoney.
  ///
  /// In en, this message translates to:
  /// **'Send money'**
  String get sendMoney;

  /// No description provided for @sendMoneyBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'You can make transactions to your added beneficiaries and you can also manage beneficiaries.'**
  String get sendMoneyBtnDescription;

  /// No description provided for @sendSms.
  ///
  /// In en, this message translates to:
  /// **'Send Sms'**
  String get sendSms;

  /// No description provided for @senderDetails.
  ///
  /// In en, this message translates to:
  /// **'Sender details'**
  String get senderDetails;

  /// No description provided for @senderName.
  ///
  /// In en, this message translates to:
  /// **'Sender name'**
  String get senderName;

  /// No description provided for @sendingAmount.
  ///
  /// In en, this message translates to:
  /// **'Sending amount'**
  String get sendingAmount;

  /// No description provided for @sendingTo.
  ///
  /// In en, this message translates to:
  /// **'Sending to'**
  String get sendingTo;

  /// No description provided for @sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sent;

  /// No description provided for @sentFrom.
  ///
  /// In en, this message translates to:
  /// **'Sent from'**
  String get sentFrom;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get serverError;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @sessionPleaseLogInAgain.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please log in again'**
  String get sessionPleaseLogInAgain;

  /// No description provided for @setActive.
  ///
  /// In en, this message translates to:
  /// **'Set active'**
  String get setActive;

  /// No description provided for @setAsPrimaryAccount.
  ///
  /// In en, this message translates to:
  /// **'Set as primary account'**
  String get setAsPrimaryAccount;

  /// No description provided for @setInActive.
  ///
  /// In en, this message translates to:
  /// **'Set inactive'**
  String get setInActive;

  /// No description provided for @setPrimary.
  ///
  /// In en, this message translates to:
  /// **'Set primary'**
  String get setPrimary;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @sideMenu.
  ///
  /// In en, this message translates to:
  /// **'Side menu'**
  String get sideMenu;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @sms.
  ///
  /// In en, this message translates to:
  /// **'Sms'**
  String get sms;

  /// No description provided for @smsMth.
  ///
  /// In en, this message translates to:
  /// **'\$11.98/mth'**
  String get smsMth;

  /// No description provided for @smsProtection.
  ///
  /// In en, this message translates to:
  /// **'SMS Protection'**
  String get smsProtection;

  /// No description provided for @someOccurredAgain.
  ///
  /// In en, this message translates to:
  /// **'Some error occurred. Please try again!'**
  String get someOccurredAgain;

  /// No description provided for @spamCalls.
  ///
  /// In en, this message translates to:
  /// **'Spam Calls'**
  String get spamCalls;

  /// No description provided for @spamIdentified.
  ///
  /// In en, this message translates to:
  /// **'Spam calls identified'**
  String get spamIdentified;

  /// No description provided for @spamReports.
  ///
  /// In en, this message translates to:
  /// **'Spam reports'**
  String get spamReports;

  /// No description provided for @spamSMSEmail.
  ///
  /// In en, this message translates to:
  /// **'Spam call blocking, AI Protect scam detection, SMS protect & Email'**
  String get spamSMSEmail;

  /// No description provided for @spamSMSProtect.
  ///
  /// In en, this message translates to:
  /// **'Spam call blocking, AI Protect scam detection and SMS protect'**
  String get spamSMSProtect;

  /// No description provided for @spamScamDetection.
  ///
  /// In en, this message translates to:
  /// **'Spam call blocking and AI Protect scam detection'**
  String get spamScamDetection;

  /// No description provided for @staff.
  ///
  /// In en, this message translates to:
  /// **'Staff'**
  String get staff;

  /// No description provided for @staffList.
  ///
  /// In en, this message translates to:
  /// **'Staff List'**
  String get staffList;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @submitText.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitText;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get success;

  /// No description provided for @successful.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get successful;

  /// No description provided for @supportPin.
  ///
  /// In en, this message translates to:
  /// **'Support Pin'**
  String get supportPin;

  /// No description provided for @synCallLogs.
  ///
  /// In en, this message translates to:
  /// **'Sync call logs'**
  String get synCallLogs;

  /// No description provided for @sync.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get sync;

  /// No description provided for @syncContacts.
  ///
  /// In en, this message translates to:
  /// **'Sync contacts'**
  String get syncContacts;

  /// No description provided for @takeASelfie.
  ///
  /// In en, this message translates to:
  /// **'Take a selfie'**
  String get takeASelfie;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo'**
  String get takePhoto;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'TAX'**
  String get tax;

  /// No description provided for @tellUsMore.
  ///
  /// In en, this message translates to:
  /// **'Tell us more...'**
  String get tellUsMore;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @thisFieldShouldNotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'This field shouldn\'t be empty'**
  String get thisFieldShouldNotBeEmpty;

  /// No description provided for @thisFuctionalityWillAvailableSoon.
  ///
  /// In en, this message translates to:
  /// **'This fuctionality will available soon'**
  String get thisFuctionalityWillAvailableSoon;

  /// No description provided for @timeSpammers.
  ///
  /// In en, this message translates to:
  /// **'Time saved from spammers'**
  String get timeSpammers;

  /// No description provided for @tnc.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get tnc;

  /// No description provided for @toSelfAccount.
  ///
  /// In en, this message translates to:
  /// **'To self account'**
  String get toSelfAccount;

  /// No description provided for @toSelfAccountBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Transfer money to your self accounts even you can manage your accounts from here.'**
  String get toSelfAccountBtnDescription;

  /// No description provided for @topUp.
  ///
  /// In en, this message translates to:
  /// **'Top-Up'**
  String get topUp;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total amount'**
  String get totalAmount;

  /// No description provided for @totalPay.
  ///
  /// In en, this message translates to:
  /// **'Total pay'**
  String get totalPay;

  /// No description provided for @totalPayment.
  ///
  /// In en, this message translates to:
  /// **'Total payment'**
  String get totalPayment;

  /// No description provided for @totalProductPrice.
  ///
  /// In en, this message translates to:
  /// **'Total product price'**
  String get totalProductPrice;

  /// No description provided for @totalTaxAmount.
  ///
  /// In en, this message translates to:
  /// **'Total TAX amount'**
  String get totalTaxAmount;

  /// No description provided for @transactionDetails.
  ///
  /// In en, this message translates to:
  /// **'Transaction details'**
  String get transactionDetails;

  /// No description provided for @transactionFee.
  ///
  /// In en, this message translates to:
  /// **'Transaction fee: '**
  String get transactionFee;

  /// No description provided for @transactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionId;

  /// No description provided for @transactionList.
  ///
  /// In en, this message translates to:
  /// **'Transaction List'**
  String get transactionList;

  /// No description provided for @transactionStatus.
  ///
  /// In en, this message translates to:
  /// **'Transaction status'**
  String get transactionStatus;

  /// No description provided for @transactionType.
  ///
  /// In en, this message translates to:
  /// **'Transaction type'**
  String get transactionType;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @transferDetails.
  ///
  /// In en, this message translates to:
  /// **'Transfer details'**
  String get transferDetails;

  /// No description provided for @transferFrom.
  ///
  /// In en, this message translates to:
  /// **'Transfer from'**
  String get transferFrom;

  /// No description provided for @transferMoneyTo.
  ///
  /// In en, this message translates to:
  /// **'Transfer money to'**
  String get transferMoneyTo;

  /// No description provided for @transferNow.
  ///
  /// In en, this message translates to:
  /// **'Transfer now'**
  String get transferNow;

  /// No description provided for @transferTo.
  ///
  /// In en, this message translates to:
  /// **'Transfer to'**
  String get transferTo;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again..'**
  String get tryAgain;

  /// No description provided for @unMarkSMs.
  ///
  /// In en, this message translates to:
  /// **'UnMark'**
  String get unMarkSMs;

  /// No description provided for @unblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get unblock;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @unknownIdentified.
  ///
  /// In en, this message translates to:
  /// **'Unknown number identified'**
  String get unknownIdentified;

  /// No description provided for @unlockBCTPay.
  ///
  /// In en, this message translates to:
  /// **'Unlock BCTPay'**
  String get unlockBCTPay;

  /// No description provided for @unlockNow.
  ///
  /// In en, this message translates to:
  /// **'Unlock now'**
  String get unlockNow;

  /// No description provided for @unmarkSpam.
  ///
  /// In en, this message translates to:
  /// **'Unmark Spam'**
  String get unmarkSpam;

  /// No description provided for @unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @updateBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Update bank account'**
  String get updateBankAccount;

  /// No description provided for @updateBeneficiary.
  ///
  /// In en, this message translates to:
  /// **'Update beneficiary'**
  String get updateBeneficiary;

  /// No description provided for @updateKyc.
  ///
  /// In en, this message translates to:
  /// **'Update KYC'**
  String get updateKyc;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update profile'**
  String get updateProfile;

  /// No description provided for @upgradePremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradePremium;

  /// No description provided for @upgradePremiumView.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium to view'**
  String get upgradePremiumView;

  /// No description provided for @upgradeToPremiumOutWho.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium to find out who'**
  String get upgradeToPremiumOutWho;

  /// No description provided for @upgradeUsersSpamDetectionPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to join + 1 million users on spam detection premium'**
  String get upgradeUsersSpamDetectionPremium;

  /// No description provided for @uploadBackImageOfDoc.
  ///
  /// In en, this message translates to:
  /// **'Upload back image of document'**
  String get uploadBackImageOfDoc;

  /// No description provided for @uploadFollowingDocuments.
  ///
  /// In en, this message translates to:
  /// **'Upload following documents'**
  String get uploadFollowingDocuments;

  /// No description provided for @uploadFrontImageOfDoc.
  ///
  /// In en, this message translates to:
  /// **'Upload front image of document'**
  String get uploadFrontImageOfDoc;

  /// No description provided for @uploadImage.
  ///
  /// In en, this message translates to:
  /// **'Upload image'**
  String get uploadImage;

  /// No description provided for @uploadYourAddressDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload your address document'**
  String get uploadYourAddressDocument;

  /// No description provided for @upto.
  ///
  /// In en, this message translates to:
  /// **'upto'**
  String get upto;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get userName;

  /// No description provided for @valid.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get valid;

  /// No description provided for @validFrom.
  ///
  /// In en, this message translates to:
  /// **'Valid from'**
  String get validFrom;

  /// No description provided for @validity.
  ///
  /// In en, this message translates to:
  /// **'Validity'**
  String get validity;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCode;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @verifyProceed.
  ///
  /// In en, this message translates to:
  /// **'Verify and Proceed'**
  String get verifyProceed;

  /// No description provided for @viewAccount.
  ///
  /// In en, this message translates to:
  /// **'View account'**
  String get viewAccount;

  /// No description provided for @viewPlan.
  ///
  /// In en, this message translates to:
  /// **'View plan'**
  String get viewPlan;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View profile'**
  String get viewProfile;

  /// No description provided for @voterIdCard.
  ///
  /// In en, this message translates to:
  /// **'Voter ID card'**
  String get voterIdCard;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @walletBalance.
  ///
  /// In en, this message translates to:
  /// **'Wallet balance'**
  String get walletBalance;

  /// No description provided for @walletPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Wallet phone number'**
  String get walletPhoneNumber;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning!'**
  String get warning;

  /// No description provided for @wasPersonalNumber.
  ///
  /// In en, this message translates to:
  /// **'Was this a business or personal number?'**
  String get wasPersonalNumber;

  /// No description provided for @wasThisBusinessMessage.
  ///
  /// In en, this message translates to:
  /// **'Was this a bussiness or personal message?'**
  String get wasThisBusinessMessage;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @weHaveSentTheCodeVerificationToYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'We have sent the code verification to your mobile number'**
  String get weHaveSentTheCodeVerificationToYourMobileNumber;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'WELCOME'**
  String get welcome;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @welcomeTxt.
  ///
  /// In en, this message translates to:
  /// **'Welcome to BROADLINK Protect Your Mobile Defender! Effortlessly block unwanted calls, messages and keep your device clean let\'s get started and take control of your communication!'**
  String get welcomeTxt;

  /// No description provided for @whatCallAbout.
  ///
  /// In en, this message translates to:
  /// **'What was the call about?'**
  String get whatCallAbout;

  /// No description provided for @whatSpamIt.
  ///
  /// In en, this message translates to:
  /// **'What type of spam was it?'**
  String get whatSpamIt;

  /// No description provided for @whatTypeOfMessage.
  ///
  /// In en, this message translates to:
  /// **'What type of message was this?'**
  String get whatTypeOfMessage;

  /// No description provided for @whoViewedMyProfile.
  ///
  /// In en, this message translates to:
  /// **'Who viewed my profile'**
  String get whoViewedMyProfile;

  /// No description provided for @work.
  ///
  /// In en, this message translates to:
  /// **'work'**
  String get work;

  /// No description provided for @workFax.
  ///
  /// In en, this message translates to:
  /// **'Work Fax'**
  String get workFax;

  /// No description provided for @writeComment.
  ///
  /// In en, this message translates to:
  /// **'Write a comment'**
  String get writeComment;

  /// No description provided for @yearlyPlan.
  ///
  /// In en, this message translates to:
  /// **'YEARLY PLAN'**
  String get yearlyPlan;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @yey.
  ///
  /// In en, this message translates to:
  /// **'Yey!'**
  String get yey;

  /// No description provided for @yoCanUpdateYourProfileFromHere.
  ///
  /// In en, this message translates to:
  /// **'You can update your profile from here'**
  String get yoCanUpdateYourProfileFromHere;

  /// No description provided for @youAreProtected.
  ///
  /// In en, this message translates to:
  /// **'You Are Protected Against All The Dangerous Phone Numbers From Our Security Database'**
  String get youAreProtected;

  /// No description provided for @youCanDoAnyOnlinePaymentFromAnyCardOrAccountJustScanTheQRCodeNEnjoy.
  ///
  /// In en, this message translates to:
  /// **'You can do any online payment from any card or account. Just scan the QR code & enjoy.'**
  String get youCanDoAnyOnlinePaymentFromAnyCardOrAccountJustScanTheQRCodeNEnjoy;

  /// No description provided for @youCanGetUpto.
  ///
  /// In en, this message translates to:
  /// **'You can get upto'**
  String get youCanGetUpto;

  /// No description provided for @youCanManageYourSubscription.
  ///
  /// In en, this message translates to:
  /// **'You can manage your subscription or cancel anytime in your Google account settings.Specific Terms apply.'**
  String get youCanManageYourSubscription;

  /// No description provided for @youCanNotTransferAmountToYourselfSelectOtherAccountToProceed.
  ///
  /// In en, this message translates to:
  /// **'You can not transfer amount to yourself. Select other account to proceed.'**
  String get youCanNotTransferAmountToYourselfSelectOtherAccountToProceed;

  /// No description provided for @youCantRetryYet.
  ///
  /// In en, this message translates to:
  /// **'You can\'t retry yet!'**
  String get youCantRetryYet;

  /// No description provided for @your.
  ///
  /// In en, this message translates to:
  /// **'Your'**
  String get your;

  /// No description provided for @yourEmailsAreCurrently.
  ///
  /// In en, this message translates to:
  /// **'Your Emails Are Currently Being Screened By Protect AI To Detect Potential Scam And Safe Guard Your Data And Financials.'**
  String get yourEmailsAreCurrently;

  /// No description provided for @yourGoalsWillHelpUsToFormulateTheRightRecommendationsForSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your goals will help us to formulate the right recommendations for success.'**
  String get yourGoalsWillHelpUsToFormulateTheRightRecommendationsForSuccess;

  /// No description provided for @yourMessagesAreCurrently.
  ///
  /// In en, this message translates to:
  /// **'Your Messages Are Currently Being Screened By Detect AI To Identity Potential Scams.'**
  String get yourMessagesAreCurrently;

  /// No description provided for @yourNewPasswordMustBeDifferentFromPreviouslyUsedPassword.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be different from previously used password.'**
  String get yourNewPasswordMustBeDifferentFromPreviouslyUsedPassword;

  /// No description provided for @yourPasswordHasBeenChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed successfully .'**
  String get yourPasswordHasBeenChangedSuccessfully;

  /// No description provided for @yourPasswordHasBeenResetSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your password has been reset successfully .'**
  String get yourPasswordHasBeenResetSuccessfully;

  /// No description provided for @yourPaymentHasBeenSuccessfullyDone.
  ///
  /// In en, this message translates to:
  /// **'Your payment has been successfully done.'**
  String get yourPaymentHasBeenSuccessfullyDone;

  /// No description provided for @zip.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zip;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
