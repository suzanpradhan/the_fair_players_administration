import 'package:firebase_database/firebase_database.dart';
import 'package:the_fair_players_administration/modules/dashboard_app_bar/models/country_model.dart';

import '../../core/services/firebase_database_service.dart';

class CountryRepository {
  Future<List<Country>> getAllCountries() async {
    DataSnapshot countryDataSnapshot =
        await FirebaseDatabaseService().getReference("Countries").get();
    return (countryDataSnapshot.value as Map)
        .map((key, value) =>
            MapEntry<dynamic, Country>(key, Country(key: key, value: value)))
        .values
        .toList();
  }
}
