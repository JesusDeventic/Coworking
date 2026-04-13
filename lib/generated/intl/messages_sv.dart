// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sv locale. All the
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
  String get localeName => 'sv';

  static String m0(seconds) =>
      "Fel användarnamn eller lösenord.\nVänta ${seconds} sekunder innan du försöker igen";

  static String m1(username) => "Profil för @${username} på VACoworking";

  static String m2(username) => "QR för @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage(
      "Kontoinställningar",
    ),
    "actionNo": MessageLookupByLibrary.simpleMessage("Nej"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Ja"),
    "andLabel": MessageLookupByLibrary.simpleMessage("och"),
    "appName": MessageLookupByLibrary.simpleMessage("VACoworking"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Första versionen av VACoworking.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Ändringslogg",
    ),
    "authRequiredFunctionAction": MessageLookupByLibrary.simpleMessage("GÅ"),
    "authRequiredFunctionMessage": MessageLookupByLibrary.simpleMessage(
      "Den här funktionen kräver att du loggar in",
    ),
    "availableRooms": MessageLookupByLibrary.simpleMessage("Tillgängliga rum"),
    "back": MessageLookupByLibrary.simpleMessage("Tillbaka"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("Bio"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Avbryt"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "Byt lösenord",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Stäng"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Bekräfta"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Ta bort konto",
    ),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage(
      "Ta bort avatar",
    ),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage(
      "Uppdatera",
    ),
    "capacity": MessageLookupByLibrary.simpleMessage("Kapacitet"),
    "close": MessageLookupByLibrary.simpleMessage("Stäng"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "Koden måste ha 6 siffror",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Om kontot finns har en kod skickats till din e-post",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Dölj"),
    "confirm": MessageLookupByLibrary.simpleMessage("Bekräfta"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Bekräfta lösenord",
    ),
    "contact": MessageLookupByLibrary.simpleMessage("Kontakt"),
    "contactSubject": MessageLookupByLibrary.simpleMessage("Konsultation om"),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage("Cookiepolicy"),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Länk kopierad",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage("Kopiera länk"),
    "couldNotOpenContact": MessageLookupByLibrary.simpleMessage(
      "Kan inte öppna",
    ),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Aktuell version",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "Nuvarande lösenord",
    ),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Tillgänglig version",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Datumformat"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Ta bort alla aviseringar",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Beskrivning"),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "Vill du verkligen avsluta appen?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage(
      "Avsluta appen",
    ),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "Vill du verkligen logga ut?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "Vill du spara ändringarna?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Vill du verkligen ta bort ditt konto? Detta kan inte ångras.\nAnge ditt lösenord för att bekräfta.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Lösenord",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "En ny version av VACoworking finns tillgänglig.\nUppdatera appen för att fortsätta",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Kunde inte ansluta till VACoworking-servern",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "Appen underhålls just nu. Försök igen senare",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Fel"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Obs"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Visningsnamn (valfritt)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("E-post"),
    "enterWithoutUser": MessageLookupByLibrary.simpleMessage(
      "Logga in utan användare",
    ),
    "equipment": MessageLookupByLibrary.simpleMessage("Utrustning"),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Kunde inte ta bort kontot. Försök igen",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "Den e-postadressen är redan registrerad",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "Koden har gått ut",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "Ett fel uppstod. Försök igen",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Koden är ogiltig",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Fel användarnamn eller lösenord",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "E-postadressen är ogiltig",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "Lösenordet måste ha minst 6 tecken",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "Användarnamnet måste vara 4–20 tecken och får bara innehålla bokstäver, siffror, bindestreck och understreck.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Obligatoriska fält saknas",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "Ange användarnamn eller e-post",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Kunde inte slutföra registreringen. Försök igen",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "Kunde inte skapa sessionen. Försök senare",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Maximalt antal försök överskridet",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "För många försök. Försök senare",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "Det användarnamnet finns redan",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Fel lösenord",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Kunde inte bearbeta bilden",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Expandera"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "Det är en informationsapp om tillgängliga coworking-platser, kategoriserade efter tjänster och egenskaper. Du kan söka och filtrera efter olika kriterier för att hitta den perfekta arbetsplatsen.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage("Vad är VACoworking?"),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "Endast appens administratörer kan lägga till coworking-platser. För att lägga till fler platser behöver du kontakta appteamet.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage(
      "Kan jag lägga till coworking-platser?",
    ),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "När du tillåter notiser skickas aviseringar till din enhet med nyheter eller viktig information om coworking-platser. Du kan konfigurera notiser i appens inställningar.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "Hur fungerar notiser?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Detta fält är obligatoriskt",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Glömt lösenordet?"),
    "generalSettings": MessageLookupByLibrary.simpleMessage(
      "Allmänna inställningar",
    ),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage(
          "Kunde inte öppna systeminställningarna",
        ),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Kunde inte spara inställningarna. Kontrollera anslutningen och försök igen",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "Kan inte spara inställningarna. Logga in igen",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Inställningar sparade",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("Gå till hem"),
    "homeCreateInvitationButton": MessageLookupByLibrary.simpleMessage(
      "Skapa inbjudan",
    ),
    "homeEmptyInvitationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tryck på Skapa inbjudan för att börja",
    ),
    "homeEmptyInvitationsTitle": MessageLookupByLibrary.simpleMessage(
      "Inga inbjudningar skapade ännu",
    ),
    "homeHeroTitle": MessageLookupByLibrary.simpleMessage(
      "Hitta en bra plats att arbeta på",
    ),
    "homeSearchCoworkingButton": MessageLookupByLibrary.simpleMessage(
      "Sök coworking-platser",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Ogiltig e-post"),
    "keepSession": MessageLookupByLibrary.simpleMessage("Håll mig inloggad"),
    "language": MessageLookupByLibrary.simpleMessage("Språk"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Arabiska"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Katalanska"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Kinesiska"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Nederländska"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("Engelska"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Franska"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("Tyska"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Hindi"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("Indonesiska"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("Italienska"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Japanska"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Koreanska"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Polska"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Portugisiska"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Rumänska"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Ryska"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("Spanska"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("Svenska"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Turkiska"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Ukrainska"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage(
      "Senast online",
    ),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage(
      "Juridisk information",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Laddar..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Logga ut"),
    "mainRoom": MessageLookupByLibrary.simpleMessage("Huvudrum"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage(
      "Markera allt som läst",
    ),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage(
      "Sociala medier",
    ),
    "menuHome": MessageLookupByLibrary.simpleMessage("Hem"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Lösenordet ändrades",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "Kunde inte ta bort kontot",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Kontot togs bort",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "Ett fel uppstod",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "Kunde inte uppdatera profilen",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Profilen uppdaterades",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("Ta bort"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Ta bort detta meddelande?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage(
      "Meddelande borttaget",
    ),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("Redigera"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("redigerat"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "Du har inga konversationer ännu",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "Kunde inte ta bort meddelandet",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "Kunde inte redigera meddelandet",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "Kunde inte skicka meddelandet",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "Inga meddelanden ännu. Skriv något!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("Läst"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("Skicka"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("Skickat"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage(
      "Skriv ett meddelande...",
    ),
    "moreServices": MessageLookupByLibrary.simpleMessage("fler tjänster"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nytt lösenord"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage("Inga fler poster"),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "Vill du ta bort alla aviseringar?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "Vill du markera alla aviseringar som lästa?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "Kunde inte markera aviseringen som läst",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Avisering markerad som läst.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Alla aviseringar markerade som lästa",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "Kunde inte ta bort aviseringarna",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "Aviseringar borttagna",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "Du har inga aviseringar",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("Aviseringar"),
    "notificationsNewBadge": MessageLookupByLibrary.simpleMessage("Ny"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "Aviseringsbehörigheter för enheten",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Öppna inställningar",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("AV"),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("PÅ"),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "Av säkerhetsskäl kan vi inte öppna webbläsarinställningarna. Tryck på hänglåset bredvid adressen → Webbplatsinställningar → Aviseringar för att tillåta eller blockera.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Aviseringar i webbläsaren",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Lösenord"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Lösenordet har återställts",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage("Minst 6 tecken"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Lösenorden matchar inte",
    ),
    "people": MessageLookupByLibrary.simpleMessage("personer"),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "Integritetspolicy",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage(
      "Privata meddelanden",
    ),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Användarprofil",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Pushaviseringar",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "Kunde inte verifiera captcha. Försök igen.",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage("Registreringsfel"),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "Jag godkänner att ta emot kampanjer och kommersiell kommunikation",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "Jag har läst och godkänner",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "Du måste godkänna användarvillkor och integritetspolicy",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "Ta bort datum",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage(
      "Ta bort land",
    ),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("Försök igen"),
    "searchByKeyWord": MessageLookupByLibrary.simpleMessage(
      "Sök efter namn eller tjänst",
    ),
    "seeAllDetails": MessageLookupByLibrary.simpleMessage("Se alla detaljer"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Skicka kod"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage(
      "Skicka meddelande",
    ),
    "service_access": MessageLookupByLibrary.simpleMessage("24/7 tillgång"),
    "service_administrative_management": MessageLookupByLibrary.simpleMessage(
      "Administrativ hantering",
    ),
    "service_autonomous_access": MessageLookupByLibrary.simpleMessage(
      "Autonom tillgång",
    ),
    "service_catering": MessageLookupByLibrary.simpleMessage("Catering"),
    "service_cleaning": MessageLookupByLibrary.simpleMessage("Städning"),
    "service_coffee_beverages": MessageLookupByLibrary.simpleMessage(
      "Kaffe / Drycker",
    ),
    "service_events": MessageLookupByLibrary.simpleMessage("Evenemang"),
    "service_fiscal_domiciliation": MessageLookupByLibrary.simpleMessage(
      "Fiskal registrering",
    ),
    "service_mail_reception": MessageLookupByLibrary.simpleMessage(
      "Postmottagning",
    ),
    "service_networking": MessageLookupByLibrary.simpleMessage("Nätverkande"),
    "service_phone_support": MessageLookupByLibrary.simpleMessage(
      "Telefonsupport",
    ),
    "service_reception": MessageLookupByLibrary.simpleMessage("Reception"),
    "service_relax_zone": MessageLookupByLibrary.simpleMessage("Relaxzon"),
    "service_security": MessageLookupByLibrary.simpleMessage("Säkerhet 24h"),
    "service_social_domiciliation": MessageLookupByLibrary.simpleMessage(
      "Social registrering",
    ),
    "service_training": MessageLookupByLibrary.simpleMessage("Träning"),
    "service_wifi": MessageLookupByLibrary.simpleMessage("WiFi"),
    "service_workshops": MessageLookupByLibrary.simpleMessage("Workshopar"),
    "services": MessageLookupByLibrary.simpleMessage("Tjänster"),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Inställningar"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Dela"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Dela"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("Visa min profil"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("Visa QR"),
    "signIn": MessageLookupByLibrary.simpleMessage("Logga in"),
    "signUp": MessageLookupByLibrary.simpleMessage("Skapa konto"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("E-post"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Följ oss i sociala medier.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "Kunde inte öppna länken",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "Kunde inte öppna WhatsApp",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Status"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage(
      "Kontakt VACoworking",
    ),
    "tel": MessageLookupByLibrary.simpleMessage("Tel:"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Användarvillkor",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Behöver du hjälp? Kontakta oss via någon av våra kanaler så svarar vi så snart vi kan.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "Visningsnamn",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage("E-post krävs"),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage(
      "Ogiltig e-post",
    ),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "Födelsedatum",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("Land"),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Mörkt läge"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Ljust läge"),
    "titleAppBar": MessageLookupByLibrary.simpleMessage(
      "Coworking i Valladolid",
    ),
    "total": MessageLookupByLibrary.simpleMessage("Totalt"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("Avatar"),
    "userDescription": MessageLookupByLibrary.simpleMessage("Beskrivning"),
    "userEmail": MessageLookupByLibrary.simpleMessage("E-post"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "Vi hittade inte den här användaren",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage(
      "Användarnamn eller e-post",
    ),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("Kontakt"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("Vanliga frågor"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage("Logga ut"),
    "userYears": MessageLookupByLibrary.simpleMessage("år"),
    "username": MessageLookupByLibrary.simpleMessage("Användarnamn"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage("Minst 4 tecken"),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Verifieringskod (6 siffror)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://dinsida.se"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Webbplats / blogg"),
    "weekStart": MessageLookupByLibrary.simpleMessage("Veckans första dag"),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Måndag"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Söndag"),
    "welcome": MessageLookupByLibrary.simpleMessage("Välkommen!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Felaktiga uppgifter",
    ),
  };
}
