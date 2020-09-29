class Language {
  String englishName;
  String localName;
  String flag;
  String languageCode;

  Language(this.englishName, this.localName, this.flag, this.languageCode);
}

class LanguagesList {
  List<Language> _languages;

  LanguagesList() {
    this._languages = [
      new Language("English", "English", "assets/img/united-states-of-america.png", 'en'),
      new Language("Arabic", "العربية", "assets/img/united-arab-emirates.png", 'ar'),
    ];
  }

  List<Language> get languages => _languages;
}
