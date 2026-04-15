// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'hi';

  static String m0(seconds) =>
      "उपयोगकर्ता नाम या पासवर्ड गलत है।\nकृपया पुनः प्रयास करने से पहले ${seconds} सेकंड प्रतीक्षा करें";

  static String m1(username) => "VACoworking पर @${username} की प्रोफ़ाइल";

  static String m2(username) => "@${username} का QR";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage("खाता सेटिंग्स"),
    "actionNo": MessageLookupByLibrary.simpleMessage("नहीं"),
    "actionYes": MessageLookupByLibrary.simpleMessage("हाँ"),
    "andLabel": MessageLookupByLibrary.simpleMessage("और"),
    "appName": MessageLookupByLibrary.simpleMessage("VACoworking"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·VACoworking का प्रारंभिक संस्करण।",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "परिवर्तन लॉग",
    ),
    "authRequiredFunctionAction": MessageLookupByLibrary.simpleMessage("जाएँ"),
    "authRequiredFunctionMessage": MessageLookupByLibrary.simpleMessage(
      "इस सुविधा के लिए साइन इन करना आवश्यक है।",
    ),
    "availableRooms": MessageLookupByLibrary.simpleMessage("उपलब्ध कक्ष"),
    "back": MessageLookupByLibrary.simpleMessage("वापस"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("परिचय"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("रद्द करें"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "पासवर्ड बदलें",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("बंद करें"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("पुष्टि करें"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("खाता हटाएँ"),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage("अवतार हटाएँ"),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage(
      "रीफ़्रेश करें",
    ),
    "capacity": MessageLookupByLibrary.simpleMessage("क्षमता"),
    "close": MessageLookupByLibrary.simpleMessage("बंद करें"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "कोड में 6 अंक होने चाहिए",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "यदि खाता मौजूद है, तो ईमेल पर कोड भेजा गया है",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("संक्षिप्त करें"),
    "confirm": MessageLookupByLibrary.simpleMessage("पुष्टि करें"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "पासवर्ड की पुष्टि करें",
    ),
    "contact": MessageLookupByLibrary.simpleMessage("संपर्क"),
    "contactSubject": MessageLookupByLibrary.simpleMessage(
      "संसाधन से संपर्क करें",
    ),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage("कुकी नीति"),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "लिंक कॉपी हो गया",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("लिंक कॉपी करें"),
    "couldNotOpenContact": MessageLookupByLibrary.simpleMessage(
      "खोल नहीं सकते",
    ),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "वर्तमान संस्करण",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage("वर्तमान पासवर्ड"),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "उपलब्ध संस्करण",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("तारीख प्रारूप"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "सभी सूचनाएँ हटाएँ",
    ),
    "description": MessageLookupByLibrary.simpleMessage("विवरण"),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "क्या आप वाकई ऐप बंद करना चाहते हैं?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage("ऐप बंद करें"),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "क्या आप वाकई साइन आउट करना चाहते हैं?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "क्या परिवर्तन सहेजें?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "क्या आप वाकई अपना खाता हटाना चाहते हैं? यह पूर्ववत नहीं किया जा सकता।\nपुष्टि के लिए पासवर्ड दर्ज करें।",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "पासवर्ड",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "VACoworking का नया संस्करण उपलब्ध है।\nजारी रखने के लिए ऐप अपडेट करें",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "VACoworking सर्वर से कनेक्ट नहीं हो सका",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "ऐप इस समय रखरखाव में है। बाद में प्रयास करें",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("त्रुटि"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("ध्यान दें"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "प्रदर्शन नाम (वैकल्पिक)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("ईमेल"),
    "enterWithoutUser": MessageLookupByLibrary.simpleMessage(
      "बिना उपयोगकर्ता के प्रवेश करें",
    ),
    "equipment": MessageLookupByLibrary.simpleMessage("सुविधाएँ"),
    "equipment_air_conditioning": MessageLookupByLibrary.simpleMessage(
      "एयर कंडीशनिंग",
    ),
    "equipment_bike_parking": MessageLookupByLibrary.simpleMessage(
      "साइकिल पार्किंग",
    ),
    "equipment_closets": MessageLookupByLibrary.simpleMessage("कपड़ों के अंदर"),
    "equipment_copier": MessageLookupByLibrary.simpleMessage("कॉपी मशीन"),
    "equipment_ergonomic_chairs": MessageLookupByLibrary.simpleMessage(
      "एर्गोनॉमिक सीटें",
    ),
    "equipment_fiber_optic": MessageLookupByLibrary.simpleMessage(
      "फाइबर ऑप्टिक",
    ),
    "equipment_game_room": MessageLookupByLibrary.simpleMessage("खेल कक्ष"),
    "equipment_garden": MessageLookupByLibrary.simpleMessage("बाग"),
    "equipment_heating": MessageLookupByLibrary.simpleMessage("गर्मी"),
    "equipment_individual_tables": MessageLookupByLibrary.simpleMessage(
      "व्यक्तिगत टेबल",
    ),
    "equipment_kitchen": MessageLookupByLibrary.simpleMessage("रसोई"),
    "equipment_lockers": MessageLookupByLibrary.simpleMessage("लॉकर"),
    "equipment_lockers_with_keys": MessageLookupByLibrary.simpleMessage(
      "कुंजी वाले लॉकर",
    ),
    "equipment_meeting_rooms": MessageLookupByLibrary.simpleMessage(
      "मीटिंग कक्ष",
    ),
    "equipment_parking": MessageLookupByLibrary.simpleMessage("पार्किंग"),
    "equipment_printer": MessageLookupByLibrary.simpleMessage("प्रिंटर"),
    "equipment_private_office": MessageLookupByLibrary.simpleMessage(
      "निजी कार्यालय",
    ),
    "equipment_projector": MessageLookupByLibrary.simpleMessage("प्रोजेक्टर"),
    "equipment_scanner": MessageLookupByLibrary.simpleMessage("स्कैनर"),
    "equipment_screens_monitors": MessageLookupByLibrary.simpleMessage(
      "स्क्रीन / मॉनिटर",
    ),
    "equipment_television": MessageLookupByLibrary.simpleMessage("टेलीविजन"),
    "equipment_terrace": MessageLookupByLibrary.simpleMessage("टेरेस"),
    "equipment_whiteboards": MessageLookupByLibrary.simpleMessage(
      "व्हाइटबोर्ड",
    ),
    "equipment_wired_network": MessageLookupByLibrary.simpleMessage(
      "तार वाला नेटवर्क",
    ),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "खाता नहीं हटाया जा सका। पुनः प्रयास करें",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "यह ईमेल पहले से पंजीकृत है",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "कोड समाप्त हो गया",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "एक त्रुटि हुई। पुनः प्रयास करें",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "कोड अमान्य है",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "उपयोगकर्ता नाम या पासवर्ड गलत है",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "ईमेल अमान्य है",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "पासवर्ड कम से कम 6 अक्षर का होना चाहिए",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "उपयोगकर्ता नाम 4–20 अक्षरों का होना चाहिए और केवल अक्षर, अंक, हाइफ़न और अंडरस्कोर हो सकते हैं।",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "आवश्यक फ़ील्ड गायब हैं",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "उपयोगकर्ता नाम या ईमेल दर्ज करें",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "पंजीकरण पूरा नहीं हो सका। पुनः प्रयास करें",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "सत्र नहीं बनाया जा सका। बाद में प्रयास करें",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "अधिकतम प्रयास सीमा पार हो गई",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "बहुत अधिक प्रयास। बाद में प्रयास करें",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "यह उपयोगकर्ता नाम पहले से मौजूद है",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "गलत पासवर्ड",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "छवि प्रसंस्करण नहीं हो सका",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("विस्तार करें"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "यह उपलब्ध coworking स्पेस की जानकारी देने वाला ऐप है, जिन्हें सेवाओं और विशेषताओं के आधार पर वर्गीकृत किया गया है। आप अलग-अलग मानदंडों से खोज और फ़िल्टर करके काम करने के लिए सही जगह ढूंढ सकते हैं।",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage(
      "VACoworking क्या है?",
    ),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "केवल ऐप एडमिनिस्ट्रेटर ही coworking स्पेस जोड़ सकते हैं। अधिक स्पेस जोड़ने के लिए आपको ऐप टीम से संपर्क करना होगा।",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage(
      "क्या मैं coworking स्पेस जोड़ सकता/सकती हूँ?",
    ),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "जब आप नोटिफिकेशन की अनुमति देते हैं, तो आपके डिवाइस पर coworking स्पेस से जुड़ी अपडेट या महत्वपूर्ण खबरों के अलर्ट भेजे जाते हैं। आप ऐप की सेटिंग्स में नोटिफिकेशन कॉन्फ़िगर कर सकते हैं।",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "नोटिफिकेशन कैसे काम करते हैं?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "यह फ़ील्ड आवश्यक है",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("पासवर्ड भूल गए?"),
    "generalSettings": MessageLookupByLibrary.simpleMessage("सामान्य सेटिंग्स"),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage(
          "सिस्टम सेटिंग्स नहीं खोली जा सकीं",
        ),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "सेटिंग्स सहेजी नहीं जा सकीं। कनेक्शन जाँचें और पुनः प्रयास करें",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "सेटिंग्स सहेजी नहीं जा सकतीं। फिर से साइन इन करें",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "सेटिंग्स सहेजी गईं",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("होम पर जाएँ"),
    "homeCreateInvitationButton": MessageLookupByLibrary.simpleMessage(
      "निमंत्रण बनाएं",
    ),
    "homeEmptyInvitationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "शुरू करने के लिए निमंत्रण बनाएं पर टैप करें",
    ),
    "homeEmptyInvitationsTitle": MessageLookupByLibrary.simpleMessage(
      "अभी तक कोई निमंत्रण नहीं बनाए गए हैं",
    ),
    "homeHeroTitle": MessageLookupByLibrary.simpleMessage(
      "काम करने के लिए अच्छी जगह खोजें",
    ),
    "homeSearchCoworkingButton": MessageLookupByLibrary.simpleMessage(
      "कोवर्किंग स्पेस खोजें",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("अमान्य ईमेल"),
    "keepSession": MessageLookupByLibrary.simpleMessage("मुझे साइन इन रखें"),
    "language": MessageLookupByLibrary.simpleMessage("भाषा"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("अरबी"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("कैटलान"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("चीनी"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("डच"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("अंग्रेज़ी"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("फ़्रेंच"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("जर्मन"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("हिंदी"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("इंडोनेशियाई"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("इतालवी"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("जापानी"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("कोरियाई"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("पोलिश"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("पुर्तगाली"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("रोमानियाई"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("रूसी"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("स्पेनिश"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("स्वीडिश"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("तुर्की"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("यूक्रेनियाई"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage(
      "अंतिम ऑनलाइन",
    ),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage("कानूनी सूचना"),
    "loading": MessageLookupByLibrary.simpleMessage("लोड हो रहा है..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("साइन आउट"),
    "mainRoom": MessageLookupByLibrary.simpleMessage("मुख्य कक्ष"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage(
      "सभी को पढ़ा हुआ चिह्नित करें",
    ),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage("सोशल मीडिया"),
    "menuHome": MessageLookupByLibrary.simpleMessage("होम"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "पासवर्ड सफलतापूर्वक बदला गया",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "खाता नहीं हटाया जा सका",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "खाता सफलतापूर्वक हटाया गया",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "एक त्रुटि हुई",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "प्रोफ़ाइल अपडेट नहीं हो सकी",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "प्रोफ़ाइल सफलतापूर्वक अपडेट हुई",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("हटाएँ"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "यह संदेश हटाएँ?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage("संदेश हटाया गया"),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("संपादित करें"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("संपादित"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "अभी तक कोई बातचीत नहीं",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "संदेश नहीं हटाया जा सका",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "संदेश संपादित नहीं हो सका",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "संदेश नहीं भेजा जा सका",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "अभी कोई संदेश नहीं। कुछ लिखें!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("पढ़ा गया"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("भेजें"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("भेजा गया"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage("संदेश लिखें..."),
    "moreServices": MessageLookupByLibrary.simpleMessage("अधिक सेवाएँ"),
    "newPassword": MessageLookupByLibrary.simpleMessage("नया पासवर्ड"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage(
      "और कोई रिकॉर्ड नहीं",
    ),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "क्या सभी सूचनाएँ हटाएँ?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "क्या सभी सूचनाओं को पढ़ा हुआ चिह्नित करें?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "सूचना को पढ़ा हुआ चिह्नित नहीं किया जा सका",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "सूचना पढ़ी हुई चिह्नित की गई।",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "सभी सूचनाएँ पढ़ी हुई चिह्नित की गईं",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "सूचनाएँ नहीं हटाई जा सकीं",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "सूचनाएँ हटा दी गईं",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "आपके पास कोई सूचना नहीं है",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("सूचनाएँ"),
    "notificationsNewBadge": MessageLookupByLibrary.simpleMessage("नया"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "डिवाइस सूचना अनुमतियाँ",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "सेटिंग्स खोलें",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("बंद"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("चालू"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "सुरक्षा कारणों से हम ब्राउज़र सेटिंग्स नहीं खोल सकते। इस साइट की सूचनाओं की अनुमति या रोकने के लिए पते के बगल में ताला पर टैप करें → साइट सेटिंग्स → सूचनाएँ।",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "ब्राउज़र में सूचनाएँ",
    ),
    "password": MessageLookupByLibrary.simpleMessage("पासवर्ड"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "पासवर्ड सफलतापूर्वक रीसेट हो गया",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "कम से कम 6 अक्षर",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "पासवर्ड मेल नहीं खाते",
    ),
    "people": MessageLookupByLibrary.simpleMessage("लोग"),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "गोपनीयता नीति",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage("निजी संदेश"),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "उपयोगकर्ता प्रोफ़ाइल",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "पुश सूचनाएँ",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "कैप्चा सत्यापित नहीं हो सका। पुनः प्रयास करें।",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage("पंजीकरण त्रुटि"),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "मैं प्रचार और व्यावसायिक संचार प्राप्त करने के लिए सहमत हूँ",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "मैंने पढ़ा है और स्वीकार करता/करती हूँ",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "आपको नियम व शर्तें और गोपनीयता नीति स्वीकार करनी होगी",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "तिथि हटाएँ",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage("देश हटाएँ"),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage(
      "पुनः प्रयास करें",
    ),
    "searchByKeyWord": MessageLookupByLibrary.simpleMessage(
      "नाम या सेवा द्वारा खोजें",
    ),
    "seeAllDetails": MessageLookupByLibrary.simpleMessage("सभी विवरण देखें"),
    "sendCode": MessageLookupByLibrary.simpleMessage("कोड भेजें"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage("संदेश भेजें"),
    "service_access": MessageLookupByLibrary.simpleMessage("24/7 पहुँच"),
    "service_administrative_management": MessageLookupByLibrary.simpleMessage(
      "प्रशासन प्रबंधन",
    ),
    "service_autonomous_access": MessageLookupByLibrary.simpleMessage(
      "स्वतंत्र पहुँच",
    ),
    "service_catering": MessageLookupByLibrary.simpleMessage("कैटरिंग"),
    "service_cleaning": MessageLookupByLibrary.simpleMessage("सफाई"),
    "service_coffee_beverages": MessageLookupByLibrary.simpleMessage(
      "कॉफ़ी / बेवरेज़",
    ),
    "service_events": MessageLookupByLibrary.simpleMessage("कार्यक्रम"),
    "service_fiscal_domiciliation": MessageLookupByLibrary.simpleMessage(
      "कर निवास",
    ),
    "service_mail_reception": MessageLookupByLibrary.simpleMessage(
      "मेल प्राप्ति",
    ),
    "service_networking": MessageLookupByLibrary.simpleMessage("नेटवर्किंग"),
    "service_phone_support": MessageLookupByLibrary.simpleMessage(
      "फ़ोन सहायता",
    ),
    "service_reception": MessageLookupByLibrary.simpleMessage("प्रवेश"),
    "service_relax_zone": MessageLookupByLibrary.simpleMessage("आराम क्षेत्र"),
    "service_security": MessageLookupByLibrary.simpleMessage("सुरक्षा 24 घंटे"),
    "service_social_domiciliation": MessageLookupByLibrary.simpleMessage(
      "सामाजिक निवास",
    ),
    "service_training": MessageLookupByLibrary.simpleMessage("प्रशिक्षण"),
    "service_wifi": MessageLookupByLibrary.simpleMessage("वाई-फ़ाई"),
    "service_workshops": MessageLookupByLibrary.simpleMessage("कार्यशालाएँ"),
    "services": MessageLookupByLibrary.simpleMessage("सेवाएँ"),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("सेटिंग्स"),
    "shareOption": MessageLookupByLibrary.simpleMessage("साझा करें"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("साझा करें"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage(
      "मेरा प्रोफ़ाइल देखें",
    ),
    "showQrOption": MessageLookupByLibrary.simpleMessage("QR दिखाएँ"),
    "signIn": MessageLookupByLibrary.simpleMessage("साइन इन करें"),
    "signUp": MessageLookupByLibrary.simpleMessage("खाता बनाएं"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("ईमेल"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "सोशल मीडिया पर हमें फॉलो करें।",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "लिंक नहीं खोला जा सका",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "WhatsApp नहीं खोला जा सका",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("स्थिति"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage(
      "VACoworking संपर्क",
    ),
    "tel": MessageLookupByLibrary.simpleMessage("टेल:"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "नियम व शर्तें",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "मदद चाहिए? हमारे किसी भी चैनल से संपर्क करें — जल्द से जल्द जवाब देंगे।",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "प्रदर्शन नाम",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage(
      "ईमेल आवश्यक है",
    ),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage(
      "ईमेल अमान्य है",
    ),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "जन्म तिथि",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("देश"),
    "theme": MessageLookupByLibrary.simpleMessage("थीम"),
    "themeDark": MessageLookupByLibrary.simpleMessage("डार्क मोड"),
    "themeLight": MessageLookupByLibrary.simpleMessage("लाइट मोड"),
    "titleAppBar": MessageLookupByLibrary.simpleMessage(
      "वलाडोलिड में कोवर्किंग",
    ),
    "total": MessageLookupByLibrary.simpleMessage("कुल"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("पुनः प्रयास करें"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("अवतार"),
    "userDescription": MessageLookupByLibrary.simpleMessage("विवरण"),
    "userEmail": MessageLookupByLibrary.simpleMessage("ईमेल"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "यह उपयोगकर्ता नहीं मिला",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage(
      "उपयोगकर्ता नाम या ईमेल",
    ),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("संपर्क"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage(
      "अक्सर पूछे जाने वाले प्रश्न",
    ),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage("साइन आउट"),
    "userYears": MessageLookupByLibrary.simpleMessage("वर्ष"),
    "username": MessageLookupByLibrary.simpleMessage("उपयोगकर्ता नाम"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "कम से कम 4 अक्षर",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "सत्यापन कोड (6 अंक)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("संस्करण"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://आपकीसाइट.com"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("वेबसाइट / ब्लॉग"),
    "weekStart": MessageLookupByLibrary.simpleMessage("सप्ताह का पहला दिन"),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("सोमवार"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("रविवार"),
    "welcome": MessageLookupByLibrary.simpleMessage("स्वागत है!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage("गलत क्रेडेंशियल"),
  };
}
