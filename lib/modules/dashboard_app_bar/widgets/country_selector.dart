import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../analytics/blocs/analytic_dates/analytic_dates_bloc.dart';
import '../blocs/get_countries/get_countries_bloc.dart';

class CountrySelectorWidget extends StatelessWidget {
  const CountrySelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnalyticDatesBloc, AnalyticDatesState>(
      listener: (context, state) {
        log(state.country.toString(), name: "selectedCountry");
      },
      child: BlocBuilder<AnalyticDatesBloc, AnalyticDatesState>(
        builder: (context, state) {
          return BlocBuilder<GetCountriesBloc, GetCountriesState>(
            builder: (context, state) {
              if (state is GotCountriesSuccessState) {
                List<String> countries =
                    state.countries.map((e) => e.value).toList();
                countries.insert(0, "Select Country");
                return SizedBox(
                  width: 200,
                  height: 50,
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      showSearchBox: true,
                      disabledItemFn: (String val) => val == "Select Country",
                    ),
                    items: countries,
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<AnalyticDatesBloc>()
                            .add(ChangeCountryAnalytic(country: value));
                      }

                      log(value.toString(), name: "dropdown");
                    },
                    selectedItem: countries.first,
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
