// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
  Country({
    this.data,
  });

  Data? data;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.countries,
  });

  List<CountryElement>? countries;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        countries: List<CountryElement>.from(
            json["countries"].map((x) => CountryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries!.map((x) => x.toJson())),
      };
}

class CountryElement {
  CountryElement({
    this.name,
    this.native,
    this.capital,
    this.emoji,
    this.currency,
    this.languages,
  });

  String? name;
  String? native;
  String? capital;
  String? emoji;
  String? currency;
  List<Language>? languages;

  factory CountryElement.fromJson(Map<String, dynamic> json) => CountryElement(
        name: json["name"],
        native: json["native"],
        capital: json["capital"] ?? '',
        emoji: json["emoji"],
        currency: json["currency"],
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "native": native,
        "capital": capital,
        "emoji": emoji,
        "currency": currency,
        "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
      };
}

class Language {
  Language({
    this.code,
    this.name,
  });

  String? code;
  String? name;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}
