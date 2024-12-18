// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Staff List`
  String get stafflist {
    return Intl.message(
      'Staff List',
      name: 'stafflist',
      desc: '',
      args: [],
    );
  }

  /// `Family list`
  String get familylist {
    return Intl.message(
      'Family list',
      name: 'familylist',
      desc: '',
      args: [],
    );
  }

  /// `Aadhar card`
  String get aadharCard {
    return Intl.message(
      'Aadhar card',
      name: 'aadharCard',
      desc: '',
      args: [],
    );
  }

  /// `ACCEPTED HERE`
  String get acceptedHere {
    return Intl.message(
      'ACCEPTED HERE',
      name: 'acceptedHere',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Account added on`
  String get accountAddedOn {
    return Intl.message(
      'Account added on',
      name: 'accountAddedOn',
      desc: '',
      args: [],
    );
  }

  /// `Account created !`
  String get accountCreated {
    return Intl.message(
      'Account created !',
      name: 'accountCreated',
      desc: '',
      args: [],
    );
  }

  /// `Account detail`
  String get accountDetail {
    return Intl.message(
      'Account detail',
      name: 'accountDetail',
      desc: '',
      args: [],
    );
  }

  /// `Account holder name`
  String get accountHolderName {
    return Intl.message(
      'Account holder name',
      name: 'accountHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Account number`
  String get accountNumber {
    return Intl.message(
      'Account number',
      name: 'accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Add alternative email`
  String get addAlternativeEmail {
    return Intl.message(
      'Add alternative email',
      name: 'addAlternativeEmail',
      desc: '',
      args: [],
    );
  }

  /// `Add bank account`
  String get addBankAccount {
    return Intl.message(
      'Add bank account',
      name: 'addBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Add beneficiary`
  String get addBeneficiary {
    return Intl.message(
      'Add beneficiary',
      name: 'addBeneficiary',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Address verification`
  String get addressVerification {
    return Intl.message(
      'Address verification',
      name: 'addressVerification',
      desc: '',
      args: [],
    );
  }

  /// `In order to completed your KYC, please upload a copy of your address proof`
  String get addressVerificationDesc {
    return Intl.message(
      'In order to completed your KYC, please upload a copy of your address proof',
      name: 'addressVerificationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Admin commision: `
  String get adminCommision {
    return Intl.message(
      'Admin commision: ',
      name: 'adminCommision',
      desc: '',
      args: [],
    );
  }

  /// `Admin fee`
  String get adminFee {
    return Intl.message(
      'Admin fee',
      name: 'adminFee',
      desc: '',
      args: [],
    );
  }

  /// `Align QR code within frame to scan`
  String get alignQRCodeWithinFrameToScan {
    return Intl.message(
      'Align QR code within frame to scan',
      name: 'alignQRCodeWithinFrameToScan',
      desc: '',
      args: [],
    );
  }

  /// `All spam calls are currently being blocked from calling your telephone number you may miss important call if the caller number is flagged by the network as spam.`
  String
      get allSpamCallsAreCurrentlyBeingBlockedFromCallingYourTelephoneNumberYouMayMissImportantCallIfTheCallerNumberIsFlaggedByTheNetworkAsSpam {
    return Intl.message(
      'All spam calls are currently being blocked from calling your telephone number you may miss important call if the caller number is flagged by the network as spam.',
      name:
          'allSpamCallsAreCurrentlyBeingBlockedFromCallingYourTelephoneNumberYouMayMissImportantCallIfTheCallerNumberIsFlaggedByTheNetworkAsSpam',
      desc: '',
      args: [],
    );
  }

  /// `All transactions`
  String get allTransactions {
    return Intl.message(
      'All transactions',
      name: 'allTransactions',
      desc: '',
      args: [],
    );
  }

  /// ` Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      ' Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already paid`
  String get alreadyPaid {
    return Intl.message(
      'Already paid',
      name: 'alreadyPaid',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Amount requested successfully`
  String get amountRequestedSuccessfully {
    return Intl.message(
      'Amount requested successfully',
      name: 'amountRequestedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Amount should be greater than 0`
  String get amountShouldBeGreaterThanZero {
    return Intl.message(
      'Amount should be greater than 0',
      name: 'amountShouldBeGreaterThanZero',
      desc: '',
      args: [],
    );
  }

  /// `As per document`
  String get asPerDocument {
    return Intl.message(
      'As per document',
      name: 'asPerDocument',
      desc: '',
      args: [],
    );
  }

  /// `Authentication is required to access the BCTPay app`
  String get authenticationIsRequiredToAccessTheBCTPayApp {
    return Intl.message(
      'Authentication is required to access the BCTPay app',
      name: 'authenticationIsRequiredToAccessTheBCTPayApp',
      desc: '',
      args: [],
    );
  }

  /// `Available balance`
  String get availableBalance {
    return Intl.message(
      'Available balance',
      name: 'availableBalance',
      desc: '',
      args: [],
    );
  }

  /// `BCTPay can help you reach a wide user-base with targeted campaigns designed to meet your business needs.`
  String
      get bCTPayCanHelpYouReachAWideUserBaseWithTargetedCampaignsDesignedToMeetYourBusinessNeeds {
    return Intl.message(
      'BCTPay can help you reach a wide user-base with targeted campaigns designed to meet your business needs.',
      name:
          'bCTPayCanHelpYouReachAWideUserBaseWithTargetedCampaignsDesignedToMeetYourBusinessNeeds',
      desc: '',
      args: [],
    );
  }

  /// `BCTPay is locked`
  String get bCTPayIsLocked {
    return Intl.message(
      'BCTPay is locked',
      name: 'bCTPayIsLocked',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Back image`
  String get backImage {
    return Intl.message(
      'Back image',
      name: 'backImage',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `You will go to the accounts list for checking balance by pressing Balance button.`
  String get balanceBtnDescription {
    return Intl.message(
      'You will go to the accounts list for checking balance by pressing Balance button.',
      name: 'balanceBtnDescription',
      desc: '',
      args: [],
    );
  }

  /// `Bank`
  String get bank {
    return Intl.message(
      'Bank',
      name: 'bank',
      desc: '',
      args: [],
    );
  }

  /// `Bank code`
  String get bankCode {
    return Intl.message(
      'Bank code',
      name: 'bankCode',
      desc: '',
      args: [],
    );
  }

  /// `Bank name`
  String get bankName {
    return Intl.message(
      'Bank name',
      name: 'bankName',
      desc: '',
      args: [],
    );
  }

  /// `Bank transfer`
  String get bankTransfer {
    return Intl.message(
      'Bank transfer',
      name: 'bankTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Banks & Wallets`
  String get banksAndWallets {
    return Intl.message(
      'Banks & Wallets',
      name: 'banksAndWallets',
      desc: '',
      args: [],
    );
  }

  /// `BCTPay fee`
  String get bctPayFee {
    return Intl.message(
      'BCTPay fee',
      name: 'bctPayFee',
      desc: '',
      args: [],
    );
  }

  /// `Beneficiary detail`
  String get beneficiaryDetail {
    return Intl.message(
      'Beneficiary detail',
      name: 'beneficiaryDetail',
      desc: '',
      args: [],
    );
  }

  /// `Beneficiary list`
  String get beneficiaryList {
    return Intl.message(
      'Beneficiary list',
      name: 'beneficiaryList',
      desc: '',
      args: [],
    );
  }

  /// `Beneficiary name`
  String get beneficiaryName {
    return Intl.message(
      'Beneficiary name',
      name: 'beneficiaryName',
      desc: '',
      args: [],
    );
  }

  /// `Billers`
  String get billers {
    return Intl.message(
      'Billers',
      name: 'billers',
      desc: '',
      args: [],
    );
  }

  /// `Bills & Subscriptions`
  String get billsNSubscriptions {
    return Intl.message(
      'Bills & Subscriptions',
      name: 'billsNSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Block all scam, telemarketing and fraud calls thanks to AI -blocking accuracy.`
  String get blockAccuracy {
    return Intl.message(
      'Block all scam, telemarketing and fraud calls thanks to AI -blocking accuracy.',
      name: 'blockAccuracy',
      desc: '',
      args: [],
    );
  }

  /// `Blocked Calls`
  String get blockedCalls {
    return Intl.message(
      'Blocked Calls',
      name: 'blockedCalls',
      desc: '',
      args: [],
    );
  }

  /// `Call logs`
  String get callLogs {
    return Intl.message(
      'Call logs',
      name: 'callLogs',
      desc: '',
      args: [],
    );
  }

  /// `Call protection`
  String get callProtection {
    return Intl.message(
      'Call protection',
      name: 'callProtection',
      desc: '',
      args: [],
    );
  }

  /// `Call & SMS Bundle`
  String get callSMSBundle {
    return Intl.message(
      'Call & SMS Bundle',
      name: 'callSMSBundle',
      desc: '',
      args: [],
    );
  }

  /// `Calls`
  String get calls {
    return Intl.message(
      'Calls',
      name: 'calls',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelTxt {
    return Intl.message(
      'Cancel',
      name: 'cancelTxt',
      desc: '',
      args: [],
    );
  }

  /// `Can't add more accounts for this bank. You've reached the limit.`
  String get cantAddMoreAccountsForThisBankYouHaveReachedTheLimit {
    return Intl.message(
      'Can\'t add more accounts for this bank. You\'ve reached the limit.',
      name: 'cantAddMoreAccountsForThisBankYouHaveReachedTheLimit',
      desc: '',
      args: [],
    );
  }

  /// `Capture`
  String get capture {
    return Intl.message(
      'Capture',
      name: 'capture',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get card {
    return Intl.message(
      'Card',
      name: 'card',
      desc: '',
      args: [],
    );
  }

  /// `Change a Language`
  String get changeALanguage {
    return Intl.message(
      'Change a Language',
      name: 'changeALanguage',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Check balance`
  String get checkBalance {
    return Intl.message(
      'Check balance',
      name: 'checkBalance',
      desc: '',
      args: [],
    );
  }

  /// `Check Wallet balance as well as bank account balance or you can manage your accounts like you can add, active, inactive, set primary account or you can delete account.`
  String get checkBalanceBtnDescription {
    return Intl.message(
      'Check Wallet balance as well as bank account balance or you can manage your accounts like you can add, active, inactive, set primary account or you can delete account.',
      name: 'checkBalanceBtnDescription',
      desc: '',
      args: [],
    );
  }

  /// `Choose your plan `
  String get chooseYourPlan {
    return Intl.message(
      'Choose your plan ',
      name: 'chooseYourPlan',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Clear all notifications`
  String get clearAllNotifications {
    return Intl.message(
      'Clear all notifications',
      name: 'clearAllNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Client ID`
  String get clientId {
    return Intl.message(
      'Client ID',
      name: 'clientId',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Close query`
  String get closeQuery {
    return Intl.message(
      'Close query',
      name: 'closeQuery',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get closed {
    return Intl.message(
      'Closed',
      name: 'closed',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `$14.99/mth`
  String get completeMth {
    return Intl.message(
      '\$14.99/mth',
      name: 'completeMth',
      desc: '',
      args: [],
    );
  }

  /// `Complete Protection Bundle`
  String get completeProtectionBundle {
    return Intl.message(
      'Complete Protection Bundle',
      name: 'completeProtectionBundle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm the contact number`
  String get confirmContactDialogDesc {
    return Intl.message(
      'Please confirm the contact number',
      name: 'confirmContactDialogDesc',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm new password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations, your account has been successfully created.`
  String get congratulationScreated {
    return Intl.message(
      'Congratulations, your account has been successfully created.',
      name: 'congratulationScreated',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations, your account has been successfully created.`
  String get congratulationsYourAccountHasBeenSuccessfullyCreated {
    return Intl.message(
      'Congratulations, your account has been successfully created.',
      name: 'congratulationsYourAccountHasBeenSuccessfullyCreated',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations, your account has been successfully updated.`
  String get congratulationsYourAccountHasBeenSuccessfullyUpdated {
    return Intl.message(
      'Congratulations, your account has been successfully updated.',
      name: 'congratulationsYourAccountHasBeenSuccessfullyUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Contact permission`
  String get contactPermission {
    return Intl.message(
      'Contact permission',
      name: 'contactPermission',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactUs {
    return Intl.message(
      'Contact us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Continue to Purchase`
  String get continuePurchase {
    return Intl.message(
      'Continue to Purchase',
      name: 'continuePurchase',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueTxt {
    return Intl.message(
      'Continue',
      name: 'continueTxt',
      desc: '',
      args: [],
    );
  }

  /// `Copied`
  String get copied {
    return Intl.message(
      'Copied',
      name: 'copied',
      desc: '',
      args: [],
    );
  }

  /// `Corporate ID`
  String get corporateID {
    return Intl.message(
      'Corporate ID',
      name: 'corporateID',
      desc: '',
      args: [],
    );
  }

  /// `Corporate Protection`
  String get corporateProtection {
    return Intl.message(
      'Corporate Protection',
      name: 'corporateProtection',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Country code`
  String get countryCode {
    return Intl.message(
      'Country code',
      name: 'countryCode',
      desc: '',
      args: [],
    );
  }

  /// `Coupons`
  String get coupons {
    return Intl.message(
      'Coupons',
      name: 'coupons',
      desc: '',
      args: [],
    );
  }

  /// `Customer ID`
  String get customerId {
    return Intl.message(
      'Customer ID',
      name: 'customerId',
      desc: '',
      args: [],
    );
  }

  /// `Cylinder`
  String get cylinder {
    return Intl.message(
      'Cylinder',
      name: 'cylinder',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Data`
  String get data {
    return Intl.message(
      'Data',
      name: 'data',
      desc: '',
      args: [],
    );
  }

  /// `Explore purchasing data packages before your visit to potentially benefit from discounted rates.`
  String get dataBtnDescription {
    return Intl.message(
      'Explore purchasing data packages before your visit to potentially benefit from discounted rates.',
      name: 'dataBtnDescription',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Debited from`
  String get debitedFrom {
    return Intl.message(
      'Debited from',
      name: 'debitedFrom',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete all Calls`
  String get deleteCalls {
    return Intl.message(
      'Delete all Calls',
      name: 'deleteCalls',
      desc: '',
      args: [],
    );
  }

  /// `Description: `
  String get description {
    return Intl.message(
      'Description: ',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Developer mode is enabled, please disable to access the BCTPay app`
  String get developerModeDialogDiscription {
    return Intl.message(
      'Developer mode is enabled, please disable to access the BCTPay app',
      name: 'developerModeDialogDiscription',
      desc: '',
      args: [],
    );
  }

  /// `Did't recieve Code?`
  String get didRecieveCode {
    return Intl.message(
      'Did\'t recieve Code?',
      name: 'didRecieveCode',
      desc: '',
      args: [],
    );
  }

  /// `Did't recieve Code?`
  String get didTxt {
    return Intl.message(
      'Did\'t recieve Code?',
      name: 'didTxt',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete this account ?`
  String get doYouReallyWantToDeleteThisAccount {
    return Intl.message(
      'Do you really want to delete this account ?',
      name: 'doYouReallyWantToDeleteThisAccount',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to exit the app ?`
  String get doYouReallyWantToExitTheApp {
    return Intl.message(
      'Do you really want to exit the app ?',
      name: 'doYouReallyWantToExitTheApp',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to logout ?`
  String get doYouReallyWantToLogout {
    return Intl.message(
      'Do you really want to logout ?',
      name: 'doYouReallyWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to update profile image ?`
  String get doYouReallyWantToUpdateProfileImage {
    return Intl.message(
      'Do you really want to update profile image ?',
      name: 'doYouReallyWantToUpdateProfileImage',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get dob {
    return Intl.message(
      'Date of birth',
      name: 'dob',
      desc: '',
      args: [],
    );
  }

  /// `Document ID number`
  String get docIdNumber {
    return Intl.message(
      'Document ID number',
      name: 'docIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `Doc type`
  String get docType {
    return Intl.message(
      'Doc type',
      name: 'docType',
      desc: '',
      args: [],
    );
  }

  /// `Document type`
  String get documentType {
    return Intl.message(
      'Document type',
      name: 'documentType',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don’t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Don't worry! it happens. Please enter the adress associated with your account.`
  String get dontWorryItHappensPleaseEnterTheAdressAssociatedWithYourAccount {
    return Intl.message(
      'Don\'t worry! it happens. Please enter the adress associated with your account.',
      name: 'dontWorryItHappensPleaseEnterTheAdressAssociatedWithYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Get list of settings in the side menu.`
  String get drawerBtnDescription {
    return Intl.message(
      'Get list of settings in the side menu.',
      name: 'drawerBtnDescription',
      desc: '',
      args: [],
    );
  }

  /// `Driving licence`
  String get drivingLicence {
    return Intl.message(
      'Driving licence',
      name: 'drivingLicence',
      desc: '',
      args: [],
    );
  }

  /// `DTH`
  String get dth {
    return Intl.message(
      'DTH',
      name: 'dth',
      desc: '',
      args: [],
    );
  }

  /// `Due date`
  String get dueDate {
    return Intl.message(
      'Due date',
      name: 'dueDate',
      desc: '',
      args: [],
    );
  }

  /// `Due on`
  String get dueOn {
    return Intl.message(
      'Due on',
      name: 'dueOn',
      desc: '',
      args: [],
    );
  }

  /// `Easiest way to manage`
  String get easiestWayToManage {
    return Intl.message(
      'Easiest way to manage',
      name: 'easiestWayToManage',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Edit security pin`
  String get editSecurityPin {
    return Intl.message(
      'Edit security pin',
      name: 'editSecurityPin',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Electricity`
  String get electricity {
    return Intl.message(
      'Electricity',
      name: 'electricity',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get emailAddress {
    return Intl.message(
      'Email address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy`
  String get enjoy {
    return Intl.message(
      'Enjoy',
      name: 'enjoy',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy all the benefits of being an explorer member`
  String get enjoyMember {
    return Intl.message(
      'Enjoy all the benefits of being an explorer member',
      name: 'enjoyMember',
      desc: '',
      args: [],
    );
  }

  /// `Enter account holder name`
  String get enterAccountHolderName {
    return Intl.message(
      'Enter account holder name',
      name: 'enterAccountHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Enter account number`
  String get enterAccountNumber {
    return Intl.message(
      'Enter account number',
      name: 'enterAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter address`
  String get enterAddress {
    return Intl.message(
      'Enter address',
      name: 'enterAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter amount`
  String get enterAmount {
    return Intl.message(
      'Enter amount',
      name: 'enterAmount',
      desc: '',
      args: [],
    );
  }

  /// `Enter bank code`
  String get enterBankCode {
    return Intl.message(
      'Enter bank code',
      name: 'enterBankCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter bank name`
  String get enterBankName {
    return Intl.message(
      'Enter bank name',
      name: 'enterBankName',
      desc: '',
      args: [],
    );
  }

  /// `Enter beneficiary name`
  String get enterBeneficiaryName {
    return Intl.message(
      'Enter beneficiary name',
      name: 'enterBeneficiaryName',
      desc: '',
      args: [],
    );
  }

  /// `Enter city`
  String get enterCity {
    return Intl.message(
      'Enter city',
      name: 'enterCity',
      desc: '',
      args: [],
    );
  }

  /// `Enter client ID`
  String get enterClientId {
    return Intl.message(
      'Enter client ID',
      name: 'enterClientId',
      desc: '',
      args: [],
    );
  }

  /// `Enter the 4 digit code that you received on your email`
  String get enterCode {
    return Intl.message(
      'Enter the 4 digit code that you received on your email',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter confirm new password`
  String get enterConfirmNewPassword {
    return Intl.message(
      'Enter confirm new password',
      name: 'enterConfirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter confirm password`
  String get enterConfirmPassword {
    return Intl.message(
      'Enter confirm password',
      name: 'enterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter country`
  String get enterCountry {
    return Intl.message(
      'Enter country',
      name: 'enterCountry',
      desc: '',
      args: [],
    );
  }

  /// `Enter DOB`
  String get enterDOB {
    return Intl.message(
      'Enter DOB',
      name: 'enterDOB',
      desc: '',
      args: [],
    );
  }

  /// `Enter document ID number`
  String get enterDocId {
    return Intl.message(
      'Enter document ID number',
      name: 'enterDocId',
      desc: '',
      args: [],
    );
  }

  /// `Enter email address`
  String get enterEmailAddress {
    return Intl.message(
      'Enter email address',
      name: 'enterEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter institution code`
  String get enterInstitutionCode {
    return Intl.message(
      'Enter institution code',
      name: 'enterInstitutionCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter institution name`
  String get enterInstitutionName {
    return Intl.message(
      'Enter institution name',
      name: 'enterInstitutionName',
      desc: '',
      args: [],
    );
  }

  /// `Enter message`
  String get enterMessage {
    return Intl.message(
      'Enter message',
      name: 'enterMessage',
      desc: '',
      args: [],
    );
  }

  /// `Enter mobile number`
  String get enterMobileNumber {
    return Intl.message(
      'Enter mobile number',
      name: 'enterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter MOMO ID`
  String get enterMomoId {
    return Intl.message(
      'Enter MOMO ID',
      name: 'enterMomoId',
      desc: '',
      args: [],
    );
  }

  /// `Enter new password`
  String get enterNewPassword {
    return Intl.message(
      'Enter new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP Sent to`
  String get enterOTPSent {
    return Intl.message(
      'Enter the OTP Sent to',
      name: 'enterOTPSent',
      desc: '',
      args: [],
    );
  }

  /// `Enter old password`
  String get enterOldPassword {
    return Intl.message(
      'Enter old password',
      name: 'enterOldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterPassword {
    return Intl.message(
      'Enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter payment note`
  String get enterPaymentNote {
    return Intl.message(
      'Enter payment note',
      name: 'enterPaymentNote',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone screen lock pattern, PIN, password or fingerprint`
  String get enterPhoneScreenLockPatternPINPasswordOrFingerprint {
    return Intl.message(
      'Enter phone screen lock pattern, PIN, password or fingerprint',
      name: 'enterPhoneScreenLockPatternPINPasswordOrFingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Enter pincode`
  String get enterPinCode {
    return Intl.message(
      'Enter pincode',
      name: 'enterPinCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter transaction ID`
  String get enterTxnId {
    return Intl.message(
      'Enter transaction ID',
      name: 'enterTxnId',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address for the verificationm process. We will send 4 digite code to your email.`
  String get enterVerificationProcess {
    return Intl.message(
      'Enter your email address for the verificationm process. We will send 4 digite code to your email.',
      name: 'enterVerificationProcess',
      desc: '',
      args: [],
    );
  }

  /// `Enter wallet phone number`
  String get enterWalletPhoneNumber {
    return Intl.message(
      'Enter wallet phone number',
      name: 'enterWalletPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your first name`
  String get enterYourFirstName {
    return Intl.message(
      'Enter your first name',
      name: 'enterYourFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enterYourFullName {
    return Intl.message(
      'Enter your name',
      name: 'enterYourFullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your last name`
  String get enterYourLastName {
    return Intl.message(
      'Enter your last name',
      name: 'enterYourLastName',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get expired {
    return Intl.message(
      'Expired',
      name: 'expired',
      desc: '',
      args: [],
    );
  }

  /// `Explore Home Page`
  String get exploreHomePage {
    return Intl.message(
      'Explore Home Page',
      name: 'exploreHomePage',
      desc: '',
      args: [],
    );
  }

  /// `Failed...`
  String get failed {
    return Intl.message(
      'Failed...',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Family List`
  String get familyList {
    return Intl.message(
      'Family List',
      name: 'familyList',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message(
      'FAQ',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Faster`
  String get faster {
    return Intl.message(
      'Faster',
      name: 'faster',
      desc: '',
      args: [],
    );
  }

  /// `Fee details`
  String get feeDetails {
    return Intl.message(
      'Fee details',
      name: 'feeDetails',
      desc: '',
      args: [],
    );
  }

  /// `Fees`
  String get fees {
    return Intl.message(
      'Fees',
      name: 'fees',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `File downloaded`
  String get fileDownloaded {
    return Intl.message(
      'File downloaded',
      name: 'fileDownloaded',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstName {
    return Intl.message(
      'First name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `For you`
  String get forYou {
    return Intl.message(
      'For you',
      name: 'forYou',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `From now on you are part of us!`
  String get fromNowOnYouArePartOfUs {
    return Intl.message(
      'From now on you are part of us!',
      name: 'fromNowOnYouArePartOfUs',
      desc: '',
      args: [],
    );
  }

  /// `from now on, you are part of us!`
  String get fromUs {
    return Intl.message(
      'from now on, you are part of us!',
      name: 'fromUs',
      desc: '',
      args: [],
    );
  }

  /// `Front image`
  String get frontImage {
    return Intl.message(
      'Front image',
      name: 'frontImage',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Get OTP`
  String get getOtp {
    return Intl.message(
      'Get OTP',
      name: 'getOtp',
      desc: '',
      args: [],
    );
  }

  /// `Get started`
  String get getStarted {
    return Intl.message(
      'Get started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Gift card`
  String get giftCard {
    return Intl.message(
      'Gift card',
      name: 'giftCard',
      desc: '',
      args: [],
    );
  }

  /// `Choose the specific gift card brand and desired value based on your needs and preferences.`
  String get giftCardBtnDescription {
    return Intl.message(
      'Choose the specific gift card brand and desired value based on your needs and preferences.',
      name: 'giftCardBtnDescription',
      desc: '',
      args: [],
    );
  }

  /// `Go back`
  String get goBack {
    return Intl.message(
      'Go back',
      name: 'goBack',
      desc: '',
      args: [],
    );
  }

  /// `Goals`
  String get goals {
    return Intl.message(
      'Goals',
      name: 'goals',
      desc: '',
      args: [],
    );
  }

  /// `Gross total`
  String get grossTotal {
    return Intl.message(
      'Gross total',
      name: 'grossTotal',
      desc: '',
      args: [],
    );
  }

  /// `Have an account?`
  String get haveAnAccount {
    return Intl.message(
      'Have an account?',
      name: 'haveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Hello there sign in to continue`
  String get helloThereSignInToContinue {
    return Intl.message(
      'Hello there sign in to continue',
      name: 'helloThereSignInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Help & support`
  String get helpNSupport {
    return Intl.message(
      'Help & support',
      name: 'helpNSupport',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `You will go to the Transaction history list by pressing History button.`
  String get historyBtnDescription {
    return Intl.message(
      'You will go to the Transaction history list by pressing History button.',
      name: 'historyBtnDescription',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `You will go to the Dashboard by pressing Home button.`
  String get homeBtnDescription {
    return Intl.message(
      'You will go to the Dashboard by pressing Home button.',
      name: 'homeBtnDescription',
      desc: '',
      args: [],
    );
  }

  /// `How much you want to send ?`
  String get howMuchYouWantToSend {
    return Intl.message(
      'How much you want to send ?',
      name: 'howMuchYouWantToSend',
      desc: '',
      args: [],
    );
  }

  /// `In order to completed your KYC, please upload a copy of your identity document`
  String get idVerificationDesc {
    return Intl.message(
      'In order to completed your KYC, please upload a copy of your identity document',
      name: 'idVerificationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Identity verification`
  String get identityVerification {
    return Intl.message(
      'Identity verification',
      name: 'identityVerification',
      desc: '',
      args: [],
    );
  }

  /// `Import QR code`
  String get importQRCode {
    return Intl.message(
      'Import QR code',
      name: 'importQRCode',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get inActive {
    return Intl.message(
      'Inactive',
      name: 'inActive',
      desc: '',
      args: [],
    );
  }

  /// `Includes a letter, digit, and special character`
  String get includesALetterDigitAndSpecialCharacter {
    return Intl.message(
      'Includes a letter, digit, and special character',
      name: 'includesALetterDigitAndSpecialCharacter',
      desc: '',
      args: [],
    );
  }

  /// `Incoming Calls`
  String get incomingCalls {
    return Intl.message(
      'Incoming Calls',
      name: 'incomingCalls',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Institution code`
  String get institutionCode {
    return Intl.message(
      'Institution code',
      name: 'institutionCode',
      desc: '',
      args: [],
    );
  }

  /// `Institution name`
  String get institutionName {
    return Intl.message(
      'Institution name',
      name: 'institutionName',
      desc: '',
      args: [],
    );
  }

  /// `Invoice`
  String get invoice {
    return Intl.message(
      'Invoice',
      name: 'invoice',
      desc: '',
      args: [],
    );
  }

  /// `Invoice already paid. View payment details`
  String get invoiceAlreadyPaid {
    return Intl.message(
      'Invoice already paid. View payment details',
      name: 'invoiceAlreadyPaid',
      desc: '',
      args: [],
    );
  }

  /// `Invoice date`
  String get invoiceDate {
    return Intl.message(
      'Invoice date',
      name: 'invoiceDate',
      desc: '',
      args: [],
    );
  }

  /// `Invoice detail`
  String get invoiceDetail {
    return Intl.message(
      'Invoice detail',
      name: 'invoiceDetail',
      desc: '',
      args: [],
    );
  }

  /// `Invoice generated by`
  String get invoiceGeneratedBy {
    return Intl.message(
      'Invoice generated by',
      name: 'invoiceGeneratedBy',
      desc: '',
      args: [],
    );
  }

  /// `Invoice items`
  String get invoiceItems {
    return Intl.message(
      'Invoice items',
      name: 'invoiceItems',
      desc: '',
      args: [],
    );
  }

  /// `Invoice note`
  String get invoiceNote {
    return Intl.message(
      'Invoice note',
      name: 'invoiceNote',
      desc: '',
      args: [],
    );
  }

  /// `Issued on`
  String get issuedOn {
    return Intl.message(
      'Issued on',
      name: 'issuedOn',
      desc: '',
      args: [],
    );
  }

  /// `Joined us before ?`
  String get joinedUsBefore {
    return Intl.message(
      'Joined us before ?',
      name: 'joinedUsBefore',
      desc: '',
      args: [],
    );
  }

  /// `KYC`
  String get kyc {
    return Intl.message(
      'KYC',
      name: 'kyc',
      desc: '',
      args: [],
    );
  }

  /// `KYC details`
  String get kycDetails {
    return Intl.message(
      'KYC details',
      name: 'kycDetails',
      desc: '',
      args: [],
    );
  }

  /// `KYC history`
  String get kycHistory {
    return Intl.message(
      'KYC history',
      name: 'kycHistory',
      desc: '',
      args: [],
    );
  }

  /// `Your KYC is not approved yet, please update your KYC to make transactions.`
  String get kycNotApprovedDialogMessage {
    return Intl.message(
      'Your KYC is not approved yet, please update your KYC to make transactions.',
      name: 'kycNotApprovedDialogMessage',
      desc: '',
      args: [],
    );
  }

  /// `KYC pending`
  String get kycPending {
    return Intl.message(
      'KYC pending',
      name: 'kycPending',
      desc: '',
      args: [],
    );
  }

  /// `KYC status`
  String get kycStatus {
    return Intl.message(
      'KYC status',
      name: 'kycStatus',
      desc: '',
      args: [],
    );
  }

  /// `KYC type`
  String get kycType {
    return Intl.message(
      'KYC type',
      name: 'kycType',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Leave us a message about your questions or inquiries and someone from our team will be in touch soon.`
  String
      get leaveUsAMessageAboutYourQuestionsOrInquiriesAndSomeoneFromOurTeamWillBeInTouchSoon {
    return Intl.message(
      'Leave us a message about your questions or inquiries and someone from our team will be in touch soon.',
      name:
          'leaveUsAMessageAboutYourQuestionsOrInquiriesAndSomeoneFromOurTeamWillBeInTouchSoon',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Linked accounts`
  String get linkedAccounts {
    return Intl.message(
      'Linked accounts',
      name: 'linkedAccounts',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login now`
  String get loginNow {
    return Intl.message(
      'Login now',
      name: 'loginNow',
      desc: '',
      args: [],
    );
  }

  /// ` Login With Apple`
  String get loginWithApple {
    return Intl.message(
      ' Login With Apple',
      name: 'loginWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Login with email`
  String get loginWithEmail {
    return Intl.message(
      'Login with email',
      name: 'loginWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Login With Google`
  String get loginWithGoogle {
    return Intl.message(
      'Login With Google',
      name: 'loginWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Make online`
  String get makeOnline {
    return Intl.message(
      'Make online',
      name: 'makeOnline',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Maximum transfer limit is {code}`
  String maximumTransferLimitIs(Object code) {
    return Intl.message(
      'Maximum transfer limit is $code',
      name: 'maximumTransferLimitIs',
      desc: '',
      args: [code],
    );
  }

  /// `Meet your business`
  String get meetYourBusiness {
    return Intl.message(
      'Meet your business',
      name: 'meetYourBusiness',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Messages moved  to spam`
  String get messagesSpam {
    return Intl.message(
      'Messages moved  to spam',
      name: 'messagesSpam',
      desc: '',
      args: [],
    );
  }

  /// `Minimum order value is`
  String get minimumOrderValueIs {
    return Intl.message(
      'Minimum order value is',
      name: 'minimumOrderValueIs',
      desc: '',
      args: [],
    );
  }

  /// `Minimum transfer limit is {code}`
  String minimumTransferLimitIs(Object code) {
    return Intl.message(
      'Minimum transfer limit is $code',
      name: 'minimumTransferLimitIs',
      desc: '',
      args: [code],
    );
  }

  /// `Missed Calls`
  String get missedCalls {
    return Intl.message(
      'Missed Calls',
      name: 'missedCalls',
      desc: '',
      args: [],
    );
  }

  /// `Mobile No.`
  String get mobileNo {
    return Intl.message(
      'Mobile No.',
      name: 'mobileNo',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number`
  String get mobileNumber {
    return Intl.message(
      'Mobile number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number doesn't exist`
  String get mobileNumberDoesntExist {
    return Intl.message(
      'Mobile number doesn\'t exist',
      name: 'mobileNumberDoesntExist',
      desc: '',
      args: [],
    );
  }

  /// `Mobile operators`
  String get mobileOperators {
    return Intl.message(
      'Mobile operators',
      name: 'mobileOperators',
      desc: '',
      args: [],
    );
  }

  /// `Mobile recharge`
  String get mobileRecharge {
    return Intl.message(
      'Mobile recharge',
      name: 'mobileRecharge',
      desc: '',
      args: [],
    );
  }

  /// `MOMO ID`
  String get momoId {
    return Intl.message(
      'MOMO ID',
      name: 'momoId',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get month {
    return Intl.message(
      'month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `MTN MoMo`
  String get mtnMoMo {
    return Intl.message(
      'MTN MoMo',
      name: 'mtnMoMo',
      desc: '',
      args: [],
    );
  }

  /// `My bills`
  String get myBills {
    return Intl.message(
      'My bills',
      name: 'myBills',
      desc: '',
      args: [],
    );
  }

  /// `My contact`
  String get myContact {
    return Intl.message(
      'My contact',
      name: 'myContact',
      desc: '',
      args: [],
    );
  }

  /// `My subscriptions`
  String get mySubscriptions {
    return Intl.message(
      'My subscriptions',
      name: 'mySubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Name: `
  String get name {
    return Intl.message(
      'Name: ',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `New contact`
  String get newContact {
    return Intl.message(
      'New contact',
      name: 'newContact',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `No account`
  String get noAccount {
    return Intl.message(
      'No account',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `No beneficiary`
  String get noBeneficiary {
    return Intl.message(
      'No beneficiary',
      name: 'noBeneficiary',
      desc: '',
      args: [],
    );
  }

  /// `No contacts`
  String get noContacts {
    return Intl.message(
      'No contacts',
      name: 'noContacts',
      desc: '',
      args: [],
    );
  }

  /// `No country`
  String get noCountry {
    return Intl.message(
      'No country',
      name: 'noCountry',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get noData {
    return Intl.message(
      'No data',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `No document type available`
  String get noDocumentTypeAvailable {
    return Intl.message(
      'No document type available',
      name: 'noDocumentTypeAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No KYC history`
  String get noKycHistory {
    return Intl.message(
      'No KYC history',
      name: 'noKycHistory',
      desc: '',
      args: [],
    );
  }

  /// `No notifications`
  String get noNotifications {
    return Intl.message(
      'No notifications',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Looking like you don't have permission to update or you have not added mandatory data`
  String get noPermissionToUpdateText {
    return Intl.message(
      'Looking like you don\'t have permission to update or you have not added mandatory data',
      name: 'noPermissionToUpdateText',
      desc: '',
      args: [],
    );
  }

  /// `No plans`
  String get noPlans {
    return Intl.message(
      'No plans',
      name: 'noPlans',
      desc: '',
      args: [],
    );
  }

  /// `No primary account`
  String get noPrimaryAccount {
    return Intl.message(
      'No primary account',
      name: 'noPrimaryAccount',
      desc: '',
      args: [],
    );
  }

  /// `No providers`
  String get noProviders {
    return Intl.message(
      'No providers',
      name: 'noProviders',
      desc: '',
      args: [],
    );
  }

  /// `No query`
  String get noQuery {
    return Intl.message(
      'No query',
      name: 'noQuery',
      desc: '',
      args: [],
    );
  }

  /// `No regions`
  String get noRegions {
    return Intl.message(
      'No regions',
      name: 'noRegions',
      desc: '',
      args: [],
    );
  }

  /// `No request`
  String get noRequest {
    return Intl.message(
      'No request',
      name: 'noRequest',
      desc: '',
      args: [],
    );
  }

  /// `No thanks`
  String get noThanks {
    return Intl.message(
      'No thanks',
      name: 'noThanks',
      desc: '',
      args: [],
    );
  }

  /// `No transaction`
  String get noTransaction {
    return Intl.message(
      'No transaction',
      name: 'noTransaction',
      desc: '',
      args: [],
    );
  }

  /// `No validity found`
  String get noValidityFound {
    return Intl.message(
      'No validity found',
      name: 'noValidityFound',
      desc: '',
      args: [],
    );
  }

  /// `No wallet`
  String get noWallet {
    return Intl.message(
      'No wallet',
      name: 'noWallet',
      desc: '',
      args: [],
    );
  }

  /// `Not a member ?`
  String get notAMember {
    return Intl.message(
      'Not a member ?',
      name: 'notAMember',
      desc: '',
      args: [],
    );
  }

  /// `Not active`
  String get notActive {
    return Intl.message(
      'Not active',
      name: 'notActive',
      desc: '',
      args: [],
    );
  }

  /// `Not found`
  String get notFound {
    return Intl.message(
      'Not found',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Not verified`
  String get notVerified {
    return Intl.message(
      'Not verified',
      name: 'notVerified',
      desc: '',
      args: [],
    );
  }

  /// `Note: Document formates are png, jpg, jpeg`
  String get noteDocFormates {
    return Intl.message(
      'Note: Document formates are png, jpg, jpeg',
      name: 'noteDocFormates',
      desc: '',
      args: [],
    );
  }

  /// `Note: Platform fee will be imposed on sender for this transaction.`
  String get notePlatformFeeWillBeImposedOnSenderForThisTransaction {
    return Intl.message(
      'Note: Platform fee will be imposed on sender for this transaction.',
      name: 'notePlatformFeeWillBeImposedOnSenderForThisTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `You will go to the Notifications list by pressing Notifications button.`
  String get notificationsBtnDescription {
    return Intl.message(
      'You will go to the Notifications list by pressing Notifications button.',
      name: 'notificationsBtnDescription',
      desc: '',
      args: [],
    );
  }

  /// `Oh no! The OTP timed out. Please request a new code and try again.`
  String get ohNoTheOTPTimedOutPleaseRequestANewCodeAndTryAgain {
    return Intl.message(
      'Oh no! The OTP timed out. Please request a new code and try again.',
      name: 'ohNoTheOTPTimedOutPleaseRequestANewCodeAndTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Old password`
  String get oldPassword {
    return Intl.message(
      'Old password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `OOPS!\nNo internet`
  String get oopsNoInternet {
    return Intl.message(
      'OOPS!\nNo internet',
      name: 'oopsNoInternet',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Open account`
  String get openAccount {
    return Intl.message(
      'Open account',
      name: 'openAccount',
      desc: '',
      args: [],
    );
  }

  /// `Open app setting`
  String get openAppSetting {
    return Intl.message(
      'Open app setting',
      name: 'openAppSetting',
      desc: '',
      args: [],
    );
  }

  /// `Open Ecobank Xpress account`
  String get openXpressAccount {
    return Intl.message(
      'Open Ecobank Xpress account',
      name: 'openXpressAccount',
      desc: '',
      args: [],
    );
  }

  /// `Open an Ecobank Xpress account instantly with BCTPay`
  String get openXpressAccountViewTitle {
    return Intl.message(
      'Open an Ecobank Xpress account instantly with BCTPay',
      name: 'openXpressAccountViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get orTxt {
    return Intl.message(
      'Or',
      name: 'orTxt',
      desc: '',
      args: [],
    );
  }

  /// `Orange Money`
  String get orangeMoney {
    return Intl.message(
      'Orange Money',
      name: 'orangeMoney',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `OTP`
  String get otp {
    return Intl.message(
      'OTP',
      name: 'otp',
      desc: '',
      args: [],
    );
  }

  /// ` OTP Verification`
  String get otpVerification {
    return Intl.message(
      ' OTP Verification',
      name: 'otpVerification',
      desc: '',
      args: [],
    );
  }

  /// `Outgoing Calls`
  String get outgoingCalls {
    return Intl.message(
      'Outgoing Calls',
      name: 'outgoingCalls',
      desc: '',
      args: [],
    );
  }

  /// `Owned by`
  String get ownedBy {
    return Intl.message(
      'Owned by',
      name: 'ownedBy',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message(
      'Paid',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `Paid to`
  String get paidTo {
    return Intl.message(
      'Paid to',
      name: 'paidTo',
      desc: '',
      args: [],
    );
  }

  /// `PAN card`
  String get panCard {
    return Intl.message(
      'PAN card',
      name: 'panCard',
      desc: '',
      args: [],
    );
  }

  /// `Passport`
  String get passport {
    return Intl.message(
      'Passport',
      name: 'passport',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Password is not matching`
  String get passwordIsNotMatching {
    return Intl.message(
      'Password is not matching',
      name: 'passwordIsNotMatching',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Pay with`
  String get payWith {
    return Intl.message(
      'Pay with',
      name: 'payWith',
      desc: '',
      args: [],
    );
  }

  /// `Payable amount`
  String get payableAmount {
    return Intl.message(
      'Payable amount',
      name: 'payableAmount',
      desc: '',
      args: [],
    );
  }

  /// `Payment date`
  String get paymentDate {
    return Intl.message(
      'Payment date',
      name: 'paymentDate',
      desc: '',
      args: [],
    );
  }

  /// `Payment date and time`
  String get paymentDateAndTime {
    return Intl.message(
      'Payment date and time',
      name: 'paymentDateAndTime',
      desc: '',
      args: [],
    );
  }

  /// `Payment details`
  String get paymentDetails {
    return Intl.message(
      'Payment details',
      name: 'paymentDetails',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get paymentMethod {
    return Intl.message(
      'Payment method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Payment &`
  String get paymentN {
    return Intl.message(
      'Payment &',
      name: 'paymentN',
      desc: '',
      args: [],
    );
  }

  /// `Payment note`
  String get paymentNote {
    return Intl.message(
      'Payment note',
      name: 'paymentNote',
      desc: '',
      args: [],
    );
  }

  /// `Payment requests`
  String get paymentRequests {
    return Intl.message(
      'Payment requests',
      name: 'paymentRequests',
      desc: '',
      args: [],
    );
  }

  /// `Payment status`
  String get paymentStatus {
    return Intl.message(
      'Payment status',
      name: 'paymentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Payment success!`
  String get paymentSuccess {
    return Intl.message(
      'Payment success!',
      name: 'paymentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `$7.99/mth`
  String get personalMth {
    return Intl.message(
      '\$7.99/mth',
      name: 'personalMth',
      desc: '',
      args: [],
    );
  }

  /// `Personal protection`
  String get personalProtection {
    return Intl.message(
      'Personal protection',
      name: 'personalProtection',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Pincode`
  String get pinCode {
    return Intl.message(
      'Pincode',
      name: 'pinCode',
      desc: '',
      args: [],
    );
  }

  /// `Please accept Terms & Conditions`
  String get pleaseAcceptTermsAndConditions {
    return Intl.message(
      'Please accept Terms & Conditions',
      name: 'pleaseAcceptTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Please active your subscription`
  String get pleaseActiveYourSubscription {
    return Intl.message(
      'Please active your subscription',
      name: 'pleaseActiveYourSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Please add atleast one active account`
  String get pleaseAddAtleastOneactiveAccount {
    return Intl.message(
      'Please add atleast one active account',
      name: 'pleaseAddAtleastOneactiveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please check your mail`
  String get pleaseCheckMail {
    return Intl.message(
      'Please check your mail',
      name: 'pleaseCheckMail',
      desc: '',
      args: [],
    );
  }

  /// `Please check your network connection.`
  String get pleaseCheckYourNetworkConnection {
    return Intl.message(
      'Please check your network connection.',
      name: 'pleaseCheckYourNetworkConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your valid Email / Corporate ID`
  String get pleaseCorporateID {
    return Intl.message(
      'Please enter your valid Email / Corporate ID',
      name: 'pleaseCorporateID',
      desc: '',
      args: [],
    );
  }

  /// `Please enter account holder name`
  String get pleaseEnterAccountHolderName {
    return Intl.message(
      'Please enter account holder name',
      name: 'pleaseEnterAccountHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter account number`
  String get pleaseEnterAccountNumber {
    return Intl.message(
      'Please enter account number',
      name: 'pleaseEnterAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter beneficiary name`
  String get pleaseEnterBeneficiaryName {
    return Intl.message(
      'Please enter beneficiary name',
      name: 'pleaseEnterBeneficiaryName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter client ID`
  String get pleaseEnterClientID {
    return Intl.message(
      'Please enter client ID',
      name: 'pleaseEnterClientID',
      desc: '',
      args: [],
    );
  }

  /// `Please enter institution code`
  String get pleaseEnterInstitutionCode {
    return Intl.message(
      'Please enter institution code',
      name: 'pleaseEnterInstitutionCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter message`
  String get pleaseEnterMessage {
    return Intl.message(
      'Please enter message',
      name: 'pleaseEnterMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please enter OTP`
  String get pleaseEnterOTP {
    return Intl.message(
      'Please enter OTP',
      name: 'pleaseEnterOTP',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid amount`
  String get pleaseEnterValidAmount {
    return Intl.message(
      'Please enter valid amount',
      name: 'pleaseEnterValidAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid mobile number`
  String get pleaseEnterValidMobileNumber {
    return Intl.message(
      'Please enter valid mobile number',
      name: 'pleaseEnterValidMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid value`
  String get pleaseEnterValidValue {
    return Intl.message(
      'Please enter valid value',
      name: 'pleaseEnterValidValue',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid wallet phone number`
  String get pleaseEnterValidWalletPhoneNumber {
    return Intl.message(
      'Please enter valid wallet phone number',
      name: 'pleaseEnterValidWalletPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter wallet phone number`
  String get pleaseEnterWalletPhoneNumber {
    return Intl.message(
      'Please enter wallet phone number',
      name: 'pleaseEnterWalletPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your address`
  String get pleaseEnterYourAddress {
    return Intl.message(
      'Please enter your address',
      name: 'pleaseEnterYourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your city`
  String get pleaseEnterYourCity {
    return Intl.message(
      'Please enter your city',
      name: 'pleaseEnterYourCity',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your confirm new password`
  String get pleaseEnterYourConfirmNewPassword {
    return Intl.message(
      'Please enter your confirm new password',
      name: 'pleaseEnterYourConfirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your confirm password`
  String get pleaseEnterYourConfirmPassword {
    return Intl.message(
      'Please enter your confirm password',
      name: 'pleaseEnterYourConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your country`
  String get pleaseEnterYourCountry {
    return Intl.message(
      'Please enter your country',
      name: 'pleaseEnterYourCountry',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address`
  String get pleaseEnterYourEmailAddress {
    return Intl.message(
      'Please enter your email address',
      name: 'pleaseEnterYourEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your first name`
  String get pleaseEnterYourFirstName {
    return Intl.message(
      'Please enter your first name',
      name: 'pleaseEnterYourFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full name`
  String get pleaseEnterYourFullName {
    return Intl.message(
      'Please enter your full name',
      name: 'pleaseEnterYourFullName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your last name`
  String get pleaseEnterYourLastName {
    return Intl.message(
      'Please enter your last name',
      name: 'pleaseEnterYourLastName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your mobile number`
  String get pleaseEnterYourMobileNumber {
    return Intl.message(
      'Please enter your mobile number',
      name: 'pleaseEnterYourMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new password`
  String get pleaseEnterYourNewPassword {
    return Intl.message(
      'Please enter your new password',
      name: 'pleaseEnterYourNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your old password`
  String get pleaseEnterYourOldPassword {
    return Intl.message(
      'Please enter your old password',
      name: 'pleaseEnterYourOldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleaseEnterYourPassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleaseEnterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid email address`
  String get pleaseEnterYourValidEmailAddress {
    return Intl.message(
      'Please enter valid email address',
      name: 'pleaseEnterYourValidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please login to continue`
  String get pleaseLoginToContinue {
    return Intl.message(
      'Please login to continue',
      name: 'pleaseLoginToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a new password to secure your account.`
  String get pleaseSecureAccount {
    return Intl.message(
      'Please enter a new password to secure your account.',
      name: 'pleaseSecureAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please select all mandatory field`
  String get pleaseSelectAllMandatoryField {
    return Intl.message(
      'Please select all mandatory field',
      name: 'pleaseSelectAllMandatoryField',
      desc: '',
      args: [],
    );
  }

  /// `Please select back image`
  String get pleaseSelectBackImage {
    return Intl.message(
      'Please select back image',
      name: 'pleaseSelectBackImage',
      desc: '',
      args: [],
    );
  }

  /// `Please select country phone code`
  String get pleaseSelectCountryPhoneCode {
    return Intl.message(
      'Please select country phone code',
      name: 'pleaseSelectCountryPhoneCode',
      desc: '',
      args: [],
    );
  }

  /// `Please select front image`
  String get pleaseSelectFrontImage {
    return Intl.message(
      'Please select front image',
      name: 'pleaseSelectFrontImage',
      desc: '',
      args: [],
    );
  }

  /// `Please select institution name`
  String get pleaseSelectInstitutionName {
    return Intl.message(
      'Please select institution name',
      name: 'pleaseSelectInstitutionName',
      desc: '',
      args: [],
    );
  }

  /// `Please select your state`
  String get pleaseSelectYourState {
    return Intl.message(
      'Please select your state',
      name: 'pleaseSelectYourState',
      desc: '',
      args: [],
    );
  }

  /// `Please sign up to continue`
  String get pleaseSignUpToContinue {
    return Intl.message(
      'Please sign up to continue',
      name: 'pleaseSignUpToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Please select the type of account you will be setting up today.`
  String get pleaseTxt {
    return Intl.message(
      'Please select the type of account you will be setting up today.',
      name: 'pleaseTxt',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your valid phone number, We will send you a 4 digit code to verify.`
  String get pleaseVerify {
    return Intl.message(
      'Please enter your valid phone number, We will send you a 4 digit code to verify.',
      name: 'pleaseVerify',
      desc: '',
      args: [],
    );
  }

  /// `2024 @ Powered by BCTPay`
  String get poweredBy {
    return Intl.message(
      '2024 @ Powered by BCTPay',
      name: 'poweredBy',
      desc: '',
      args: [],
    );
  }

  /// `Prev`
  String get prev {
    return Intl.message(
      'Prev',
      name: 'prev',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Primary`
  String get primary {
    return Intl.message(
      'Primary',
      name: 'primary',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to pay`
  String get proceedToPay {
    return Intl.message(
      'Proceed to pay',
      name: 'proceedToPay',
      desc: '',
      args: [],
    );
  }

  /// `Product name`
  String get productName {
    return Intl.message(
      'Product name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Product TAX`
  String get productTax {
    return Intl.message(
      'Product TAX',
      name: 'productTax',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Protect AI email`
  String get protectAIEmail {
    return Intl.message(
      'Protect AI email',
      name: 'protectAIEmail',
      desc: '',
      args: [],
    );
  }

  /// `Protect AI messages`
  String get protectAIMessages {
    return Intl.message(
      'Protect AI messages',
      name: 'protectAIMessages',
      desc: '',
      args: [],
    );
  }

  /// `Protection type`
  String get protectionType {
    return Intl.message(
      'Protection type',
      name: 'protectionType',
      desc: '',
      args: [],
    );
  }

  /// `QR scan`
  String get qrscan {
    return Intl.message(
      'QR scan',
      name: 'qrscan',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Queries`
  String get queries {
    return Intl.message(
      'Queries',
      name: 'queries',
      desc: '',
      args: [],
    );
  }

  /// `Query history`
  String get queryHistory {
    return Intl.message(
      'Query history',
      name: 'queryHistory',
      desc: '',
      args: [],
    );
  }

  /// `Query type`
  String get queryType {
    return Intl.message(
      'Query type',
      name: 'queryType',
      desc: '',
      args: [],
    );
  }

  /// `Read all notifications`
  String get readAllNotifications {
    return Intl.message(
      'Read all notifications',
      name: 'readAllNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Recapture`
  String get recapture {
    return Intl.message(
      'Recapture',
      name: 'recapture',
      desc: '',
      args: [],
    );
  }

  /// `Receivable account`
  String get receivableAccount {
    return Intl.message(
      'Receivable account',
      name: 'receivableAccount',
      desc: '',
      args: [],
    );
  }

  /// `Received`
  String get received {
    return Intl.message(
      'Received',
      name: 'received',
      desc: '',
      args: [],
    );
  }

  /// `Received by`
  String get receivedBy {
    return Intl.message(
      'Received by',
      name: 'receivedBy',
      desc: '',
      args: [],
    );
  }

  /// `Received into`
  String get receivedInto {
    return Intl.message(
      'Received into',
      name: 'receivedInto',
      desc: '',
      args: [],
    );
  }

  /// `Receiver details`
  String get receiverDetails {
    return Intl.message(
      'Receiver details',
      name: 'receiverDetails',
      desc: '',
      args: [],
    );
  }

  /// `Recent`
  String get recent {
    return Intl.message(
      'Recent',
      name: 'recent',
      desc: '',
      args: [],
    );
  }

  /// `Recent Transaction`
  String get recentTransaction {
    return Intl.message(
      'Recent Transaction',
      name: 'recentTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Recharge`
  String get recharge {
    return Intl.message(
      'Recharge',
      name: 'recharge',
      desc: '',
      args: [],
    );
  }

  /// `Recharge any mobile by entering mobile number or by choosing contact from your contact list.`
  String get rechargeBtnDescription {
    return Intl.message(
      'Recharge any mobile by entering mobile number or by choosing contact from your contact list.',
      name: 'rechargeBtnDescription',
      desc: '',
      args: [],
    );
  }

  /// `Recharge has been successfully done`
  String get rechargehasBeenSuccessfullyDone {
    return Intl.message(
      'Recharge has been successfully done',
      name: 'rechargehasBeenSuccessfullyDone',
      desc: '',
      args: [],
    );
  }

  /// `Recover password`
  String get recoverPassword {
    return Intl.message(
      'Recover password',
      name: 'recoverPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Register now`
  String get registerNow {
    return Intl.message(
      'Register now',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `Register with Apple`
  String get registerWithApple {
    return Intl.message(
      'Register with Apple',
      name: 'registerWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Register with email`
  String get registerWithEmail {
    return Intl.message(
      'Register with email',
      name: 'registerWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Register with Google`
  String get registerWithGoogle {
    return Intl.message(
      'Register with Google',
      name: 'registerWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Registration Successful`
  String get registrationSuccessful {
    return Intl.message(
      'Registration Successful',
      name: 'registrationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get reject {
    return Intl.message(
      'Reject',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get rejected {
    return Intl.message(
      'Rejected',
      name: 'rejected',
      desc: '',
      args: [],
    );
  }

  /// `Relation`
  String get relation {
    return Intl.message(
      'Relation',
      name: 'relation',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Rent`
  String get rent {
    return Intl.message(
      'Rent',
      name: 'rent',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter Password`
  String get renterPassword {
    return Intl.message(
      'Re-enter Password',
      name: 'renterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get request {
    return Intl.message(
      'Request',
      name: 'request',
      desc: '',
      args: [],
    );
  }

  /// `Request again`
  String get requestAgain {
    return Intl.message(
      'Request again',
      name: 'requestAgain',
      desc: '',
      args: [],
    );
  }

  /// `Request amount`
  String get requestAmount {
    return Intl.message(
      'Request amount',
      name: 'requestAmount',
      desc: '',
      args: [],
    );
  }

  /// `Request detail`
  String get requestDetails {
    return Intl.message(
      'Request detail',
      name: 'requestDetails',
      desc: '',
      args: [],
    );
  }

  /// `Request OTP`
  String get requestOTP {
    return Intl.message(
      'Request OTP',
      name: 'requestOTP',
      desc: '',
      args: [],
    );
  }

  /// `Request payment`
  String get requestPayment {
    return Intl.message(
      'Request payment',
      name: 'requestPayment',
      desc: '',
      args: [],
    );
  }

  /// `Request permission`
  String get requestPermission {
    return Intl.message(
      'Request permission',
      name: 'requestPermission',
      desc: '',
      args: [],
    );
  }

  /// `Request to`
  String get requestTo {
    return Intl.message(
      'Request to',
      name: 'requestTo',
      desc: '',
      args: [],
    );
  }

  /// `Request to pay`
  String get requestToPay {
    return Intl.message(
      'Request to pay',
      name: 'requestToPay',
      desc: '',
      args: [],
    );
  }

  /// `Requesting from`
  String get requestingFrom {
    return Intl.message(
      'Requesting from',
      name: 'requestingFrom',
      desc: '',
      args: [],
    );
  }

  /// `Rescan`
  String get rescan {
    return Intl.message(
      'Rescan',
      name: 'rescan',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Resend Otp`
  String get resendOtp {
    return Intl.message(
      'Resend Otp',
      name: 'resendOtp',
      desc: '',
      args: [],
    );
  }

  /// `Resend verification link`
  String get resendVerificationLink {
    return Intl.message(
      'Resend verification link',
      name: 'resendVerificationLink',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Roaming`
  String get roaming {
    return Intl.message(
      'Roaming',
      name: 'roaming',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get scan {
    return Intl.message(
      'Scan',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR codes and make transactions.`
  String get scanBtnDescription {
    return Intl.message(
      'Scan QR codes and make transactions.',
      name: 'scanBtnDescription',
      desc: '',
      args: [],
    );
  }

  /// `Scan & pay using BCTPay app`
  String get scanPayUsingBCTPayApp {
    return Intl.message(
      'Scan & pay using BCTPay app',
      name: 'scanPayUsingBCTPayApp',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR`
  String get scanQR {
    return Intl.message(
      'Scan QR',
      name: 'scanQR',
      desc: '',
      args: [],
    );
  }

  /// `Scratch here`
  String get scratchHere {
    return Intl.message(
      'Scratch here',
      name: 'scratchHere',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Search country`
  String get searchCountry {
    return Intl.message(
      'Search country',
      name: 'searchCountry',
      desc: '',
      args: [],
    );
  }

  /// `Search here...`
  String get searchHere {
    return Intl.message(
      'Search here...',
      name: 'searchHere',
      desc: '',
      args: [],
    );
  }

  /// `Search numbers,names & more`
  String get searchMore {
    return Intl.message(
      'Search numbers,names & more',
      name: 'searchMore',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message(
      'Security',
      name: 'security',
      desc: '',
      args: [],
    );
  }

  /// `See query history`
  String get seeQueryHistory {
    return Intl.message(
      'See query history',
      name: 'seeQueryHistory',
      desc: '',
      args: [],
    );
  }

  /// `Select account`
  String get selectAccount {
    return Intl.message(
      'Select account',
      name: 'selectAccount',
      desc: '',
      args: [],
    );
  }

  /// `Select account to receive into`
  String get selectAccountToReceiveInto {
    return Intl.message(
      'Select account to receive into',
      name: 'selectAccountToReceiveInto',
      desc: '',
      args: [],
    );
  }

  /// `Select bank account to transfer from`
  String get selectBankAccountToTransferFrom {
    return Intl.message(
      'Select bank account to transfer from',
      name: 'selectBankAccountToTransferFrom',
      desc: '',
      args: [],
    );
  }

  /// `Select bank account to transfer to`
  String get selectBankAccountToTransferTo {
    return Intl.message(
      'Select bank account to transfer to',
      name: 'selectBankAccountToTransferTo',
      desc: '',
      args: [],
    );
  }

  /// `Select language`
  String get selectLanguage {
    return Intl.message(
      'Select language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select state`
  String get selectState {
    return Intl.message(
      'Select state',
      name: 'selectState',
      desc: '',
      args: [],
    );
  }

  /// `Select validity`
  String get selectValidity {
    return Intl.message(
      'Select validity',
      name: 'selectValidity',
      desc: '',
      args: [],
    );
  }

  /// `Select your document type`
  String get selectYourDocumentType {
    return Intl.message(
      'Select your document type',
      name: 'selectYourDocumentType',
      desc: '',
      args: [],
    );
  }

  /// `Self transfer`
  String get selfTransfer {
    return Intl.message(
      'Self transfer',
      name: 'selfTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Selfie verification`
  String get selfieVerification {
    return Intl.message(
      'Selfie verification',
      name: 'selfieVerification',
      desc: '',
      args: [],
    );
  }

  /// `In order to completed your KYC, please capture your selfie`
  String get selfieVerificationDesc {
    return Intl.message(
      'In order to completed your KYC, please capture your selfie',
      name: 'selfieVerificationDesc',
      desc: '',
      args: [],
    );
  }

  /// `The selfie is being checked for accuracy. If it's not correct, you should either recapture it or proceed with the existing image.`
  String get selfieVerificationPurpose {
    return Intl.message(
      'The selfie is being checked for accuracy. If it\'s not correct, you should either recapture it or proceed with the existing image.',
      name: 'selfieVerificationPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Hold your phone at eye level and look directly into the camera and press capture button to take a photo`
  String get selfieVerificationTnC {
    return Intl.message(
      'Hold your phone at eye level and look directly into the camera and press capture button to take a photo',
      name: 'selfieVerificationTnC',
      desc: '',
      args: [],
    );
  }

  /// `Send money`
  String get sendMoney {
    return Intl.message(
      'Send money',
      name: 'sendMoney',
      desc: '',
      args: [],
    );
  }

  /// `You can make transactions to your added beneficiaries and you can also manage beneficiaries.`
  String get sendMoneyBtnDescription {
    return Intl.message(
      'You can make transactions to your added beneficiaries and you can also manage beneficiaries.',
      name: 'sendMoneyBtnDescription',
      desc: '',
      args: [],
    );
  }

  /// `Sender details`
  String get senderDetails {
    return Intl.message(
      'Sender details',
      name: 'senderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Sender name`
  String get senderName {
    return Intl.message(
      'Sender name',
      name: 'senderName',
      desc: '',
      args: [],
    );
  }

  /// `Sending amount`
  String get sendingAmount {
    return Intl.message(
      'Sending amount',
      name: 'sendingAmount',
      desc: '',
      args: [],
    );
  }

  /// `Sending to`
  String get sendingTo {
    return Intl.message(
      'Sending to',
      name: 'sendingTo',
      desc: '',
      args: [],
    );
  }

  /// `Sent`
  String get sent {
    return Intl.message(
      'Sent',
      name: 'sent',
      desc: '',
      args: [],
    );
  }

  /// `Sent from`
  String get sentFrom {
    return Intl.message(
      'Sent from',
      name: 'sentFrom',
      desc: '',
      args: [],
    );
  }

  /// `Server error`
  String get serverError {
    return Intl.message(
      'Server error',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Set active`
  String get setActive {
    return Intl.message(
      'Set active',
      name: 'setActive',
      desc: '',
      args: [],
    );
  }

  /// `Set as primary account`
  String get setAsPrimaryAccount {
    return Intl.message(
      'Set as primary account',
      name: 'setAsPrimaryAccount',
      desc: '',
      args: [],
    );
  }

  /// `Set inactive`
  String get setInActive {
    return Intl.message(
      'Set inactive',
      name: 'setInActive',
      desc: '',
      args: [],
    );
  }

  /// `Set primary`
  String get setPrimary {
    return Intl.message(
      'Set primary',
      name: 'setPrimary',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Side menu`
  String get sideMenu {
    return Intl.message(
      'Side menu',
      name: 'sideMenu',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Sms`
  String get sms {
    return Intl.message(
      'Sms',
      name: 'sms',
      desc: '',
      args: [],
    );
  }

  /// `$11.98/mth`
  String get smsMth {
    return Intl.message(
      '\$11.98/mth',
      name: 'smsMth',
      desc: '',
      args: [],
    );
  }

  /// `Spam calls identified`
  String get spamIdentified {
    return Intl.message(
      'Spam calls identified',
      name: 'spamIdentified',
      desc: '',
      args: [],
    );
  }

  /// `Spam call blocking, AI Protect scam detection, SMS protect & Email`
  String get spamSMSEmail {
    return Intl.message(
      'Spam call blocking, AI Protect scam detection, SMS protect & Email',
      name: 'spamSMSEmail',
      desc: '',
      args: [],
    );
  }

  /// `Spam call blocking, AI Protect scam detection and SMS protect`
  String get spamSMSProtect {
    return Intl.message(
      'Spam call blocking, AI Protect scam detection and SMS protect',
      name: 'spamSMSProtect',
      desc: '',
      args: [],
    );
  }

  /// `Spam call blocking and AI Protect scam detection`
  String get spamScamDetection {
    return Intl.message(
      'Spam call blocking and AI Protect scam detection',
      name: 'spamScamDetection',
      desc: '',
      args: [],
    );
  }

  /// `Staff`
  String get staff {
    return Intl.message(
      'Staff',
      name: 'staff',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get success {
    return Intl.message(
      'Success!',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Successful`
  String get successful {
    return Intl.message(
      'Successful',
      name: 'successful',
      desc: '',
      args: [],
    );
  }

  /// `Support Pin`
  String get supportPin {
    return Intl.message(
      'Support Pin',
      name: 'supportPin',
      desc: '',
      args: [],
    );
  }

  /// `Take a selfie`
  String get takeASelfie {
    return Intl.message(
      'Take a selfie',
      name: 'takeASelfie',
      desc: '',
      args: [],
    );
  }

  /// `TAX`
  String get tax {
    return Intl.message(
      'TAX',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `This field shouldn't be empty`
  String get thisFieldShouldNotBeEmpty {
    return Intl.message(
      'This field shouldn\'t be empty',
      name: 'thisFieldShouldNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `This fuctionality will available soon`
  String get thisFuctionalityWillAvailableSoon {
    return Intl.message(
      'This fuctionality will available soon',
      name: 'thisFuctionalityWillAvailableSoon',
      desc: '',
      args: [],
    );
  }

  /// `Time saved from spammers`
  String get timeSpammers {
    return Intl.message(
      'Time saved from spammers',
      name: 'timeSpammers',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get tnc {
    return Intl.message(
      'Terms & Conditions',
      name: 'tnc',
      desc: '',
      args: [],
    );
  }

  /// `To self account`
  String get toSelfAccount {
    return Intl.message(
      'To self account',
      name: 'toSelfAccount',
      desc: '',
      args: [],
    );
  }

  /// `Transfer money to your self accounts even you can manage your accounts from here.`
  String get toSelfAccountBtnDescription {
    return Intl.message(
      'Transfer money to your self accounts even you can manage your accounts from here.',
      name: 'toSelfAccountBtnDescription',
      desc: '',
      args: [],
    );
  }

  /// `Top-Up`
  String get topUp {
    return Intl.message(
      'Top-Up',
      name: 'topUp',
      desc: '',
      args: [],
    );
  }

  /// `Total amount`
  String get totalAmount {
    return Intl.message(
      'Total amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Total pay`
  String get totalPay {
    return Intl.message(
      'Total pay',
      name: 'totalPay',
      desc: '',
      args: [],
    );
  }

  /// `Total payment`
  String get totalPayment {
    return Intl.message(
      'Total payment',
      name: 'totalPayment',
      desc: '',
      args: [],
    );
  }

  /// `Total product price`
  String get totalProductPrice {
    return Intl.message(
      'Total product price',
      name: 'totalProductPrice',
      desc: '',
      args: [],
    );
  }

  /// `Total TAX amount`
  String get totalTaxAmount {
    return Intl.message(
      'Total TAX amount',
      name: 'totalTaxAmount',
      desc: '',
      args: [],
    );
  }

  /// `Transaction details`
  String get transactionDetails {
    return Intl.message(
      'Transaction details',
      name: 'transactionDetails',
      desc: '',
      args: [],
    );
  }

  /// `Transaction fee: `
  String get transactionFee {
    return Intl.message(
      'Transaction fee: ',
      name: 'transactionFee',
      desc: '',
      args: [],
    );
  }

  /// `Transaction ID`
  String get transactionId {
    return Intl.message(
      'Transaction ID',
      name: 'transactionId',
      desc: '',
      args: [],
    );
  }

  /// `Transaction status`
  String get transactionStatus {
    return Intl.message(
      'Transaction status',
      name: 'transactionStatus',
      desc: '',
      args: [],
    );
  }

  /// `Transaction type`
  String get transactionType {
    return Intl.message(
      'Transaction type',
      name: 'transactionType',
      desc: '',
      args: [],
    );
  }

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message(
      'Transfer',
      name: 'transfer',
      desc: '',
      args: [],
    );
  }

  /// `Transfer details`
  String get transferDetails {
    return Intl.message(
      'Transfer details',
      name: 'transferDetails',
      desc: '',
      args: [],
    );
  }

  /// `Transfer from`
  String get transferFrom {
    return Intl.message(
      'Transfer from',
      name: 'transferFrom',
      desc: '',
      args: [],
    );
  }

  /// `Transfer money to`
  String get transferMoneyTo {
    return Intl.message(
      'Transfer money to',
      name: 'transferMoneyTo',
      desc: '',
      args: [],
    );
  }

  /// `Transfer now`
  String get transferNow {
    return Intl.message(
      'Transfer now',
      name: 'transferNow',
      desc: '',
      args: [],
    );
  }

  /// `Transfer to`
  String get transferTo {
    return Intl.message(
      'Transfer to',
      name: 'transferTo',
      desc: '',
      args: [],
    );
  }

  /// `Try again..`
  String get tryAgain {
    return Intl.message(
      'Try again..',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Unknown number identified`
  String get unknownIdentified {
    return Intl.message(
      'Unknown number identified',
      name: 'unknownIdentified',
      desc: '',
      args: [],
    );
  }

  /// `Unlock BCTPay`
  String get unlockBCTPay {
    return Intl.message(
      'Unlock BCTPay',
      name: 'unlockBCTPay',
      desc: '',
      args: [],
    );
  }

  /// `Unlock now`
  String get unlockNow {
    return Intl.message(
      'Unlock now',
      name: 'unlockNow',
      desc: '',
      args: [],
    );
  }

  /// `Unpaid`
  String get unpaid {
    return Intl.message(
      'Unpaid',
      name: 'unpaid',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Update bank account`
  String get updateBankAccount {
    return Intl.message(
      'Update bank account',
      name: 'updateBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Update beneficiary`
  String get updateBeneficiary {
    return Intl.message(
      'Update beneficiary',
      name: 'updateBeneficiary',
      desc: '',
      args: [],
    );
  }

  /// `Update KYC`
  String get updateKyc {
    return Intl.message(
      'Update KYC',
      name: 'updateKyc',
      desc: '',
      args: [],
    );
  }

  /// `Update profile`
  String get updateProfile {
    return Intl.message(
      'Update profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade to Premium`
  String get upgradePremium {
    return Intl.message(
      'Upgrade to Premium',
      name: 'upgradePremium',
      desc: '',
      args: [],
    );
  }

  /// `Upload back image of document`
  String get uploadBackImageOfDoc {
    return Intl.message(
      'Upload back image of document',
      name: 'uploadBackImageOfDoc',
      desc: '',
      args: [],
    );
  }

  /// `Upload following documents`
  String get uploadFollowingDocuments {
    return Intl.message(
      'Upload following documents',
      name: 'uploadFollowingDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Upload front image of document`
  String get uploadFrontImageOfDoc {
    return Intl.message(
      'Upload front image of document',
      name: 'uploadFrontImageOfDoc',
      desc: '',
      args: [],
    );
  }

  /// `Upload image`
  String get uploadImage {
    return Intl.message(
      'Upload image',
      name: 'uploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Upload your address document`
  String get uploadYourAddressDocument {
    return Intl.message(
      'Upload your address document',
      name: 'uploadYourAddressDocument',
      desc: '',
      args: [],
    );
  }

  /// `upto`
  String get upto {
    return Intl.message(
      'upto',
      name: 'upto',
      desc: '',
      args: [],
    );
  }

  /// `User name`
  String get userName {
    return Intl.message(
      'User name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Valid`
  String get valid {
    return Intl.message(
      'Valid',
      name: 'valid',
      desc: '',
      args: [],
    );
  }

  /// `Valid from`
  String get validFrom {
    return Intl.message(
      'Valid from',
      name: 'validFrom',
      desc: '',
      args: [],
    );
  }

  /// `Validity`
  String get validity {
    return Intl.message(
      'Validity',
      name: 'validity',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get verificationCode {
    return Intl.message(
      'Verification code',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Verified`
  String get verified {
    return Intl.message(
      'Verified',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Verify and Proceed`
  String get verifyProceed {
    return Intl.message(
      'Verify and Proceed',
      name: 'verifyProceed',
      desc: '',
      args: [],
    );
  }

  /// `View account`
  String get viewAccount {
    return Intl.message(
      'View account',
      name: 'viewAccount',
      desc: '',
      args: [],
    );
  }

  /// `View plan`
  String get viewPlan {
    return Intl.message(
      'View plan',
      name: 'viewPlan',
      desc: '',
      args: [],
    );
  }

  /// `Voter ID card`
  String get voterIdCard {
    return Intl.message(
      'Voter ID card',
      name: 'voterIdCard',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Wallet balance`
  String get walletBalance {
    return Intl.message(
      'Wallet balance',
      name: 'walletBalance',
      desc: '',
      args: [],
    );
  }

  /// `Wallet phone number`
  String get walletPhoneNumber {
    return Intl.message(
      'Wallet phone number',
      name: 'walletPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Warning!`
  String get warning {
    return Intl.message(
      'Warning!',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Water`
  String get water {
    return Intl.message(
      'Water',
      name: 'water',
      desc: '',
      args: [],
    );
  }

  /// `We have sent the code verification to your mobile number`
  String get weHaveSentTheCodeVerificationToYourMobileNumber {
    return Intl.message(
      'We have sent the code verification to your mobile number',
      name: 'weHaveSentTheCodeVerificationToYourMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `WELCOME`
  String get welcome {
    return Intl.message(
      'WELCOME',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcomeBack {
    return Intl.message(
      'Welcome back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to BROADLINK Protect your mobile defender! Effortlessly block unwanted calls, messages and keep your device clean let's get started and take control of your communication!`
  String get welcomeTxt {
    return Intl.message(
      'Welcome to BROADLINK Protect your mobile defender! Effortlessly block unwanted calls, messages and keep your device clean let\'s get started and take control of your communication!',
      name: 'welcomeTxt',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Yey!`
  String get yey {
    return Intl.message(
      'Yey!',
      name: 'yey',
      desc: '',
      args: [],
    );
  }

  /// `You can update your profile from here`
  String get yoCanUpdateYourProfileFromHere {
    return Intl.message(
      'You can update your profile from here',
      name: 'yoCanUpdateYourProfileFromHere',
      desc: '',
      args: [],
    );
  }

  /// `You are protected against all the dangerous phone numbers from our security database`
  String
      get youAreProtectedAgainstAllTheDangerousPhoneNumbersFromOurSecurityDatabase {
    return Intl.message(
      'You are protected against all the dangerous phone numbers from our security database',
      name:
          'youAreProtectedAgainstAllTheDangerousPhoneNumbersFromOurSecurityDatabase',
      desc: '',
      args: [],
    );
  }

  /// `You can do any online payment from any card or account. Just scan the QR code & enjoy.`
  String
      get youCanDoAnyOnlinePaymentFromAnyCardOrAccountJustScanTheQRCodeNEnjoy {
    return Intl.message(
      'You can do any online payment from any card or account. Just scan the QR code & enjoy.',
      name:
          'youCanDoAnyOnlinePaymentFromAnyCardOrAccountJustScanTheQRCodeNEnjoy',
      desc: '',
      args: [],
    );
  }

  /// `You can get upto`
  String get youCanGetUpto {
    return Intl.message(
      'You can get upto',
      name: 'youCanGetUpto',
      desc: '',
      args: [],
    );
  }

  /// `You can not transfer amount to yourself. Select other account to proceed.`
  String get youCanNotTransferAmountToYourselfSelectOtherAccountToProceed {
    return Intl.message(
      'You can not transfer amount to yourself. Select other account to proceed.',
      name: 'youCanNotTransferAmountToYourselfSelectOtherAccountToProceed',
      desc: '',
      args: [],
    );
  }

  /// `You can't retry yet!`
  String get youCantRetryYet {
    return Intl.message(
      'You can\'t retry yet!',
      name: 'youCantRetryYet',
      desc: '',
      args: [],
    );
  }

  /// `Your`
  String get your {
    return Intl.message(
      'Your',
      name: 'your',
      desc: '',
      args: [],
    );
  }

  /// `Your emails are currently being screened by protect AI to detect potential scam and safe guard your data and financials`
  String
      get yourEmailsAreCurrentlyBeingScreenedByProtectAIToDetectPotentialScamAndSafeGuardYourDataAndFinancials {
    return Intl.message(
      'Your emails are currently being screened by protect AI to detect potential scam and safe guard your data and financials',
      name:
          'yourEmailsAreCurrentlyBeingScreenedByProtectAIToDetectPotentialScamAndSafeGuardYourDataAndFinancials',
      desc: '',
      args: [],
    );
  }

  /// `Your goals will help us to formulate the right recommendations for success.`
  String get yourGoalsWillHelpUsToFormulateTheRightRecommendationsForSuccess {
    return Intl.message(
      'Your goals will help us to formulate the right recommendations for success.',
      name: 'yourGoalsWillHelpUsToFormulateTheRightRecommendationsForSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Your messages are currently being screened by Detect AI to identity potential scams.`
  String
      get yourMessagesAreCurrentlyBeingScreenedByDetectAIToIdentityPotentialScams {
    return Intl.message(
      'Your messages are currently being screened by Detect AI to identity potential scams.',
      name:
          'yourMessagesAreCurrentlyBeingScreenedByDetectAIToIdentityPotentialScams',
      desc: '',
      args: [],
    );
  }

  /// `Your new password must be different from previously used password.`
  String get yourNewPasswordMustBeDifferentFromPreviouslyUsedPassword {
    return Intl.message(
      'Your new password must be different from previously used password.',
      name: 'yourNewPasswordMustBeDifferentFromPreviouslyUsedPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been changed successfully .`
  String get yourPasswordHasBeenChangedSuccessfully {
    return Intl.message(
      'Your password has been changed successfully .',
      name: 'yourPasswordHasBeenChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been reset successfully .`
  String get yourPasswordHasBeenResetSuccessfully {
    return Intl.message(
      'Your password has been reset successfully .',
      name: 'yourPasswordHasBeenResetSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your payment has been successfully done.`
  String get yourPaymentHasBeenSuccessfullyDone {
    return Intl.message(
      'Your payment has been successfully done.',
      name: 'yourPaymentHasBeenSuccessfullyDone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an alternative email to secure your account.`
  String get secureEmail {
    return Intl.message(
      'Please enter an alternative email to secure your account.',
      name: 'secureEmail',
      desc: '',
      args: [],
    );
  }

  /// `Change Security Pin`
  String get changeSecurity {
    return Intl.message(
      'Change Security Pin',
      name: 'changeSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Notifications List`
  String get notificationList {
    return Intl.message(
      'Notifications List',
      name: 'notificationList',
      desc: '',
      args: [],
    );
  }

  /// `Edit Member`
  String get editMember {
    return Intl.message(
      'Edit Member',
      name: 'editMember',
      desc: '',
      args: [],
    );
  }

  /// `Add Member`
  String get addMember {
    return Intl.message(
      'Add Member',
      name: 'addMember',
      desc: '',
      args: [],
    );
  }

  /// `Delete Member`
  String get deleteMember {
    return Intl.message(
      'Delete Member',
      name: 'deleteMember',
      desc: '',
      args: [],
    );
  }

  /// `Edit Staff Member`
  String get editStaffMember {
    return Intl.message(
      'Edit Staff Member',
      name: 'editStaffMember',
      desc: '',
      args: [],
    );
  }

  /// `Add Staff Member`
  String get addStaffMember {
    return Intl.message(
      'Add Staff Member',
      name: 'addStaffMember',
      desc: '',
      args: [],
    );
  }

  /// `Delete Staff Member`
  String get deleteStaffMember {
    return Intl.message(
      'Delete Staff Member',
      name: 'deleteStaffMember',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address for the verification process. We will send 4 digit code to your email.`
  String get forgotPassDetails {
    return Intl.message(
      'Enter your email address for the verification process. We will send 4 digit code to your email.',
      name: 'forgotPassDetails',
      desc: '',
      args: [],
    );
  }

  /// `Spam Calls`
  String get spamCalls {
    return Intl.message(
      'Spam Calls',
      name: 'spamCalls',
      desc: '',
      args: [],
    );
  }

  /// `Choose an option`
  String get chooseOption {
    return Intl.message(
      'Choose an option',
      name: 'chooseOption',
      desc: '',
      args: [],
    );
  }

  /// `Take a Photo`
  String get takePhoto {
    return Intl.message(
      'Take a Photo',
      name: 'takePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Choose from Gallery`
  String get chooseGallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'chooseGallery',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelText {
    return Intl.message(
      'Cancel',
      name: 'cancelText',
      desc: '',
      args: [],
    );
  }

  /// `Zip Code`
  String get zip {
    return Intl.message(
      'Zip Code',
      name: 'zip',
      desc: '',
      args: [],
    );
  }

  /// `Address 1`
  String get address1 {
    return Intl.message(
      'Address 1',
      name: 'address1',
      desc: '',
      args: [],
    );
  }

  /// `Address 2`
  String get address2 {
    return Intl.message(
      'Address 2',
      name: 'address2',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submitText {
    return Intl.message(
      'Submit',
      name: 'submitText',
      desc: '',
      args: [],
    );
  }

  /// `Position`
  String get position {
    return Intl.message(
      'Position',
      name: 'position',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
