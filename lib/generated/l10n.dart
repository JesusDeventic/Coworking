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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `VACoworking`
  String get appName {
    return Intl.message('VACoworking', name: 'appName', desc: '', args: []);
  }

  /// `Sign in`
  String get signIn {
    return Intl.message('Sign in', name: 'signIn', desc: '', args: []);
  }

  /// `Create account`
  String get signUp {
    return Intl.message('Create account', name: 'signUp', desc: '', args: []);
  }

  /// `Username or email`
  String get userOrEmail {
    return Intl.message(
      'Username or email',
      name: 'userOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Keep me signed in`
  String get keepSession {
    return Intl.message(
      'Keep me signed in',
      name: 'keepSession',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
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

  /// `Current password`
  String get currentPassword {
    return Intl.message(
      'Current password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Display name (optional)`
  String get displayName {
    return Intl.message(
      'Display name (optional)',
      name: 'displayName',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get sendCode {
    return Intl.message('Send code', name: 'sendCode', desc: '', args: []);
  }

  /// `Verification code (6 digits)`
  String get verificationCode {
    return Intl.message(
      'Verification code (6 digits)',
      name: 'verificationCode',
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

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Light mode`
  String get themeLight {
    return Intl.message('Light mode', name: 'themeLight', desc: '', args: []);
  }

  /// `Dark mode`
  String get themeDark {
    return Intl.message('Dark mode', name: 'themeDark', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Current version`
  String get currentAppVersionText {
    return Intl.message(
      'Current version',
      name: 'currentAppVersionText',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Could not verify the captcha. Please try again.`
  String get recaptchaError {
    return Intl.message(
      'Could not verify the captcha. Please try again.',
      name: 'recaptchaError',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get fieldRequired {
    return Intl.message(
      'This field is required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `At least 6 characters`
  String get passwordMinLength {
    return Intl.message(
      'At least 6 characters',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `At least 4 characters`
  String get usernameMinLength {
    return Intl.message(
      'At least 4 characters',
      name: 'usernameMinLength',
      desc: '',
      args: [],
    );
  }

  /// `I have read and accept the`
  String get registerTermsAndConditionsAccept {
    return Intl.message(
      'I have read and accept the',
      name: 'registerTermsAndConditionsAccept',
      desc: '',
      args: [],
    );
  }

  /// `I agree to receive promotions and marketing communications`
  String get registerMarketingConsentAccept {
    return Intl.message(
      'I agree to receive promotions and marketing communications',
      name: 'registerMarketingConsentAccept',
      desc: '',
      args: [],
    );
  }

  /// `You must accept the terms and conditions and privacy policy`
  String get registerTermsAndConditionsError {
    return Intl.message(
      'You must accept the terms and conditions and privacy policy',
      name: 'registerTermsAndConditionsError',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get andLabel {
    return Intl.message('and', name: 'andLabel', desc: '', args: []);
  }

  /// `The code must be 6 digits`
  String get code6Digits {
    return Intl.message(
      'The code must be 6 digits',
      name: 'code6Digits',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message('Welcome!', name: 'welcome', desc: '', args: []);
  }

  /// `If the account exists, a code has been sent to your email.`
  String get codeSent {
    return Intl.message(
      'If the account exists, a code has been sent to your email.',
      name: 'codeSent',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successfully.`
  String get passwordChanged {
    return Intl.message(
      'Password reset successfully.',
      name: 'passwordChanged',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `Changelog`
  String get appVersionChangeLogTitle {
    return Intl.message(
      'Changelog',
      name: 'appVersionChangeLogTitle',
      desc: '',
      args: [],
    );
  }

  /// `v1.0.0`
  String get appVersion10Code {
    return Intl.message('v1.0.0', name: 'appVersion10Code', desc: '', args: []);
  }

  /// `·Initial release of VACoworking.`
  String get appVersion10Description {
    return Intl.message(
      '·Initial release of VACoworking.',
      name: 'appVersion10Description',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get languageArabic {
    return Intl.message('Arabic', name: 'languageArabic', desc: '', args: []);
  }

  /// `Catalan`
  String get languageCatalan {
    return Intl.message('Catalan', name: 'languageCatalan', desc: '', args: []);
  }

  /// `Chinese`
  String get languageChinese {
    return Intl.message('Chinese', name: 'languageChinese', desc: '', args: []);
  }

  /// `Dutch`
  String get languageDutch {
    return Intl.message('Dutch', name: 'languageDutch', desc: '', args: []);
  }

  /// `English`
  String get languageEnglish {
    return Intl.message('English', name: 'languageEnglish', desc: '', args: []);
  }

  /// `French`
  String get languageFrench {
    return Intl.message('French', name: 'languageFrench', desc: '', args: []);
  }

  /// `German`
  String get languageGerman {
    return Intl.message('German', name: 'languageGerman', desc: '', args: []);
  }

  /// `Hindi`
  String get languageHindi {
    return Intl.message('Hindi', name: 'languageHindi', desc: '', args: []);
  }

  /// `Indonesian`
  String get languageIndonesian {
    return Intl.message(
      'Indonesian',
      name: 'languageIndonesian',
      desc: '',
      args: [],
    );
  }

  /// `Italian`
  String get languageItalian {
    return Intl.message('Italian', name: 'languageItalian', desc: '', args: []);
  }

  /// `Japanese`
  String get languageJapanese {
    return Intl.message(
      'Japanese',
      name: 'languageJapanese',
      desc: '',
      args: [],
    );
  }

  /// `Korean`
  String get languageKorean {
    return Intl.message('Korean', name: 'languageKorean', desc: '', args: []);
  }

  /// `Polish`
  String get languagePolish {
    return Intl.message('Polish', name: 'languagePolish', desc: '', args: []);
  }

  /// `Portuguese`
  String get languagePortuguese {
    return Intl.message(
      'Portuguese',
      name: 'languagePortuguese',
      desc: '',
      args: [],
    );
  }

  /// `Romanian`
  String get languageRomanian {
    return Intl.message(
      'Romanian',
      name: 'languageRomanian',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get languageRussian {
    return Intl.message('Russian', name: 'languageRussian', desc: '', args: []);
  }

  /// `Spanish`
  String get languageSpanish {
    return Intl.message('Spanish', name: 'languageSpanish', desc: '', args: []);
  }

  /// `Swedish`
  String get languageSwedish {
    return Intl.message('Swedish', name: 'languageSwedish', desc: '', args: []);
  }

  /// `Turkish`
  String get languageTurkish {
    return Intl.message('Turkish', name: 'languageTurkish', desc: '', args: []);
  }

  /// `Ukrainian`
  String get languageUkrainian {
    return Intl.message(
      'Ukrainian',
      name: 'languageUkrainian',
      desc: '',
      args: [],
    );
  }

  /// `Private messages`
  String get privateMessages {
    return Intl.message(
      'Private messages',
      name: 'privateMessages',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notificationsLabel {
    return Intl.message(
      'Notifications',
      name: 'notificationsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Push notifications`
  String get pushNotificationsLabel {
    return Intl.message(
      'Push notifications',
      name: 'pushNotificationsLabel',
      desc: '',
      args: [],
    );
  }

  /// `You have no notifications.`
  String get notificationsEmptyText {
    return Intl.message(
      'You have no notifications.',
      name: 'notificationsEmptyText',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get buttonReloadNotifications {
    return Intl.message(
      'Reload',
      name: 'buttonReloadNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Mark all as read`
  String get markAllAsRead {
    return Intl.message(
      'Mark all as read',
      name: 'markAllAsRead',
      desc: '',
      args: [],
    );
  }

  /// `Mark all notifications as read?`
  String get notificationMarkAllAsk {
    return Intl.message(
      'Mark all notifications as read?',
      name: 'notificationMarkAllAsk',
      desc: '',
      args: [],
    );
  }

  /// `Notification marked as read.`
  String get notificationMarkedRead {
    return Intl.message(
      'Notification marked as read.',
      name: 'notificationMarkedRead',
      desc: '',
      args: [],
    );
  }

  /// `All notifications marked as read.`
  String get notificationsAllMarkedRead {
    return Intl.message(
      'All notifications marked as read.',
      name: 'notificationsAllMarkedRead',
      desc: '',
      args: [],
    );
  }

  /// `Could not mark the notification as read.`
  String get notificationMarkReadError {
    return Intl.message(
      'Could not mark the notification as read.',
      name: 'notificationMarkReadError',
      desc: '',
      args: [],
    );
  }

  /// `Delete all notifications`
  String get deleteAllNotifications {
    return Intl.message(
      'Delete all notifications',
      name: 'deleteAllNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Delete all notifications?`
  String get notificationDeleteAllAsk {
    return Intl.message(
      'Delete all notifications?',
      name: 'notificationDeleteAllAsk',
      desc: '',
      args: [],
    );
  }

  /// `Notifications deleted.`
  String get notificationsDeletedOk {
    return Intl.message(
      'Notifications deleted.',
      name: 'notificationsDeletedOk',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete notifications.`
  String get notificationsDeletedError {
    return Intl.message(
      'Could not delete notifications.',
      name: 'notificationsDeletedError',
      desc: '',
      args: [],
    );
  }

  /// `No more items.`
  String get noMoreRecords {
    return Intl.message(
      'No more items.',
      name: 'noMoreRecords',
      desc: '',
      args: [],
    );
  }

  /// `Device notification permissions`
  String get notificationsPermissionHint {
    return Intl.message(
      'Device notification permissions',
      name: 'notificationsPermissionHint',
      desc: '',
      args: [],
    );
  }

  /// `ON`
  String get notificationsStatusOn {
    return Intl.message(
      'ON',
      name: 'notificationsStatusOn',
      desc: '',
      args: [],
    );
  }

  /// `OFF`
  String get notificationsStatusOff {
    return Intl.message(
      'OFF',
      name: 'notificationsStatusOff',
      desc: '',
      args: [],
    );
  }

  /// `Open settings`
  String get notificationsPermissionOpenSettings {
    return Intl.message(
      'Open settings',
      name: 'notificationsPermissionOpenSettings',
      desc: '',
      args: [],
    );
  }

  /// `Notifications in the browser`
  String get notificationsWebSettingsTitle {
    return Intl.message(
      'Notifications in the browser',
      name: 'notificationsWebSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `For security, we cannot open the browser settings. To allow or block notifications for this site, tap the lock icon next to the address bar → Site settings → Notifications.`
  String get notificationsWebSettingsBody {
    return Intl.message(
      'For security, we cannot open the browser settings. To allow or block notifications for this site, tap the lock icon next to the address bar → Site settings → Notifications.',
      name: 'notificationsWebSettingsBody',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsLabel {
    return Intl.message('Settings', name: 'settingsLabel', desc: '', args: []);
  }

  /// `General settings`
  String get generalSettings {
    return Intl.message(
      'General settings',
      name: 'generalSettings',
      desc: '',
      args: [],
    );
  }

  /// `Settings saved successfully.`
  String get generalSettingsSaveSuccess {
    return Intl.message(
      'Settings saved successfully.',
      name: 'generalSettingsSaveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not save settings. Check your connection and try again.`
  String get generalSettingsSaveErrorGeneric {
    return Intl.message(
      'Could not save settings. Check your connection and try again.',
      name: 'generalSettingsSaveErrorGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Settings cannot be saved. Please sign in again.`
  String get generalSettingsSaveErrorSession {
    return Intl.message(
      'Settings cannot be saved. Please sign in again.',
      name: 'generalSettingsSaveErrorSession',
      desc: '',
      args: [],
    );
  }

  /// `Could not open system settings.`
  String get generalSettingsOpenSystemSettingsError {
    return Intl.message(
      'Could not open system settings.',
      name: 'generalSettingsOpenSystemSettingsError',
      desc: '',
      args: [],
    );
  }

  /// `Start of week`
  String get weekStart {
    return Intl.message('Start of week', name: 'weekStart', desc: '', args: []);
  }

  /// `Monday`
  String get weekStartMonday {
    return Intl.message('Monday', name: 'weekStartMonday', desc: '', args: []);
  }

  /// `Sunday`
  String get weekStartSunday {
    return Intl.message('Sunday', name: 'weekStartSunday', desc: '', args: []);
  }

  /// `Date format`
  String get dateFormat {
    return Intl.message('Date format', name: 'dateFormat', desc: '', args: []);
  }

  /// `View my profile`
  String get showMyProfile {
    return Intl.message(
      'View my profile',
      name: 'showMyProfile',
      desc: '',
      args: [],
    );
  }

  /// `Account settings`
  String get accountSettings {
    return Intl.message(
      'Account settings',
      name: 'accountSettings',
      desc: '',
      args: [],
    );
  }

  /// `FAQs`
  String get userSectionFAQs {
    return Intl.message('FAQs', name: 'userSectionFAQs', desc: '', args: []);
  }

  /// `Contact`
  String get userSectionContact {
    return Intl.message(
      'Contact',
      name: 'userSectionContact',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get userSectionSessionClose {
    return Intl.message(
      'Log out',
      name: 'userSectionSessionClose',
      desc: '',
      args: [],
    );
  }

  /// `Exit the app`
  String get dialogCloseAppTitle {
    return Intl.message(
      'Exit the app',
      name: 'dialogCloseAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to exit the app?`
  String get dialogCloseAppContent {
    return Intl.message(
      'Are you sure you want to exit the app?',
      name: 'dialogCloseAppContent',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get buttonClose {
    return Intl.message('Close', name: 'buttonClose', desc: '', args: []);
  }

  /// `Are you sure you want to log out?`
  String get dialogCloseSessionContent {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'dialogCloseSessionContent',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get actionNo {
    return Intl.message('No', name: 'actionNo', desc: '', args: []);
  }

  /// `Yes`
  String get actionYes {
    return Intl.message('Yes', name: 'actionYes', desc: '', args: []);
  }

  /// `Home`
  String get menuHome {
    return Intl.message('Home', name: 'menuHome', desc: '', args: []);
  }

  /// `No invitations created yet`
  String get homeEmptyInvitationsTitle {
    return Intl.message(
      'No invitations created yet',
      name: 'homeEmptyInvitationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap Create invitation to get started`
  String get homeEmptyInvitationsSubtitle {
    return Intl.message(
      'Tap Create invitation to get started',
      name: 'homeEmptyInvitationsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Create invitation`
  String get homeCreateInvitationButton {
    return Intl.message(
      'Create invitation',
      name: 'homeCreateInvitationButton',
      desc: '',
      args: [],
    );
  }

  /// `Collapse`
  String get collapseMenu {
    return Intl.message('Collapse', name: 'collapseMenu', desc: '', args: []);
  }

  /// `Expand`
  String get expandMenu {
    return Intl.message('Expand', name: 'expandMenu', desc: '', args: []);
  }

  /// `Go to home`
  String get goToHome {
    return Intl.message('Go to home', name: 'goToHome', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Incorrect credentials`
  String get wrongCredentials {
    return Intl.message(
      'Incorrect credentials',
      name: 'wrongCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect username or password.\nPlease wait {seconds} seconds before trying again.`
  String loginCountdownMessage(Object seconds) {
    return Intl.message(
      'Incorrect username or password.\nPlease wait $seconds seconds before trying again.',
      name: 'loginCountdownMessage',
      desc: '',
      args: [seconds],
    );
  }

  /// `Registration error`
  String get registerError {
    return Intl.message(
      'Registration error',
      name: 'registerError',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get dialogErrorTitle {
    return Intl.message('Error', name: 'dialogErrorTitle', desc: '', args: []);
  }

  /// `Could not connect to the VACoworking server.`
  String get dialogErrorServerConnection {
    return Intl.message(
      'Could not connect to the VACoworking server.',
      name: 'dialogErrorServerConnection',
      desc: '',
      args: [],
    );
  }

  /// `A new version of VACoworking is available.\nUpdate the app to continue.`
  String get dialogErrorAppVersion {
    return Intl.message(
      'A new version of VACoworking is available.\nUpdate the app to continue.',
      name: 'dialogErrorAppVersion',
      desc: '',
      args: [],
    );
  }

  /// `The app is currently under maintenance. Please try again later.`
  String get dialogErrorServerMaintenance {
    return Intl.message(
      'The app is currently under maintenance. Please try again later.',
      name: 'dialogErrorServerMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `Available version`
  String get currentServerVersionText {
    return Intl.message(
      'Available version',
      name: 'currentServerVersionText',
      desc: '',
      args: [],
    );
  }

  /// `Attention`
  String get dialogWarningTitle {
    return Intl.message(
      'Attention',
      name: 'dialogWarningTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save your changes?`
  String get dialogConfirmSave {
    return Intl.message(
      'Save your changes?',
      name: 'dialogConfirmSave',
      desc: '',
      args: [],
    );
  }

  /// `Need help? Reach us through any of our channels and we will get back to you as soon as possible.`
  String get textUserSupportDescription {
    return Intl.message(
      'Need help? Reach us through any of our channels and we will get back to you as soon as possible.',
      name: 'textUserSupportDescription',
      desc: '',
      args: [],
    );
  }

  /// `Could not open the link.`
  String get socialWebError {
    return Intl.message(
      'Could not open the link.',
      name: 'socialWebError',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get socialWhatsappLabel {
    return Intl.message(
      'WhatsApp',
      name: 'socialWhatsappLabel',
      desc: '',
      args: [],
    );
  }

  /// `Could not open WhatsApp.`
  String get socialWhatsappError {
    return Intl.message(
      'Could not open WhatsApp.',
      name: 'socialWhatsappError',
      desc: '',
      args: [],
    );
  }

  /// `Social media`
  String get menuBarSectionSocial {
    return Intl.message(
      'Social media',
      name: 'menuBarSectionSocial',
      desc: '',
      args: [],
    );
  }

  /// `Follow us on social media.`
  String get socialNetworksText {
    return Intl.message(
      'Follow us on social media.',
      name: 'socialNetworksText',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPoliciesLabel {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPoliciesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Terms and conditions`
  String get termsAndConditionsLabel {
    return Intl.message(
      'Terms and conditions',
      name: 'termsAndConditionsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cookie policy`
  String get cookiePolicyLabel {
    return Intl.message(
      'Cookie policy',
      name: 'cookiePolicyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Legal notice`
  String get legalNoticeLabel {
    return Intl.message(
      'Legal notice',
      name: 'legalNoticeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get socialMailLabel {
    return Intl.message('Email', name: 'socialMailLabel', desc: '', args: []);
  }

  /// `Telegram`
  String get socialTelegramLabel {
    return Intl.message(
      'Telegram',
      name: 'socialTelegramLabel',
      desc: '',
      args: [],
    );
  }

  /// `VACoworking contact`
  String get subjectSupport {
    return Intl.message(
      'VACoworking contact',
      name: 'subjectSupport',
      desc: '',
      args: [],
    );
  }

  /// `What is VACoworking?`
  String get faq1Question {
    return Intl.message(
      'What is VACoworking?',
      name: 'faq1Question',
      desc: '',
      args: [],
    );
  }

  /// `It is an informational app about available coworking spaces, categorized by services and features. It lets you search and filter by different criteria to find the perfect place to work.`
  String get faq1Answer {
    return Intl.message(
      'It is an informational app about available coworking spaces, categorized by services and features. It lets you search and filter by different criteria to find the perfect place to work.',
      name: 'faq1Answer',
      desc: '',
      args: [],
    );
  }

  /// `Can I add coworking spaces?`
  String get faq2Question {
    return Intl.message(
      'Can I add coworking spaces?',
      name: 'faq2Question',
      desc: '',
      args: [],
    );
  }

  /// `Only app administrators can add coworking spaces. To include more spaces, you need to contact the app team.`
  String get faq2Answer {
    return Intl.message(
      'Only app administrators can add coworking spaces. To include more spaces, you need to contact the app team.',
      name: 'faq2Answer',
      desc: '',
      args: [],
    );
  }

  /// `How do notifications work?`
  String get faq3Question {
    return Intl.message(
      'How do notifications work?',
      name: 'faq3Question',
      desc: '',
      args: [],
    );
  }

  /// `When you allow notifications, alerts are sent to your device with updates or important news about coworking spaces. You can configure notifications in the app settings.`
  String get faq3Answer {
    return Intl.message(
      'When you allow notifications, alerts are sent to your device with updates or important news about coworking spaces. You can configure notifications in the app settings.',
      name: 'faq3Answer',
      desc: '',
      args: [],
    );
  }

  /// `Username must be 4–20 characters and may only contain letters, numbers, hyphens and underscores.`
  String get errorAuthInvalidUsername {
    return Intl.message(
      'Username must be 4–20 characters and may only contain letters, numbers, hyphens and underscores.',
      name: 'errorAuthInvalidUsername',
      desc: '',
      args: [],
    );
  }

  /// `The email is not valid.`
  String get errorAuthInvalidEmail {
    return Intl.message(
      'The email is not valid.',
      name: 'errorAuthInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters.`
  String get errorAuthInvalidPassword {
    return Intl.message(
      'Password must be at least 6 characters.',
      name: 'errorAuthInvalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `That username is already taken.`
  String get errorAuthUsernameExists {
    return Intl.message(
      'That username is already taken.',
      name: 'errorAuthUsernameExists',
      desc: '',
      args: [],
    );
  }

  /// `That email is already registered.`
  String get errorAuthEmailExists {
    return Intl.message(
      'That email is already registered.',
      name: 'errorAuthEmailExists',
      desc: '',
      args: [],
    );
  }

  /// `Registration could not be completed. Please try again.`
  String get errorAuthRegisterFailed {
    return Intl.message(
      'Registration could not be completed. Please try again.',
      name: 'errorAuthRegisterFailed',
      desc: '',
      args: [],
    );
  }

  /// `Could not create a session. Please try again later.`
  String get errorAuthSessionFailed {
    return Intl.message(
      'Could not create a session. Please try again later.',
      name: 'errorAuthSessionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts. Please try again later.`
  String get errorAuthTooManyRequests {
    return Intl.message(
      'Too many attempts. Please try again later.',
      name: 'errorAuthTooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `Required fields are missing.`
  String get errorAuthMissingFields {
    return Intl.message(
      'Required fields are missing.',
      name: 'errorAuthMissingFields',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect username or password.`
  String get errorAuthInvalidCredentials {
    return Intl.message(
      'Incorrect username or password.',
      name: 'errorAuthInvalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `You must enter a username or email.`
  String get errorAuthMissingLogin {
    return Intl.message(
      'You must enter a username or email.',
      name: 'errorAuthMissingLogin',
      desc: '',
      args: [],
    );
  }

  /// `The code is not valid.`
  String get errorAuthInvalidCode {
    return Intl.message(
      'The code is not valid.',
      name: 'errorAuthInvalidCode',
      desc: '',
      args: [],
    );
  }

  /// `You have exceeded the maximum number of attempts.`
  String get errorAuthTooManyAttempts {
    return Intl.message(
      'You have exceeded the maximum number of attempts.',
      name: 'errorAuthTooManyAttempts',
      desc: '',
      args: [],
    );
  }

  /// `The code has expired.`
  String get errorAuthExpiredCode {
    return Intl.message(
      'The code has expired.',
      name: 'errorAuthExpiredCode',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get errorAuthGeneric {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'errorAuthGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password.`
  String get errorAuthWrongPassword {
    return Intl.message(
      'Incorrect password.',
      name: 'errorAuthWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete the account. Please try again.`
  String get errorAuthDeleteAccountFailed {
    return Intl.message(
      'Could not delete the account. Please try again.',
      name: 'errorAuthDeleteAccountFailed',
      desc: '',
      args: [],
    );
  }

  /// `Avatar`
  String get userAvatar {
    return Intl.message('Avatar', name: 'userAvatar', desc: '', args: []);
  }

  /// `Remove avatar`
  String get buttonDeleteAvatar {
    return Intl.message(
      'Remove avatar',
      name: 'buttonDeleteAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get userDescription {
    return Intl.message('Bio', name: 'userDescription', desc: '', args: []);
  }

  /// `Email`
  String get userEmail {
    return Intl.message('Email', name: 'userEmail', desc: '', args: []);
  }

  /// `Country`
  String get textfieldUserCountryLabel {
    return Intl.message(
      'Country',
      name: 'textfieldUserCountryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get textfieldUserBirthdayLabel {
    return Intl.message(
      'Date of birth',
      name: 'textfieldUserBirthdayLabel',
      desc: '',
      args: [],
    );
  }

  /// `Display name`
  String get textfieldDisplayNameLabel {
    return Intl.message(
      'Display name',
      name: 'textfieldDisplayNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get textfieldMailEmpty {
    return Intl.message(
      'Email is required',
      name: 'textfieldMailEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get textfieldMailError {
    return Intl.message(
      'Invalid email',
      name: 'textfieldMailError',
      desc: '',
      args: [],
    );
  }

  /// `years old`
  String get userYears {
    return Intl.message('years old', name: 'userYears', desc: '', args: []);
  }

  /// `Delete account`
  String get buttonDeleteAccount {
    return Intl.message(
      'Delete account',
      name: 'buttonDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? This cannot be undone.\nEnter your password to confirm.`
  String get dialogDeleteAccount {
    return Intl.message(
      'Are you sure you want to delete your account? This cannot be undone.\nEnter your password to confirm.',
      name: 'dialogDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get dialogDeleteAccountPassword {
    return Intl.message(
      'Password',
      name: 'dialogDeleteAccountPassword',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully.`
  String get messageUpdateSuccess {
    return Intl.message(
      'Profile updated successfully.',
      name: 'messageUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not update profile.`
  String get messageUpdateError {
    return Intl.message(
      'Could not update profile.',
      name: 'messageUpdateError',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong.`
  String get messageGeneralError {
    return Intl.message(
      'Something went wrong.',
      name: 'messageGeneralError',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully.`
  String get messageDeleteAccountSuccess {
    return Intl.message(
      'Account deleted successfully.',
      name: 'messageDeleteAccountSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete account.`
  String get messageDeleteAccountError {
    return Intl.message(
      'Could not delete account.',
      name: 'messageDeleteAccountError',
      desc: '',
      args: [],
    );
  }

  /// `Could not process the image.`
  String get errorProcessingImage {
    return Intl.message(
      'Could not process the image.',
      name: 'errorProcessingImage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get buttonConfirm {
    return Intl.message('Confirm', name: 'buttonConfirm', desc: '', args: []);
  }

  /// `Cancel`
  String get buttonCancel {
    return Intl.message('Cancel', name: 'buttonCancel', desc: '', args: []);
  }

  /// `You have no conversations yet.`
  String get messagesEmpty {
    return Intl.message(
      'You have no conversations yet.',
      name: 'messagesEmpty',
      desc: '',
      args: [],
    );
  }

  /// `No messages yet. Say something!`
  String get messagesNoMessages {
    return Intl.message(
      'No messages yet. Say something!',
      name: 'messagesNoMessages',
      desc: '',
      args: [],
    );
  }

  /// `Message deleted`
  String get messagesDeleted {
    return Intl.message(
      'Message deleted',
      name: 'messagesDeleted',
      desc: '',
      args: [],
    );
  }

  /// `edited`
  String get messagesEdited {
    return Intl.message('edited', name: 'messagesEdited', desc: '', args: []);
  }

  /// `Write a message...`
  String get messagesTypeHint {
    return Intl.message(
      'Write a message...',
      name: 'messagesTypeHint',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get messagesSend {
    return Intl.message('Send', name: 'messagesSend', desc: '', args: []);
  }

  /// `Edit`
  String get messagesEdit {
    return Intl.message('Edit', name: 'messagesEdit', desc: '', args: []);
  }

  /// `Delete`
  String get messagesDelete {
    return Intl.message('Delete', name: 'messagesDelete', desc: '', args: []);
  }

  /// `Delete this message?`
  String get messagesDeleteConfirm {
    return Intl.message(
      'Delete this message?',
      name: 'messagesDeleteConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get messagesRead {
    return Intl.message('Read', name: 'messagesRead', desc: '', args: []);
  }

  /// `Sent`
  String get messagesSent {
    return Intl.message('Sent', name: 'messagesSent', desc: '', args: []);
  }

  /// `Could not send the message.`
  String get messagesErrorSend {
    return Intl.message(
      'Could not send the message.',
      name: 'messagesErrorSend',
      desc: '',
      args: [],
    );
  }

  /// `Could not edit the message.`
  String get messagesErrorEdit {
    return Intl.message(
      'Could not edit the message.',
      name: 'messagesErrorEdit',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete the message.`
  String get messagesErrorDelete {
    return Intl.message(
      'Could not delete the message.',
      name: 'messagesErrorDelete',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get buttonChangePassword {
    return Intl.message(
      'Change password',
      name: 'buttonChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully.`
  String get messageChangePasswordSuccess {
    return Intl.message(
      'Password changed successfully.',
      name: 'messageChangePasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `User profile`
  String get publicProfileAppBarTitle {
    return Intl.message(
      'User profile',
      name: 'publicProfileAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `We could not find this user.`
  String get userNotFoundPublicProfileText {
    return Intl.message(
      'We could not find this user.',
      name: 'userNotFoundPublicProfileText',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retryPublicProfile {
    return Intl.message(
      'Retry',
      name: 'retryPublicProfile',
      desc: '',
      args: [],
    );
  }

  /// `Send message`
  String get sendMessageTooltip {
    return Intl.message(
      'Send message',
      name: 'sendMessageTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get shareTooltip {
    return Intl.message('Share', name: 'shareTooltip', desc: '', args: []);
  }

  /// `Copy link`
  String get copyProfileLink {
    return Intl.message(
      'Copy link',
      name: 'copyProfileLink',
      desc: '',
      args: [],
    );
  }

  /// `Link copied`
  String get copiedProfileLinkSnackbar {
    return Intl.message(
      'Link copied',
      name: 'copiedProfileLinkSnackbar',
      desc: '',
      args: [],
    );
  }

  /// `Show QR`
  String get showQrOption {
    return Intl.message('Show QR', name: 'showQrOption', desc: '', args: []);
  }

  /// `Share`
  String get shareOption {
    return Intl.message('Share', name: 'shareOption', desc: '', args: []);
  }

  /// `QR for @{username}`
  String qrTitle(Object username) {
    return Intl.message(
      'QR for @$username',
      name: 'qrTitle',
      desc: '',
      args: [username],
    );
  }

  /// `Profile of @{username} on VACoworking`
  String profileShareSubject(Object username) {
    return Intl.message(
      'Profile of @$username on VACoworking',
      name: 'profileShareSubject',
      desc: '',
      args: [username],
    );
  }

  /// `Last seen`
  String get lastAccessChipPrefix {
    return Intl.message(
      'Last seen',
      name: 'lastAccessChipPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get statusLabel {
    return Intl.message('Status', name: 'statusLabel', desc: '', args: []);
  }

  /// `Bio`
  String get bioLabel {
    return Intl.message('Bio', name: 'bioLabel', desc: '', args: []);
  }

  /// `Website / blog`
  String get webBlogLabel {
    return Intl.message(
      'Website / blog',
      name: 'webBlogLabel',
      desc: '',
      args: [],
    );
  }

  /// `https://yoursite.com`
  String get webBlogHint {
    return Intl.message(
      'https://yoursite.com',
      name: 'webBlogHint',
      desc: '',
      args: [],
    );
  }

  /// `Remove country`
  String get removeCountryTooltip {
    return Intl.message(
      'Remove country',
      name: 'removeCountryTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Remove date`
  String get removeBirthdateTooltip {
    return Intl.message(
      'Remove date',
      name: 'removeBirthdateTooltip',
      desc: '',
      args: [],
    );
  }

  /// `This feature requires you to sign in`
  String get authRequiredFunctionMessage {
    return Intl.message(
      'This feature requires you to sign in',
      name: 'authRequiredFunctionMessage',
      desc: '',
      args: [],
    );
  }

  /// `GO`
  String get authRequiredFunctionAction {
    return Intl.message(
      'GO',
      name: 'authRequiredFunctionAction',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get notificationsNewBadge {
    return Intl.message(
      'New',
      name: 'notificationsNewBadge',
      desc: '',
      args: [],
    );
  }

  /// `Find a great place to work`
  String get homeHeroTitle {
    return Intl.message(
      'Find a great place to work',
      name: 'homeHeroTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search coworking spaces`
  String get homeSearchCoworkingButton {
    return Intl.message(
      'Search coworking spaces',
      name: 'homeSearchCoworkingButton',
      desc: '',
      args: [],
    );
  }

  /// `Enter without user`
  String get enterWithoutUser {
    return Intl.message(
      'Enter without user',
      name: 'enterWithoutUser',
      desc: '',
      args: [],
    );
  }

  /// `Coworking in Valladolid`
  String get titleAppBar {
    return Intl.message(
      'Coworking in Valladolid',
      name: 'titleAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Search by name or service`
  String get searchByKeyWord {
    return Intl.message(
      'Search by name or service',
      name: 'searchByKeyWord',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Main room`
  String get mainRoom {
    return Intl.message('Main room', name: 'mainRoom', desc: '', args: []);
  }

  /// `Services`
  String get services {
    return Intl.message('Services', name: 'services', desc: '', args: []);
  }

  /// `more services`
  String get moreServices {
    return Intl.message(
      'more services',
      name: 'moreServices',
      desc: '',
      args: [],
    );
  }

  /// `See all details`
  String get seeAllDetails {
    return Intl.message(
      'See all details',
      name: 'seeAllDetails',
      desc: '',
      args: [],
    );
  }

  /// `Could not open`
  String get couldNotOpenContact {
    return Intl.message(
      'Could not open',
      name: 'couldNotOpenContact',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Equipment`
  String get equipment {
    return Intl.message('Equipment', name: 'equipment', desc: '', args: []);
  }

  /// `Available rooms`
  String get availableRooms {
    return Intl.message(
      'Available rooms',
      name: 'availableRooms',
      desc: '',
      args: [],
    );
  }

  /// `Capacity`
  String get capacity {
    return Intl.message('Capacity', name: 'capacity', desc: '', args: []);
  }

  /// `people`
  String get people {
    return Intl.message('people', name: 'people', desc: '', args: []);
  }

  /// `Contact`
  String get contact {
    return Intl.message('Contact', name: 'contact', desc: '', args: []);
  }

  /// `Tel:`
  String get tel {
    return Intl.message('Tel:', name: 'tel', desc: '', args: []);
  }

  /// `Consultation about`
  String get contactSubject {
    return Intl.message(
      'Consultation about',
      name: 'contactSubject',
      desc: '',
      args: [],
    );
  }

  /// `24/7 Access`
  String get service_access {
    return Intl.message(
      '24/7 Access',
      name: 'service_access',
      desc: '',
      args: [],
    );
  }

  /// `Fiscal domiciliation`
  String get service_fiscal_domiciliation {
    return Intl.message(
      'Fiscal domiciliation',
      name: 'service_fiscal_domiciliation',
      desc: '',
      args: [],
    );
  }

  /// `Cleaning`
  String get service_cleaning {
    return Intl.message(
      'Cleaning',
      name: 'service_cleaning',
      desc: '',
      args: [],
    );
  }

  /// `WiFi`
  String get service_wifi {
    return Intl.message('WiFi', name: 'service_wifi', desc: '', args: []);
  }

  /// `Autonomous access`
  String get service_autonomous_access {
    return Intl.message(
      'Autonomous access',
      name: 'service_autonomous_access',
      desc: '',
      args: [],
    );
  }

  /// `Social domiciliation`
  String get service_social_domiciliation {
    return Intl.message(
      'Social domiciliation',
      name: 'service_social_domiciliation',
      desc: '',
      args: [],
    );
  }

  /// `Networking`
  String get service_networking {
    return Intl.message(
      'Networking',
      name: 'service_networking',
      desc: '',
      args: [],
    );
  }

  /// `Workshops`
  String get service_workshops {
    return Intl.message(
      'Workshops',
      name: 'service_workshops',
      desc: '',
      args: [],
    );
  }

  /// `Phone support`
  String get service_phone_support {
    return Intl.message(
      'Phone support',
      name: 'service_phone_support',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get service_events {
    return Intl.message('Events', name: 'service_events', desc: '', args: []);
  }

  /// `Reception`
  String get service_reception {
    return Intl.message(
      'Reception',
      name: 'service_reception',
      desc: '',
      args: [],
    );
  }

  /// `Relax zone`
  String get service_relax_zone {
    return Intl.message(
      'Relax zone',
      name: 'service_relax_zone',
      desc: '',
      args: [],
    );
  }

  /// `Coffee / beverages`
  String get service_coffee_beverages {
    return Intl.message(
      'Coffee / beverages',
      name: 'service_coffee_beverages',
      desc: '',
      args: [],
    );
  }

  /// `Training`
  String get service_training {
    return Intl.message(
      'Training',
      name: 'service_training',
      desc: '',
      args: [],
    );
  }

  /// `Mail reception`
  String get service_mail_reception {
    return Intl.message(
      'Mail reception',
      name: 'service_mail_reception',
      desc: '',
      args: [],
    );
  }

  /// `Catering`
  String get service_catering {
    return Intl.message(
      'Catering',
      name: 'service_catering',
      desc: '',
      args: [],
    );
  }

  /// `Administrative management`
  String get service_administrative_management {
    return Intl.message(
      'Administrative management',
      name: 'service_administrative_management',
      desc: '',
      args: [],
    );
  }

  /// `Security 24h`
  String get service_security {
    return Intl.message(
      'Security 24h',
      name: 'service_security',
      desc: '',
      args: [],
    );
  }

  /// `Air conditioning`
  String get equipment_air_conditioning {
    return Intl.message(
      'Air conditioning',
      name: 'equipment_air_conditioning',
      desc: '',
      args: [],
    );
  }

  /// `Private office`
  String get equipment_private_office {
    return Intl.message(
      'Private office',
      name: 'equipment_private_office',
      desc: '',
      args: [],
    );
  }

  /// `Garden`
  String get equipment_garden {
    return Intl.message('Garden', name: 'equipment_garden', desc: '', args: []);
  }

  /// `Whiteboards`
  String get equipment_whiteboards {
    return Intl.message(
      'Whiteboards',
      name: 'equipment_whiteboards',
      desc: '',
      args: [],
    );
  }

  /// `Ergonomic chairs`
  String get equipment_ergonomic_chairs {
    return Intl.message(
      'Ergonomic chairs',
      name: 'equipment_ergonomic_chairs',
      desc: '',
      args: [],
    );
  }

  /// `Closets`
  String get equipment_closets {
    return Intl.message(
      'Closets',
      name: 'equipment_closets',
      desc: '',
      args: [],
    );
  }

  /// `Scanner`
  String get equipment_scanner {
    return Intl.message(
      'Scanner',
      name: 'equipment_scanner',
      desc: '',
      args: [],
    );
  }

  /// `Individual tables`
  String get equipment_individual_tables {
    return Intl.message(
      'Individual tables',
      name: 'equipment_individual_tables',
      desc: '',
      args: [],
    );
  }

  /// `Projector`
  String get equipment_projector {
    return Intl.message(
      'Projector',
      name: 'equipment_projector',
      desc: '',
      args: [],
    );
  }

  /// `Lockers`
  String get equipment_lockers {
    return Intl.message(
      'Lockers',
      name: 'equipment_lockers',
      desc: '',
      args: [],
    );
  }

  /// `Lockers with keys`
  String get equipment_lockers_with_keys {
    return Intl.message(
      'Lockers with keys',
      name: 'equipment_lockers_with_keys',
      desc: '',
      args: [],
    );
  }

  /// `Fiber optic`
  String get equipment_fiber_optic {
    return Intl.message(
      'Fiber optic',
      name: 'equipment_fiber_optic',
      desc: '',
      args: [],
    );
  }

  /// `Screens / Monitors`
  String get equipment_screens_monitors {
    return Intl.message(
      'Screens / Monitors',
      name: 'equipment_screens_monitors',
      desc: '',
      args: [],
    );
  }

  /// `Wired network`
  String get equipment_wired_network {
    return Intl.message(
      'Wired network',
      name: 'equipment_wired_network',
      desc: '',
      args: [],
    );
  }

  /// `Television`
  String get equipment_television {
    return Intl.message(
      'Television',
      name: 'equipment_television',
      desc: '',
      args: [],
    );
  }

  /// `Heating`
  String get equipment_heating {
    return Intl.message(
      'Heating',
      name: 'equipment_heating',
      desc: '',
      args: [],
    );
  }

  /// `Copier`
  String get equipment_copier {
    return Intl.message('Copier', name: 'equipment_copier', desc: '', args: []);
  }

  /// `Parking`
  String get equipment_parking {
    return Intl.message(
      'Parking',
      name: 'equipment_parking',
      desc: '',
      args: [],
    );
  }

  /// `Game room`
  String get equipment_game_room {
    return Intl.message(
      'Game room',
      name: 'equipment_game_room',
      desc: '',
      args: [],
    );
  }

  /// `Terrace`
  String get equipment_terrace {
    return Intl.message(
      'Terrace',
      name: 'equipment_terrace',
      desc: '',
      args: [],
    );
  }

  /// `Kitchen`
  String get equipment_kitchen {
    return Intl.message(
      'Kitchen',
      name: 'equipment_kitchen',
      desc: '',
      args: [],
    );
  }

  /// `Printer`
  String get equipment_printer {
    return Intl.message(
      'Printer',
      name: 'equipment_printer',
      desc: '',
      args: [],
    );
  }

  /// `Bike parking`
  String get equipment_bike_parking {
    return Intl.message(
      'Bike parking',
      name: 'equipment_bike_parking',
      desc: '',
      args: [],
    );
  }

  /// `Meeting rooms`
  String get equipment_meeting_rooms {
    return Intl.message(
      'Meeting rooms',
      name: 'equipment_meeting_rooms',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message('Try again', name: 'tryAgain', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ro'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'sv'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'zh'),
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
