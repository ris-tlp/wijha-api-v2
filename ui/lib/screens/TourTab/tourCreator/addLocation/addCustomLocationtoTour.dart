import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:wijha/models/Locations/CustomLocation.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'package:wijha/models/Notifications/Fact.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/widgets/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wijha/widgets/constants.dart';

class AddCustomLocation extends StatefulWidget {
  final List<Location> locations;
  final List<Fact> facts;

  const AddCustomLocation({
    Key? key,
    required this.locations,
    required this.facts,
  }) : super(key: key);

  @override
  State<AddCustomLocation> createState() => _AddCustomLocationState();
}

class _AddCustomLocationState extends State<AddCustomLocation> {
  List<CustomLocation>? locations;
  List<CustomLocation>? _cusLocList;
  Future<List<CustomLocation>>? futureCustomlocations;
  List<DropdownMenuItem> cusLocItems = [];

  CustomLocation? selectedCustomLocation;
  Location? selectedLocation;

  String? locationFact;
  bool loading = true;
  bool listBuilt = false;

  fetchCustomLocationsByGuide(User user) {
    futureCustomlocations = CustomLocation.fetchCustomLocationsByGuide(user);
    futureCustomlocations!.then((data) => setState(() {
          _cusLocList = data;
        }));
  }

  void buildCusLocList() {
    _cusLocList!.forEach((location) {
      cusLocItems.add(DropdownMenuItem(
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
    listBuilt = true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final _auth = ref.watch(userProvider.notifier);
      User user = _auth.getUser();
      final double width = MediaQuery.of(context).size.width;

      if (_cusLocList != null) {
        loading = false;
        // buildCusLocList();

        if (!listBuilt) {
          buildCusLocList();
        }
      } else {
        fetchCustomLocationsByGuide(user);
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
                    Navigator.pop(context, true);
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
                                  'Custom Location',
                                  style: TextStyle(
                                    color: wMagenta,
                                    fontFamily: wFont,
                                    fontSize: 18,
                                    fontWeight: wBoldWeight,
                                  ),
                                ),
                                SearchChoices.single(
                                  value: selectedCustomLocation,
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: wJetBlack,
                                    fontSize: 16,
                                    fontFamily: wFont,
                                  ),
                                  displayClearIcon: false,
                                  searchHint: Text(
                                    'Search locations',
                                    style: TextStyle(
                                      color: wMagenta,
                                      fontFamily: wFont,
                                      fontSize: 14,
                                    ),
                                  ),
                                  hint: Text(
                                    'Select location',
                                    style: TextStyle(
                                      fontFamily: wFont,
                                      fontSize: 16,
                                      fontWeight: wLightWeight,
                                    ),
                                  ),
                                  items: cusLocItems,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCustomLocation = value;
                                      selectedLocation = new Location(
                                        name: selectedCustomLocation!.name,
                                        description:
                                            selectedCustomLocation!.description,
                                        imageUrl: selectedCustomLocation!.image,
                                        city: '',
                                        province: '',
                                      );
                                    });
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
                                  onSaved: (newValue) =>
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
                          onPressed: () => selectedCustomLocation != null &&
                                  locationFact != null
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
    });
  }

  validateTextField(value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
  }

  addLocation(Location? selectedLocation) {
    var f = selectedLocation;
    if (f != null) {
      this.widget.locations.add(f);
    }
  }
}
