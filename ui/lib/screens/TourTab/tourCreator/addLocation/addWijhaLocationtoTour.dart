import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'package:wijha/models/Locations/Province.dart';
import 'package:wijha/models/Notifications/Fact.dart';
import 'package:wijha/widgets/loading.dart';
import '../../../../models/Locations/City.dart';
import '../../../../widgets/constants.dart';

class AddWijhaLocation extends StatefulWidget {
  final List<Location> locations;
  final List<Fact> facts;

  const AddWijhaLocation({
    Key? key,
    required this.locations,
    required this.facts,
  }) : super(key: key);

  @override
  State<AddWijhaLocation> createState() => _AddWijhaLocationState();
}

class _AddWijhaLocationState extends State<AddWijhaLocation> {
  List<Province>? _provinceList;
  List<City>? _cityList;
  List<Location>? _locationList;
  Future<List<Province>>? futureProvinces;
  Future<List<City>>? futureCitiesInProvince;
  Future<List<Location>>? futureLocationsInCities;
  List<DropdownMenuItem> provinceItems = [];
  List<DropdownMenuItem> cityItems = [];
  List<DropdownMenuItem> locationItems = [];

  Province? selectedProvince;
  City? selectedCity;
  Location? selectedLocation;
  String? locationFact;
  bool loading = true;
  bool citiesFetched = false;
  bool locationsFetched = false;
  bool provinceListBuilt = false;
  bool cityListBuilt = false;
  bool locationListBuilt = false;
  // int counter = 0;

  void fetchCitiesInProvince(Province province) async {
    futureCitiesInProvince = Province.fetchCitiesInProvince(province.name);
    futureCitiesInProvince!.then((data) => setState((() {
          _cityList = data;
          cityListBuilt = false;
        })));
  }

  void fetchLocationsInCity(City city) async {
    futureLocationsInCities = City.fetchLocationsInCity(city.name);
    futureLocationsInCities!.then((data) => setState(() {
          _locationList = data;
          locationListBuilt = false;
        }));
  }

  List<DropdownMenuItem> getCityList() {
    List<DropdownMenuItem> tempItems = [];
    _cityList!.forEach((city) {
      tempItems.add(DropdownMenuItem(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Text(
            city.toString(),
            style: TextStyle(
              fontFamily: wFont,
              fontSize: 16,
            ),
          ),
        ),
        value: city,
      ));
    });

    // List<DropdownMenuItem> tempItems = [];
    // cityList!.forEach((city) {
    //   tempItems.add(DropdownMenuItem(
    //     child: Padding(
    //       padding: const EdgeInsets.all(0),
    //       child: Text(
    //         city.toString(),
    //         style: TextStyle(
    //           fontFamily: wFont,
    //           fontSize: 16,
    //         ),
    //       ),
    //     ),
    //     value: city,
    //   ));
    // });

    cityListBuilt = true;
    return tempItems;
  }

  List<DropdownMenuItem> getLocationList() {
    // List<Location> locationList = city.locationList;
    List<DropdownMenuItem> tempItems = [];
    _locationList!.forEach((location) {
      tempItems.add(DropdownMenuItem(
        child: Text(
          location.toString(),
          style: TextStyle(
            fontFamily: wFont,
            fontSize: 16,
          ),
        ),
        value: location,
      ));
    });

    locationListBuilt = true;
    return tempItems;
  }

  /// Builds the province list to be used by the initial dropdown method
  /// Needs to be a method invoked after initState and not within due to
  /// the GET request being made
  void buildProvinceList() {
    _provinceList!.forEach((province) {
      provinceItems.add(DropdownMenuItem(
        child: Text(
          province.toString(),
          style: TextStyle(
            fontFamily: wFont,
            fontSize: 16,
          ),
        ),
        value: province,
      ));
    });

    provinceListBuilt = true;
  }

  @override
  void initState() {
    super.initState();
    futureProvinces = Province.fetchAllProvinces();
    futureProvinces!.then((data) => setState((() {
          _provinceList = data;
        })));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    if (_provinceList != null) {
      setState(() {
        loading = false;
        if (!provinceListBuilt) {
          buildProvinceList();
        }
      });
    }

    if (_cityList != null) {
      if (citiesFetched) {
        setState(() {
          loading = false;
          if (!cityListBuilt) {
            cityItems = getCityList();
          }
        });
      }
    }

    if (_locationList != null) {
      if (locationsFetched) {
        setState(() {
          loading = false;
          if (!locationListBuilt) {
            locationItems = getLocationList();
          }
        });
      }
    }

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              toolbarHeight: 50,
              elevation: 0,
              backgroundColor: white,
              leading: IconButton(
                icon: Container(
                  height: 25,
                  child: Icon(
                    Icons.arrow_back,
                    color: wJetBlack,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Select Location'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0, wDefaultPadding, 0, wDefaultPadding),
                      child: Container(
                        width: width * .9,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(
                              color: wGrey,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: wGrey,
                                spreadRadius: .5,
                                blurRadius: 2,
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Province',
                                style: TextStyle(
                                  color: wMagenta,
                                  fontFamily: wFont,
                                  fontSize: 18,
                                  fontWeight: wBoldWeight,
                                ),
                              ),
                              SearchChoices.single(
                                value: selectedProvince,
                                isExpanded: true,
                                style: TextStyle(
                                  color: wJetBlack,
                                  fontSize: 16,
                                  fontFamily: wFont,
                                ),
                                displayClearIcon: false,
                                searchHint: Text(
                                  'Search provinces',
                                  style: TextStyle(
                                    color: wMagenta,
                                    fontFamily: wFont,
                                    fontSize: 14,
                                  ),
                                ),
                                hint: Text(
                                  'Select province',
                                  style: TextStyle(
                                    fontFamily: wFont,
                                    fontSize: 16,
                                    fontWeight: wLightWeight,
                                  ),
                                ),
                                items: provinceItems,
                                onChanged: (value) {
                                  // setState(() => fetchCitiesInProvince(value));

                                  // inspect(_cityList);
                                  selectedProvince = value;
                                  loading = true;
                                  citiesFetched = true;
                                  fetchCitiesInProvince(value);
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(0, 0, 0, wDefaultPadding),
                      child: Container(
                        width: width * .9,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(
                              color: wGrey,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: wGrey,
                                spreadRadius: .5,
                                blurRadius: 2,
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'City',
                                style: TextStyle(
                                  color: wMagenta,
                                  fontFamily: wFont,
                                  fontSize: 18,
                                  fontWeight: wBoldWeight,
                                ),
                              ),
                              SearchChoices.single(
                                value: selectedCity,
                                isExpanded: true,
                                style: TextStyle(
                                  color: wJetBlack,
                                  fontSize: 16,
                                  fontFamily: wFont,
                                ),
                                displayClearIcon: false,
                                disabledHint: Text(
                                  'Select a province',
                                  style: TextStyle(
                                    color: wGrey,
                                    fontFamily: wFont,
                                    fontSize: 16,
                                    fontWeight: wLightWeight,
                                  ),
                                ),
                                searchHint: Text(
                                  'Search cities',
                                  style: TextStyle(
                                    color: wMagenta,
                                    fontFamily: wFont,
                                    fontSize: 14,
                                  ),
                                ),
                                hint: Text(
                                  'Select City',
                                  style: TextStyle(
                                    fontFamily: wFont,
                                    fontSize: 16,
                                    fontWeight: wLightWeight,
                                  ),
                                ),
                                items: cityItems,
                                onChanged: (value) {
                                  selectedCity = value;
                                  // locationItems = getLocationList(value);
                                  loading = true;
                                  locationsFetched = true;
                                  fetchLocationsInCity(value);
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(0, 0, 0, wDefaultPadding),
                      child: Container(
                        width: width * .9,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(
                              color: wGrey,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: wGrey,
                                spreadRadius: .5,
                                blurRadius: 2,
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(
                                  color: wMagenta,
                                  fontFamily: wFont,
                                  fontSize: 18,
                                  fontWeight: wBoldWeight,
                                ),
                              ),
                              SearchChoices.single(
                                value: selectedLocation,
                                isExpanded: true,
                                style: TextStyle(
                                  color: wJetBlack,
                                  fontSize: 16,
                                  fontFamily: wFont,
                                ),
                                displayClearIcon: false,
                                disabledHint: Text(
                                  'Select a city',
                                  style: TextStyle(
                                    color: wGrey,
                                    fontFamily: wFont,
                                    fontSize: 16,
                                    fontWeight: wLightWeight,
                                  ),
                                ),
                                searchHint: Text(
                                  'Search locations',
                                  style: TextStyle(
                                    color: wMagenta,
                                    fontFamily: wFont,
                                    fontSize: 14,
                                  ),
                                ),
                                hint: Text(
                                  'Select Location',
                                  style: TextStyle(
                                    fontFamily: wFont,
                                    fontSize: 16,
                                    fontWeight: wLightWeight,
                                  ),
                                ),
                                items: locationItems,
                                onChanged: (value) {
                                  setState(() {
                                    selectedLocation = value;
                                    locationItems = getLocationList();
                                  });
                                },
                                validator: validateTextField(
                                    selectedLocation.toString(),
                                    'Please select a location'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(0, 0, 0, wDefaultPadding),
                      child: Container(
                        width: width * .9,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(
                              color: wGrey,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: wGrey,
                                spreadRadius: .5,
                                blurRadius: 2,
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Fact',
                                style: TextStyle(
                                  color: wMagenta,
                                  fontFamily: wFont,
                                  fontSize: 18,
                                  fontWeight: wBoldWeight,
                                ),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Location Fact',
                                  labelStyle: TextStyle(color: wGrey),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: wPrimaryColor, width: 1.5)),
                                  focusColor: wPrimaryColor,
                                  fillColor: white,
                                  filled: true,
                                  enabled: true,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: wGrey, width: 2)),
                                ),
                                initialValue: locationFact ?? null,
                                keyboardType: TextInputType.text,
                                validator: (value) => validateTextField(
                                    value, 'Please enter a fact'),
                                onChanged: (newValue) =>
                                    locationFact = newValue,
                                maxLength: 250,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: width * .9,
                      child: FloatingActionButton(
                        onPressed: () => {
                          print(selectedLocation),
                          print(locationFact),
                          (selectedLocation != null && locationFact != null)
                              ? Navigator.pop(
                                  context, [selectedLocation, locationFact])
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Expanded(
                                      child: AlertDialog(
                                        title: Text(
                                          'Failed',
                                          style: TextStyle(
                                              fontFamily: wFont,
                                              fontSize: 24,
                                              color: wPrimaryColor,
                                              fontWeight: wBoldWeight),
                                        ),
                                        content: Text(
                                          'Please select a location and enter a location fact!',
                                          style: TextStyle(
                                            fontFamily: wFont,
                                            fontSize: 18,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Close',
                                              style: TextStyle(
                                                fontFamily: wFont,
                                                fontSize: 18,
                                                color: wPrimaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        },
                        backgroundColor: wPrimaryColor,
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontFamily: wFont,
                            fontSize: 22,
                          ),
                        ),
                        isExtended: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  validateTextField(value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
  }
}
