// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
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
  String get localeName => 'uk';

  static String m0(seconds) =>
      "Невірне ім\'я користувача або пароль.\nЗачекайте ${seconds} секунд перед повторною спробою";

  static String m1(username) => "Профіль @${username} у VACoworking";

  static String m2(username) => "QR для @${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountSettings": MessageLookupByLibrary.simpleMessage(
      "Налаштування облікового запису",
    ),
    "actionNo": MessageLookupByLibrary.simpleMessage("Ні"),
    "actionYes": MessageLookupByLibrary.simpleMessage("Так"),
    "andLabel": MessageLookupByLibrary.simpleMessage("та"),
    "appName": MessageLookupByLibrary.simpleMessage("VACoworking"),
    "appVersion10Code": MessageLookupByLibrary.simpleMessage("v1.0.0"),
    "appVersion10Description": MessageLookupByLibrary.simpleMessage(
      "·Перший випуск VACoworking.",
    ),
    "appVersionChangeLogTitle": MessageLookupByLibrary.simpleMessage(
      "Журнал змін",
    ),
    "authRequiredFunctionAction": MessageLookupByLibrary.simpleMessage(
      "УВІЙТИ",
    ),
    "authRequiredFunctionMessage": MessageLookupByLibrary.simpleMessage(
      "Ця функція потребує входу в систему",
    ),
    "availableRooms": MessageLookupByLibrary.simpleMessage("Доступні кімнати"),
    "back": MessageLookupByLibrary.simpleMessage("Назад"),
    "bioLabel": MessageLookupByLibrary.simpleMessage("Про себе"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Скасувати"),
    "buttonChangePassword": MessageLookupByLibrary.simpleMessage(
      "Змінити пароль",
    ),
    "buttonClose": MessageLookupByLibrary.simpleMessage("Закрити"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Підтвердити"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Видалити обліковий запис",
    ),
    "buttonDeleteAvatar": MessageLookupByLibrary.simpleMessage(
      "Видалити аватар",
    ),
    "buttonReloadNotifications": MessageLookupByLibrary.simpleMessage(
      "Оновити",
    ),
    "capacity": MessageLookupByLibrary.simpleMessage("Вмістимість"),
    "close": MessageLookupByLibrary.simpleMessage("Закрити"),
    "code6Digits": MessageLookupByLibrary.simpleMessage(
      "Код має містити 6 цифр",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage(
      "Якщо обліковий запис існує, код надіслано на email",
    ),
    "collapseMenu": MessageLookupByLibrary.simpleMessage("Згорнути"),
    "confirm": MessageLookupByLibrary.simpleMessage("Підтвердити"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Підтвердіть пароль",
    ),
    "contact": MessageLookupByLibrary.simpleMessage("Контакт"),
    "contactSubject": MessageLookupByLibrary.simpleMessage("Консультація про"),
    "cookiePolicyLabel": MessageLookupByLibrary.simpleMessage(
      "Політика cookie",
    ),
    "copiedProfileLinkSnackbar": MessageLookupByLibrary.simpleMessage(
      "Посилання скопійовано",
    ),
    "copyProfileLink": MessageLookupByLibrary.simpleMessage(
      "Копіювати посилання",
    ),
    "couldNotOpenContact": MessageLookupByLibrary.simpleMessage(
      "Не вдається відкрити",
    ),
    "currentAppVersionText": MessageLookupByLibrary.simpleMessage(
      "Поточна версія",
    ),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Поточний пароль"),
    "currentServerVersionText": MessageLookupByLibrary.simpleMessage(
      "Доступна версія",
    ),
    "dateFormat": MessageLookupByLibrary.simpleMessage("Формат дати"),
    "deleteAllNotifications": MessageLookupByLibrary.simpleMessage(
      "Видалити всі сповіщення",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Опис"),
    "dialogCloseAppContent": MessageLookupByLibrary.simpleMessage(
      "Дійсно вийти з додатка?",
    ),
    "dialogCloseAppTitle": MessageLookupByLibrary.simpleMessage(
      "Вийти з додатка",
    ),
    "dialogCloseSessionContent": MessageLookupByLibrary.simpleMessage(
      "Дійсно вийти з облікового запису?",
    ),
    "dialogConfirmSave": MessageLookupByLibrary.simpleMessage(
      "Зберегти зміни?",
    ),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Дійсно видалити обліковий запис? Цю дію неможливо скасувати.\nВведіть пароль для підтвердження.",
    ),
    "dialogDeleteAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Пароль",
    ),
    "dialogErrorAppVersion": MessageLookupByLibrary.simpleMessage(
      "Доступна нова версія VACoworking.\nОновіть додаток, щоб продовжити",
    ),
    "dialogErrorServerConnection": MessageLookupByLibrary.simpleMessage(
      "Не вдалося підключитися до сервера VACoworking",
    ),
    "dialogErrorServerMaintenance": MessageLookupByLibrary.simpleMessage(
      "Додаток на обслуговуванні. Спробуйте пізніше",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Помилка"),
    "dialogWarningTitle": MessageLookupByLibrary.simpleMessage("Увага"),
    "displayName": MessageLookupByLibrary.simpleMessage(
      "Відображуване ім\'я (необов\'язково)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Електронна пошта"),
    "enterWithoutUser": MessageLookupByLibrary.simpleMessage(
      "Увійти без користувача",
    ),
    "equipment": MessageLookupByLibrary.simpleMessage("Обладнання"),
    "equipment_air_conditioning": MessageLookupByLibrary.simpleMessage(
      "Кондиціонер",
    ),
    "equipment_bike_parking": MessageLookupByLibrary.simpleMessage(
      "Паркування велосипедів",
    ),
    "equipment_closets": MessageLookupByLibrary.simpleMessage("Шафи"),
    "equipment_copier": MessageLookupByLibrary.simpleMessage(
      "Копіювальна машина",
    ),
    "equipment_ergonomic_chairs": MessageLookupByLibrary.simpleMessage(
      "Ергономічні стільці",
    ),
    "equipment_fiber_optic": MessageLookupByLibrary.simpleMessage(
      "Оптоволоконна зв\'язок",
    ),
    "equipment_game_room": MessageLookupByLibrary.simpleMessage(
      "Ігрова кімната",
    ),
    "equipment_garden": MessageLookupByLibrary.simpleMessage("Сад"),
    "equipment_heating": MessageLookupByLibrary.simpleMessage("Опалення"),
    "equipment_individual_tables": MessageLookupByLibrary.simpleMessage(
      "Індивідуальні столи",
    ),
    "equipment_kitchen": MessageLookupByLibrary.simpleMessage("Кухня"),
    "equipment_lockers": MessageLookupByLibrary.simpleMessage("Шафи"),
    "equipment_lockers_with_keys": MessageLookupByLibrary.simpleMessage(
      "Шафи з ключами",
    ),
    "equipment_meeting_rooms": MessageLookupByLibrary.simpleMessage(
      "Переговорні кімнати",
    ),
    "equipment_parking": MessageLookupByLibrary.simpleMessage("Паркування"),
    "equipment_printer": MessageLookupByLibrary.simpleMessage("Принтер"),
    "equipment_private_office": MessageLookupByLibrary.simpleMessage(
      "Приватний офіс",
    ),
    "equipment_projector": MessageLookupByLibrary.simpleMessage("Проектор"),
    "equipment_scanner": MessageLookupByLibrary.simpleMessage("Сканер"),
    "equipment_screens_monitors": MessageLookupByLibrary.simpleMessage(
      "Екрани / Монітори",
    ),
    "equipment_television": MessageLookupByLibrary.simpleMessage("Телевізор"),
    "equipment_terrace": MessageLookupByLibrary.simpleMessage("Тераса"),
    "equipment_whiteboards": MessageLookupByLibrary.simpleMessage("Білі дошки"),
    "equipment_wired_network": MessageLookupByLibrary.simpleMessage(
      "Провідна мережа",
    ),
    "errorAuthDeleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Не вдалося видалити обліковий запис. Спробуйте ще раз",
    ),
    "errorAuthEmailExists": MessageLookupByLibrary.simpleMessage(
      "Цей email уже зареєстровано",
    ),
    "errorAuthExpiredCode": MessageLookupByLibrary.simpleMessage(
      "Термін дії коду минув",
    ),
    "errorAuthGeneric": MessageLookupByLibrary.simpleMessage(
      "Сталася помилка. Спробуйте ще раз",
    ),
    "errorAuthInvalidCode": MessageLookupByLibrary.simpleMessage(
      "Код недійсний",
    ),
    "errorAuthInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Невірне ім\'я користувача або пароль",
    ),
    "errorAuthInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Email недійсний",
    ),
    "errorAuthInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "Пароль має містити щонайменше 6 символів",
    ),
    "errorAuthInvalidUsername": MessageLookupByLibrary.simpleMessage(
      "Ім\'я користувача має бути 4–20 символів і містити лише літери, цифри, дефіси та підкреслення.",
    ),
    "errorAuthMissingFields": MessageLookupByLibrary.simpleMessage(
      "Відсутні обов\'язкові поля",
    ),
    "errorAuthMissingLogin": MessageLookupByLibrary.simpleMessage(
      "Вкажіть ім\'я користувача або email",
    ),
    "errorAuthRegisterFailed": MessageLookupByLibrary.simpleMessage(
      "Не вдалося завершити реєстрацію. Спробуйте ще раз",
    ),
    "errorAuthSessionFailed": MessageLookupByLibrary.simpleMessage(
      "Не вдалося створити сесію. Спробуйте пізніше",
    ),
    "errorAuthTooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Перевищено максимальну кількість спроб",
    ),
    "errorAuthTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Забагато спроб. Спробуйте пізніше",
    ),
    "errorAuthUsernameExists": MessageLookupByLibrary.simpleMessage(
      "Це ім\'я користувача вже зайняте",
    ),
    "errorAuthWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Невірний пароль",
    ),
    "errorProcessingImage": MessageLookupByLibrary.simpleMessage(
      "Не вдалося обробити зображення",
    ),
    "expandMenu": MessageLookupByLibrary.simpleMessage("Розгорнути"),
    "faq1Answer": MessageLookupByLibrary.simpleMessage(
      "Це інформаційний застосунок про доступні коворкінги, упорядковані за послугами та характеристиками. Він дозволяє шукати й фільтрувати за різними критеріями, щоб знайти ідеальне місце для роботи.",
    ),
    "faq1Question": MessageLookupByLibrary.simpleMessage(
      "Що таке VACoworking?",
    ),
    "faq2Answer": MessageLookupByLibrary.simpleMessage(
      "Додавати коворкінги можуть лише адміністратори застосунку. Щоб додати більше просторів, потрібно звернутися до команди застосунку.",
    ),
    "faq2Question": MessageLookupByLibrary.simpleMessage(
      "Чи можу я додавати коворкінги?",
    ),
    "faq3Answer": MessageLookupByLibrary.simpleMessage(
      "Коли ви дозволяєте сповіщення, на пристрій надходять повідомлення з оновленнями або важливими новинами про коворкінги. Налаштувати сповіщення можна в параметрах застосунку.",
    ),
    "faq3Question": MessageLookupByLibrary.simpleMessage(
      "Як працюють сповіщення?",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Це поле обов\'язкове",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Забули пароль?"),
    "generalSettings": MessageLookupByLibrary.simpleMessage(
      "Загальні налаштування",
    ),
    "generalSettingsOpenSystemSettingsError":
        MessageLookupByLibrary.simpleMessage(
          "Не вдалося відкрити системні налаштування",
        ),
    "generalSettingsSaveErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Не вдалося зберегти налаштування. Перевірте з\'єднання та спробуйте ще раз",
    ),
    "generalSettingsSaveErrorSession": MessageLookupByLibrary.simpleMessage(
      "Не вдається зберегти налаштування. Увійдіть знову",
    ),
    "generalSettingsSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Налаштування збережено",
    ),
    "goToHome": MessageLookupByLibrary.simpleMessage("На головну"),
    "homeCreateInvitationButton": MessageLookupByLibrary.simpleMessage(
      "Створити запрошення",
    ),
    "homeEmptyInvitationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Натисніть Створити запрошення, щоб почати",
    ),
    "homeEmptyInvitationsTitle": MessageLookupByLibrary.simpleMessage(
      "Поки немає створених запрошень",
    ),
    "homeHeroTitle": MessageLookupByLibrary.simpleMessage(
      "Знайдіть гарне місце для роботи",
    ),
    "homeSearchCoworkingButton": MessageLookupByLibrary.simpleMessage(
      "Шукати коворкінги",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Невірний email"),
    "keepSession": MessageLookupByLibrary.simpleMessage("Залишатися в системі"),
    "language": MessageLookupByLibrary.simpleMessage("Мова"),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Арабська"),
    "languageCatalan": MessageLookupByLibrary.simpleMessage("Каталанська"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Китайська"),
    "languageDutch": MessageLookupByLibrary.simpleMessage("Нідерландська"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("Англійська"),
    "languageFrench": MessageLookupByLibrary.simpleMessage("Французька"),
    "languageGerman": MessageLookupByLibrary.simpleMessage("Німецька"),
    "languageHindi": MessageLookupByLibrary.simpleMessage("Гінді"),
    "languageIndonesian": MessageLookupByLibrary.simpleMessage("Індонезійська"),
    "languageItalian": MessageLookupByLibrary.simpleMessage("Італійська"),
    "languageJapanese": MessageLookupByLibrary.simpleMessage("Японська"),
    "languageKorean": MessageLookupByLibrary.simpleMessage("Корейська"),
    "languagePolish": MessageLookupByLibrary.simpleMessage("Польська"),
    "languagePortuguese": MessageLookupByLibrary.simpleMessage("Португальська"),
    "languageRomanian": MessageLookupByLibrary.simpleMessage("Румунська"),
    "languageRussian": MessageLookupByLibrary.simpleMessage("Російська"),
    "languageSpanish": MessageLookupByLibrary.simpleMessage("Іспанська"),
    "languageSwedish": MessageLookupByLibrary.simpleMessage("Шведська"),
    "languageTurkish": MessageLookupByLibrary.simpleMessage("Турецька"),
    "languageUkrainian": MessageLookupByLibrary.simpleMessage("Українська"),
    "lastAccessChipPrefix": MessageLookupByLibrary.simpleMessage(
      "Останній візит",
    ),
    "legalNoticeLabel": MessageLookupByLibrary.simpleMessage(
      "Правова інформація",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Завантаження..."),
    "loginCountdownMessage": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Вийти"),
    "mainRoom": MessageLookupByLibrary.simpleMessage("Головний зал"),
    "markAllAsRead": MessageLookupByLibrary.simpleMessage(
      "Позначити все як прочитане",
    ),
    "menuBarSectionSocial": MessageLookupByLibrary.simpleMessage("Соцмережі"),
    "menuHome": MessageLookupByLibrary.simpleMessage("Головна"),
    "messageChangePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Пароль успішно змінено",
    ),
    "messageDeleteAccountError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося видалити обліковий запис",
    ),
    "messageDeleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Обліковий запис видалено",
    ),
    "messageGeneralError": MessageLookupByLibrary.simpleMessage(
      "Сталася помилка",
    ),
    "messageUpdateError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося оновити профіль",
    ),
    "messageUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Профіль успішно оновлено",
    ),
    "messagesDelete": MessageLookupByLibrary.simpleMessage("Видалити"),
    "messagesDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Видалити це повідомлення?",
    ),
    "messagesDeleted": MessageLookupByLibrary.simpleMessage(
      "Повідомлення видалено",
    ),
    "messagesEdit": MessageLookupByLibrary.simpleMessage("Редагувати"),
    "messagesEdited": MessageLookupByLibrary.simpleMessage("змінено"),
    "messagesEmpty": MessageLookupByLibrary.simpleMessage(
      "У вас ще немає розмов",
    ),
    "messagesErrorDelete": MessageLookupByLibrary.simpleMessage(
      "Не вдалося видалити повідомлення",
    ),
    "messagesErrorEdit": MessageLookupByLibrary.simpleMessage(
      "Не вдалося змінити повідомлення",
    ),
    "messagesErrorSend": MessageLookupByLibrary.simpleMessage(
      "Не вдалося надіслати повідомлення",
    ),
    "messagesNoMessages": MessageLookupByLibrary.simpleMessage(
      "Поки немає повідомлень. Напишіть щось!",
    ),
    "messagesRead": MessageLookupByLibrary.simpleMessage("Прочитано"),
    "messagesSend": MessageLookupByLibrary.simpleMessage("Надіслати"),
    "messagesSent": MessageLookupByLibrary.simpleMessage("Надіслано"),
    "messagesTypeHint": MessageLookupByLibrary.simpleMessage(
      "Напишіть повідомлення...",
    ),
    "moreServices": MessageLookupByLibrary.simpleMessage("більше послуг"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Новий пароль"),
    "noMoreRecords": MessageLookupByLibrary.simpleMessage(
      "Більше записів немає",
    ),
    "notificationDeleteAllAsk": MessageLookupByLibrary.simpleMessage(
      "Видалити всі сповіщення?",
    ),
    "notificationMarkAllAsk": MessageLookupByLibrary.simpleMessage(
      "Позначити всі сповіщення як прочитані?",
    ),
    "notificationMarkReadError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося позначити сповіщення як прочитане",
    ),
    "notificationMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Сповіщення позначено як прочитане.",
    ),
    "notificationsAllMarkedRead": MessageLookupByLibrary.simpleMessage(
      "Усі сповіщення позначено як прочитані",
    ),
    "notificationsDeletedError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося видалити сповіщення",
    ),
    "notificationsDeletedOk": MessageLookupByLibrary.simpleMessage(
      "Сповіщення видалено",
    ),
    "notificationsEmptyText": MessageLookupByLibrary.simpleMessage(
      "У вас немає сповіщень",
    ),
    "notificationsLabel": MessageLookupByLibrary.simpleMessage("Сповіщення"),
    "notificationsNewBadge": MessageLookupByLibrary.simpleMessage("Нове"),
    "notificationsPermissionHint": MessageLookupByLibrary.simpleMessage(
      "Дозволи на сповіщення пристрою",
    ),
    "notificationsPermissionOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Відкрити налаштування",
    ),
    "notificationsStatusOff": MessageLookupByLibrary.simpleMessage("ВИМК."),
    "notificationsStatusOn": MessageLookupByLibrary.simpleMessage("УВІМК."),
    "notificationsWebSettingsBody": MessageLookupByLibrary.simpleMessage(
      "З міркувань безпеки ми не можемо відкрити налаштування браузера. Натисніть на замок біля адреси → Налаштування сайту → Сповіщення, щоб дозволити або заблокувати.",
    ),
    "notificationsWebSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Сповіщення в браузері",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Пароль успішно скинуто",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Не менше 6 символів",
    ),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Паролі не збігаються",
    ),
    "people": MessageLookupByLibrary.simpleMessage("люди"),
    "privacyPoliciesLabel": MessageLookupByLibrary.simpleMessage(
      "Політика конфіденційності",
    ),
    "privateMessages": MessageLookupByLibrary.simpleMessage(
      "Приватні повідомлення",
    ),
    "profileShareSubject": m1,
    "publicProfileAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Профіль користувача",
    ),
    "pushNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Push-сповіщення",
    ),
    "qrTitle": m2,
    "recaptchaError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося підтвердити капчу. Спробуйте ще раз.",
    ),
    "registerError": MessageLookupByLibrary.simpleMessage("Помилка реєстрації"),
    "registerMarketingConsentAccept": MessageLookupByLibrary.simpleMessage(
      "Я погоджуюся отримувати рекламні та комерційні повідомлення",
    ),
    "registerTermsAndConditionsAccept": MessageLookupByLibrary.simpleMessage(
      "Я прочитав(ла) і приймаю",
    ),
    "registerTermsAndConditionsError": MessageLookupByLibrary.simpleMessage(
      "Потрібно прийняти умови використання та політику конфіденційності",
    ),
    "removeBirthdateTooltip": MessageLookupByLibrary.simpleMessage(
      "Прибрати дату",
    ),
    "removeCountryTooltip": MessageLookupByLibrary.simpleMessage(
      "Прибрати країну",
    ),
    "retryPublicProfile": MessageLookupByLibrary.simpleMessage("Повторити"),
    "searchByKeyWord": MessageLookupByLibrary.simpleMessage(
      "Пошук за ім\'ям або послугою",
    ),
    "seeAllDetails": MessageLookupByLibrary.simpleMessage(
      "Переглянути всі деталі",
    ),
    "sendCode": MessageLookupByLibrary.simpleMessage("Надіслати код"),
    "sendMessageTooltip": MessageLookupByLibrary.simpleMessage(
      "Надіслати повідомлення",
    ),
    "service_access": MessageLookupByLibrary.simpleMessage("Доступ 24/7"),
    "service_administrative_management": MessageLookupByLibrary.simpleMessage(
      "Адміністративне управління",
    ),
    "service_autonomous_access": MessageLookupByLibrary.simpleMessage(
      "Автономний доступ",
    ),
    "service_catering": MessageLookupByLibrary.simpleMessage("Кейтеринг"),
    "service_cleaning": MessageLookupByLibrary.simpleMessage("Прибирання"),
    "service_coffee_beverages": MessageLookupByLibrary.simpleMessage(
      "Кава / Напої",
    ),
    "service_events": MessageLookupByLibrary.simpleMessage("Події"),
    "service_fiscal_domiciliation": MessageLookupByLibrary.simpleMessage(
      "Фіскальна реєстрація",
    ),
    "service_mail_reception": MessageLookupByLibrary.simpleMessage(
      "Отримання пошти",
    ),
    "service_networking": MessageLookupByLibrary.simpleMessage("Мережування"),
    "service_phone_support": MessageLookupByLibrary.simpleMessage(
      "Телефонна підтримка",
    ),
    "service_reception": MessageLookupByLibrary.simpleMessage("Ресепшн"),
    "service_relax_zone": MessageLookupByLibrary.simpleMessage(
      "Зона відпочинку",
    ),
    "service_security": MessageLookupByLibrary.simpleMessage("Безпека 24г"),
    "service_social_domiciliation": MessageLookupByLibrary.simpleMessage(
      "Соціальна реєстрація",
    ),
    "service_training": MessageLookupByLibrary.simpleMessage("Навчання"),
    "service_wifi": MessageLookupByLibrary.simpleMessage("WiFi"),
    "service_workshops": MessageLookupByLibrary.simpleMessage("Майстер-класи"),
    "services": MessageLookupByLibrary.simpleMessage("Послуги"),
    "settingsLabel": MessageLookupByLibrary.simpleMessage("Налаштування"),
    "shareOption": MessageLookupByLibrary.simpleMessage("Поділитися"),
    "shareTooltip": MessageLookupByLibrary.simpleMessage("Поділитися"),
    "showMyProfile": MessageLookupByLibrary.simpleMessage("Мій профіль"),
    "showQrOption": MessageLookupByLibrary.simpleMessage("Показати QR"),
    "signIn": MessageLookupByLibrary.simpleMessage("Увійти"),
    "signUp": MessageLookupByLibrary.simpleMessage("Створити обліковий запис"),
    "socialMailLabel": MessageLookupByLibrary.simpleMessage("Електронна пошта"),
    "socialNetworksText": MessageLookupByLibrary.simpleMessage(
      "Слідкуйте за нами в соцмережах.",
    ),
    "socialTelegramLabel": MessageLookupByLibrary.simpleMessage("Telegram"),
    "socialWebError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося відкрити посилання",
    ),
    "socialWhatsappError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося відкрити WhatsApp",
    ),
    "socialWhatsappLabel": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Статус"),
    "subjectSupport": MessageLookupByLibrary.simpleMessage(
      "Зв\'язок з VACoworking",
    ),
    "tel": MessageLookupByLibrary.simpleMessage("Тел:"),
    "termsAndConditionsLabel": MessageLookupByLibrary.simpleMessage(
      "Умови використання",
    ),
    "textUserSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Потрібна допомога? Напишіть нам через будь-який канал — відповімо якнайшвидше.",
    ),
    "textfieldDisplayNameLabel": MessageLookupByLibrary.simpleMessage(
      "Відображуване ім\'я",
    ),
    "textfieldMailEmpty": MessageLookupByLibrary.simpleMessage(
      "Email обов\'язковий",
    ),
    "textfieldMailError": MessageLookupByLibrary.simpleMessage(
      "Email недійсний",
    ),
    "textfieldUserBirthdayLabel": MessageLookupByLibrary.simpleMessage(
      "Дата народження",
    ),
    "textfieldUserCountryLabel": MessageLookupByLibrary.simpleMessage("Країна"),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Темна тема"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Світла тема"),
    "titleAppBar": MessageLookupByLibrary.simpleMessage(
      "Коворкінг у Валладоліді",
    ),
    "total": MessageLookupByLibrary.simpleMessage("Всього"),
    "userAvatar": MessageLookupByLibrary.simpleMessage("Аватар"),
    "userDescription": MessageLookupByLibrary.simpleMessage("Опис"),
    "userEmail": MessageLookupByLibrary.simpleMessage("Електронна пошта"),
    "userNotFoundPublicProfileText": MessageLookupByLibrary.simpleMessage(
      "Користувача не знайдено",
    ),
    "userOrEmail": MessageLookupByLibrary.simpleMessage(
      "Ім\'я користувача або email",
    ),
    "userSectionContact": MessageLookupByLibrary.simpleMessage("Контакти"),
    "userSectionFAQs": MessageLookupByLibrary.simpleMessage("FAQ"),
    "userSectionSessionClose": MessageLookupByLibrary.simpleMessage("Вийти"),
    "userYears": MessageLookupByLibrary.simpleMessage("років"),
    "username": MessageLookupByLibrary.simpleMessage("Ім\'я користувача"),
    "usernameMinLength": MessageLookupByLibrary.simpleMessage(
      "Не менше 4 символів",
    ),
    "verificationCode": MessageLookupByLibrary.simpleMessage(
      "Код підтвердження (6 цифр)",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Версія"),
    "webBlogHint": MessageLookupByLibrary.simpleMessage("https://ваш-сайт.ua"),
    "webBlogLabel": MessageLookupByLibrary.simpleMessage("Сайт / блог"),
    "weekStart": MessageLookupByLibrary.simpleMessage("Перший день тижня"),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Понеділок"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Неділя"),
    "welcome": MessageLookupByLibrary.simpleMessage("Ласкаво просимо!"),
    "wrongCredentials": MessageLookupByLibrary.simpleMessage("Невірні дані"),
  };
}
