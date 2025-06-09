import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Locations/City.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'package:wijha/models/Locations/Province.dart';
import 'package:wijha/models/Notifications/Fact.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/models/Tours/tourInclude.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/providers/tourProvider.dart';
import 'package:wijha/screens/TourTab/tourCreator/tourCreatorWidgets/pickCtg.dart';
import 'package:wijha/screens/TourTab/tourCreator/tourCreatorWidgets/pickInclud.dart';
import 'package:wijha/screens/tourTab/tourCreator/tourCreateConfirm.dart';
import 'package:wijha/widgets/constants.dart';

import '../../../models/Tours/Tour.dart';
import '../../../providers/factProvider.dart';
import '../../../providers/locationProvider.dart';
import 'addLocation/addLocationtoTour.dart';
import 'addLocation/tourLocationSection.dart';

class CreateTourScreen extends ConsumerStatefulWidget {
  final Tour? tour;

  const CreateTourScreen({
    Key? key,
    this.tour,
  }) : super(key: key);

  @override
  ConsumerState<CreateTourScreen> createState() => _CreateTourScreen();
}

class _CreateTourScreen extends ConsumerState<CreateTourScreen> {
  String? title;
  String? description;
  int? capacity;
  List<WCategory>? categories = [];
  List<Location>? locations = [];
  List<Fact>? facts = [];
  DateTime? dateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, 6, 0);
  List<String>? images = [];
  double? price;
  List<TourInclude>? included = [];
  City? city;
  bool network = false;

  List<bool> assetImage = [];
  int points = Tour.travelPoints;
  @override
  initState() {
    super.initState();
    // Province.getAllProvinces();

    if (this.widget.tour != null) {
      title = this.widget.tour?.title;
      description = this.widget.tour?.description;
      capacity = this.widget.tour?.capacity;
      categories = this.widget.tour!.categories;
      locations = this.widget.tour?.destinations;
      facts = this.widget.tour?.facts;
      images = this.widget.tour?.images;
      price = this.widget.tour?.price;
      included = this.widget.tour!.included;
      city = this.widget.tour!.city;
      network = true;

      String image;
      for (image in images!) {
        assetImage.add(false);
      }
    } else {
      title = '';
      description = '';
      capacity = 0;
      categories = [];
      locations = [];
      facts = [];
      images = [];
      price = 0;
      included = [];
    }
  }

  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 10), curve: Curves.linear);
  }

  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 5.
  int upperBound = 4; // upperBound MUST BE total number of icons minus 1.

  var _image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          extendBody: true,
          backgroundColor: wBackgroundColor,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    expandedHeight: 60,
                    centerTitle: true,
                    title: SvgPicture.asset(
                      wLogo,
                      color: white,
                      height: 25,
                    ),
                    backgroundColor: wPurple,
                    forceElevated: innerBoxIsScrolled,
                  ),
                ),
                SliverAppBar(
                  foregroundColor: wJetBlack,
                  expandedHeight: 85,
                  collapsedHeight: 85,
                  elevation: 0,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: IconStepper(
                        enableNextPreviousButtons: true,
                        activeStepColor: wPrimaryColor,
                        activeStepBorderColor: Colors.transparent,
                        lineColor: wPurple,
                        alignment: Alignment.center,
                        icons: [
                          Icon(Icons.info_outline, color: white),
                          Icon(Icons.flag, color: white),
                          Icon(Icons.date_range_outlined, color: white),
                          Icon(Icons.image_outlined, color: white),
                          Icon(Icons.attach_money_sharp, color: white),
                        ],

                        // activeStep property set to activeStep variable defined above.
                        activeStep: activeStep,

                        // This ensures step-tapping updates the activeStep.
                        onStepReached: (index) {
                          setState(() {
                            activeStep = index;
                          });
                        },
                      ),
                    ),
                  ),
                  backgroundColor: wBackgroundColor,
                  forceElevated: innerBoxIsScrolled,
                ),
                SliverAppBar(
                  foregroundColor: wJetBlack,
                  collapsedHeight: 65,
                  elevation: 0,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  flexibleSpace: header(),
                  forceElevated: innerBoxIsScrolled,
                ),
              ];
            },
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(wDefaultPadding),
                  child: formBody(size),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  validateTextField(value) {
    if (value == null || value.isEmpty) {
      return "Please enter some value";
    }
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: wPrimaryColor,
      ),
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
          _scrollToTop();
        }
      },
      child: Text('Next >'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return Visibility(
      visible: (activeStep > 0 ? true : false),
      child: ElevatedButton(
        autofocus: false,
        style: ElevatedButton.styleFrom(
          primary: wPrimaryColor,
        ),
        onPressed: () {
          // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
          if (activeStep > 0) {
            setState(() {
              activeStep--;
            });
          }
        },
        child: Text(
          '< Prev',
          style:
              TextStyle(color: (activeStep > 0 ? white : Colors.transparent)),
        ),
      ),
    );
  }

  /// Go to confirmation screen
  Widget confirmButton(_tours, guide) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: wPrimaryColor,
      ),
      onPressed: () async {
        try {
          Tour tour = Tour(
              id: "0",
              capacity: capacity!,
              title: title!,
              price: price!,
              images: images!,
              guide: guide,
              destinations: locations!,
              facts: facts!,
              categories: categories!,
              description: description!,
              rating: 0,
              city: city != null
                  ? city!
                  : City(
                      name: locations!.length > 0 ? locations![0].city : 'name',
                      description: 'description',
                      imageUrl: 'imageUrl',
                      province: 'province'),
              dateTime: dateTime!,
              included: included!);
          //Tour tour = toursData[0];
          bool confirmed = await confirmScreen(
              context, tour, MediaQuery.of(context).size.longestSide);
          if (confirmed) {
            _tours.add(tour);
            guide.addPoints(points);
            Navigator.pop(context);
            Fluttertoast.showToast(msg: 'Tour Created Successfully');
          }
        } catch (exception) {}
      },
      child: Text('Create'),
    );
  }

  confirmScreen(BuildContext context, Tour tour, double height) {
    return showModalBottomSheet<void>(
      routeSettings: RouteSettings(name: '/modal'),
      isDismissible: false,
      barrierColor: wJetBlack.withOpacity(0.75),
      backgroundColor: wBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      isScrollControlled: true,
      elevation: 0,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          top: false,
          child: Container(
            height: height * 0.95,
            child: ConfirmTourScreen(
              tour: tour,
              participants: 0,
              totalPrice: 0.0,
            ),
          ),
        );
      },
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: wDefaultPadding, vertical: 10),
      color: wPurple,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              headerText(),
              style: TextStyle(
                color: white,
                fontFamily: wFont,
                fontWeight: wBoldWeight,
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Text(
                  (activeStep + 1).toString() + ' / 5',
                  style: TextStyle(
                    color: white,
                    fontFamily: wFont,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 10),
                CircularStepProgressIndicator(
                  totalSteps: 5,
                  currentStep: activeStep + 1,
                  stepSize: 4,
                  selectedColor: Colors.greenAccent[400],
                  unselectedColor: white,
                  padding: 0,
                  width: 45,
                  height: 45,
                  selectedStepSize: 8,
                  roundedCap: (_, __) => true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Locations';

      case 2:
        return 'Date and Time';

      case 3:
        return 'Tour Image';

      case 4:
        return 'Tour Price';

      default:
        return 'Tour Information';
    }
  }

  Widget formBody(Size size) {
    switch (activeStep) {
      case 1:
        return Consumer(
          builder: (context, ref, _) {
            final _locations = ref.watch(locationProvider.notifier);
            final _facts = ref.watch(factProvider.notifier);
            locations = _locations.getLocation();
            facts = _facts.getFacts();
            Future<void> addLoc(BuildContext context) async {
              final result = await Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => AddLocation(
                    locations: _locations.getLocation(),
                    facts: _facts.getFacts(),
                  ),
                  settings: RouteSettings(name: '/creator'),
                ),
              );
              _locations.addLocation((result[0]) as Location);
              _facts.addFact(Fact(
                content: result[1].toString(),
                location: result[0],
              ));
              onStepRefresh();
            }

            return SingleChildScrollView(
              child: Container(
                height: size.height - 270,
                child: Column(children: <Widget>[
                  locations!.length == 0 || facts!.length == 0
                      ? Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) {
                              return emptyLocation();
                            },
                          ),
                        )
                      : Container(
                          height: size.height - 470,
                          child: TourAddLocationTab(
                            locations: _locations.getLocation(),
                            facts: _facts.getFacts(),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: wDefaultPadding),
                    child: FloatingActionButton(
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 32),
                      ),
                      onPressed: () => {
                        addLoc(context),
                      },
                      backgroundColor: wPrimaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: wDefaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        previousButton(),
                        nextButton(),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          },
        );
      case 2:
        return Container(
            height: size.height - 270, child: generateTimeSelector(context));

      case 3:
        return Container(
          height: size.height - 270,
          child: Column(children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[
                  // Show text if image has not been uploaded yet
                  Padding(
                    padding: const EdgeInsets.only(bottom: wDefaultPadding),
                    child: images!.isEmpty
                        ? GridView.builder(
                            itemCount: 9,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) => emptyContainer(),
                          )
                        : GridView.builder(
                            itemCount: 9,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              if (index < images!.length) {
                                final image = images![index];
                                final type = assetImage[index];
                                return imageContainer(index, image, type);
                              } else
                                return emptyContainer();
                            }),
                  ),
                  FloatingActionButton.extended(
                    backgroundColor: wPrimaryColor,
                    label: Text(
                      "Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: wFont,
                          fontWeight: wBoldWeight),
                    ),
                    onPressed: _getImageFromGallery,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: wDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  previousButton(),
                  nextButton(),
                ],
              ),
            ),
          ]),
        );

      case 4:
        return Consumer(builder: (context, ref, _) {
          final _tours = ref.watch(tourProvider.notifier);
          final _auth = ref.watch(userProvider.notifier);
          return Container(
            height: size.height - 270,
            child: Column(children: <Widget>[
              Form(
                  child: new Column(
                children: <Widget>[
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^\d{0,4}\.?\d{0,2})'))
                    ],
                    decoration: InputDecoration(
                      labelText: '*Price in SAR',
                      labelStyle: TextStyle(color: wGrey),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: wPrimaryColor, width: 1.5)),
                      focusColor: wPrimaryColor,
                      fillColor: white,
                      filled: true,
                      enabled: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: wGrey, width: 2)),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: price == null ? null : price!.toString(),
                    onChanged: (newValue) => price = double.parse(newValue),
                  ),
                  PickIncludedWidget(included: this.included!),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(top: wDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    previousButton(),
                    confirmButton(_tours, _auth.getUser()),
                  ],
                ),
              ),
            ]),
          );
        });

      default:
        return Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tour Title',
                labelStyle: TextStyle(color: wGrey),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: wPrimaryColor, width: 1.5)),
                focusColor: wPrimaryColor,
                fillColor: white,
                filled: true,
                enabled: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: wGrey, width: 2)),
              ),
              maxLength: 25,
              initialValue: title == null ? null : title,
              onChanged: (newValue) => title = newValue,
            ),
            SizedBox(height: wDefaultPadding),
            TextFormField(
              maxLines: null,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: "Description",
                labelStyle: TextStyle(color: wGrey),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: wPrimaryColor, width: 1.5)),
                focusColor: wPrimaryColor,
                fillColor: white,
                filled: true,
                enabled: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: wGrey, width: 2)),
              ),
              maxLength: 1300,
              initialValue: description == null ? null : description,
              onChanged: (newValue) => description = newValue,
            ),
            SizedBox(height: wDefaultPadding),
            TextFormField(
              maxLines: null,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: "Number of Tourists",
                labelStyle: TextStyle(color: wGrey),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: wPrimaryColor, width: 1.5)),
                focusColor: wPrimaryColor,
                fillColor: white,
                filled: true,
                enabled: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: wGrey, width: 2)),
              ),
              maxLength: 2,
              initialValue: capacity == null ? null : capacity.toString(),
              onChanged: (newValue) => capacity = int.parse(newValue),
            ),
            PickCtgWidget(categories: this.categories!),
            Padding(
              padding: const EdgeInsets.all(wDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  previousButton(),
                  nextButton(),
                ],
              ),
            ),
          ],
        );
    }
  }

  Container timeBox(String dateStr, String timeStr) {
    return Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.all(wDefaultPadding),
        child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.calendar_today_rounded,
                    color: wPurple,
                    size: 20.0,
                  ),
                  SizedBox(width: 8),
                  Text(
                    dateStr.toString(),
                    style: TextStyle(
                      color: wPurple,
                      fontFamily: wFont,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    color: wPurple,
                    size: 20.0,
                  ),
                  SizedBox(width: 8),
                  Text(
                    timeStr.toString(),
                    style: TextStyle(
                      color: wPurple,
                      fontFamily: wFont,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  _getImageFromGallery() async {
    // Picks an image from the user's gallery
    final List<XFile>? images = await ImagePicker().pickMultiImage();
    // final File? image_file = File(image!.path);
    if (images != null) {
      if (images.length + this.images!.length > 20) {
        print('lol, what are you doing');
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 100,
                color: white,
                child: Text('lol what'),
              );
            });
      } else if (images.length + this.images!.length > 9) {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 100,
                decoration: BoxDecoration(
                    color: wPurple,
                    border: Border(top: BorderSide(color: white, width: 2.5))),
                child: Center(
                  child: Text(
                    'Max image limit is 9',
                    style: TextStyle(
                      fontFamily: wFont,
                      fontSize: 18,
                      color: white,
                      fontWeight: wBoldWeight,
                    ),
                  ),
                ),
              );
            });
      } else {
        // Upload image to bucket and get the corresponding URL
        for (int i = 0; i < images.length; i++) {
          String imageUrl = await Tour.uploadImageBucket(images[i]);
          this.images!.add(imageUrl);
          this.assetImage.add(false);
        }

        // for (int i = 0; i < images.length; i++) {
        //   this.images!.add(File(images[i].path).path);
        //   this.assetImage.add(true);
        // }
        // print('Images: ' + this.images.toString());
        // Refresh the step for image display
        onStepRefresh();
      }
    }
  }

  onStepRefresh() {
    // Refreshes the step so that an image uploaded is displayed immediately
    // setState(() => activeStep = activeStep);
    setState(() {});
  }

  confirmDelete(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Are you sure you want to delete image?',
                      style: TextStyle(
                        color: wJetBlack,
                        fontWeight: wBoldWeight,
                        fontSize: 14,
                        fontFamily: wFont,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => {
                              images!.removeAt(index),
                              onStepRefresh(),
                              Navigator.pop(context)
                            },
                            child: Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(color: white, width: .25),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: white,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: wBoldWeight,
                                      fontSize: 14,
                                      fontFamily: wFont,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => {Navigator.pop(context)},
                            child: Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(color: white, width: .25),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cancel_outlined,
                                    color: white,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'No',
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: wBoldWeight,
                                      fontSize: 14,
                                      fontFamily: wFont,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  emptyLocation() {
    return Card(
        margin: const EdgeInsets.fromLTRB(0, 2.5, 0, 0),
        child: Container(
          height: 105,
          decoration: BoxDecoration(
            gradient: wGradient,
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(2.5), left: Radius.circular(2.5)),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  height: 105,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(15), left: Radius.circular(2.5)),
                  ),
                ),
              ),
              Positioned(
                  left: 155,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .45,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .45,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ],
                  )),
              Positioned(
                right: 5,
                bottom: 5,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Column generateTimeSelector(BuildContext context) {
    try {
      String dateStr = dateTime!.day.toString() +
          ('/') +
          dateTime!.month.toString() +
          ('/') +
          dateTime!.year.toString();

      String timeStr() {
        int hour = dateTime!.hour;
        int minute = dateTime!.minute;
        String hourStr = hour.toString();
        String minuteStr = minute.toString();

        if (minute == 0) minuteStr = minute.toString() + '0';
        if (hour == 0) hourStr = '12';
        if (hour >= 12) {
          if (hour == 12) {
            hourStr = '12';
            return hourStr + (':') + minuteStr + ' PM';
          } else
            hour = hour - 12;
          hourStr = hour.toString();
          return hourStr + (':') + minuteStr + ' PM';
        } else
          return hourStr + (':') + minuteStr + ' AM';
      }

      final now = DateTime.now();
      Widget buildDatePicker() => SizedBox(
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: CupertinoDatePicker(
                  initialDateTime: DateTime(
                      this.dateTime!.year,
                      this.dateTime!.month,
                      this.dateTime!.day,
                      this.dateTime!.hour,
                      this.dateTime!.minute),
                  minimumDate: DateTime(now.year, now.month, now.day + 1, 0, 0),
                  maximumDate: DateTime(now.year, now.month, now.day + 30),
                  mode: CupertinoDatePickerMode.dateAndTime,
                  minuteInterval: 15,
                  onDateTimeChanged: (dateTime) {
                    setState(
                      () => this.dateTime = dateTime,
                    );
                  }),
            ), // CupertinoDatePicker
          ); // SizedBox
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          WTitle(title: 'Pick a date and time:'),
          SizedBox(height: wDefaultPadding),
          buildDatePicker(),
          SizedBox(height: wDefaultPadding),
          timeBox(dateStr, timeStr()),
          Padding(
            padding: const EdgeInsets.only(top: wDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                previousButton(),
                nextButton(),
              ],
            ),
          ),
        ],
      );
    } catch (error) {
      String dateStr = DateTime.now().day.toString() +
          ('/') +
          DateTime.now().month.toString() +
          ('/') +
          DateTime.now().toString();

      String timeStr() {
        int hour = DateTime.now().hour;
        int minute = DateTime.now().minute;
        String hourStr = hour.toString();
        String minuteStr = minute.toString();

        if (minute == 0) minuteStr = minute.toString() + '0';
        if (hour == 0) hourStr = '12';
        if (hour >= 12) {
          if (hour == 12) {
            hourStr = '12';
            return hourStr + (':') + minuteStr + ' PM';
          } else
            hour = hour - 12;
          hourStr = hour.toString();
          return hourStr + (':') + minuteStr + ' PM';
        } else
          return hourStr + (':') + minuteStr + ' AM';
      }

      final now = DateTime.now();
      Widget buildDatePicker() => SizedBox(
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: CupertinoDatePicker(
                  initialDateTime: DateTime(
                      this.dateTime!.year,
                      this.dateTime!.month,
                      this.dateTime!.day,
                      this.dateTime!.hour,
                      this.dateTime!.minute),
                  minimumDate: DateTime(now.year, now.month, now.day + 1, 0, 0),
                  maximumDate: DateTime(now.year, now.month, now.day + 30),
                  mode: CupertinoDatePickerMode.dateAndTime,
                  minuteInterval: 15,
                  onDateTimeChanged: (dateTime) {
                    setState(
                      () => this.dateTime = dateTime,
                    );
                  }),
            ), // CupertinoDatePicker
          ); // SizedBox
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          WTitle(title: 'Pick a date and time:'),
          SizedBox(height: wDefaultPadding),
          buildDatePicker(),
          SizedBox(height: wDefaultPadding),
          timeBox(dateStr, timeStr()),
          Padding(
            padding: const EdgeInsets.only(top: wDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                previousButton(),
                nextButton(),
              ],
            ),
          ),
        ],
      );
    }
  }

  imageContainer(int index, String image, bool asset) {
    return InkWell(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (_) => ImageDialog(
            image: image,
            asset: asset,
          ),
        );
      },
      onLongPress: () => {
        confirmDelete(index),
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: wGrey,
              spreadRadius: .5,
              blurRadius: .5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: asset
              ? Image.file(
                  File(image),
                  fit: BoxFit.cover,
                )
              : Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  emptyContainer() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: wGrey,
            spreadRadius: .5,
            blurRadius: .5,
          ),
        ],
        gradient: wGradient,
      ),
      child: Text(
        "No image",
        style: TextStyle(
          color: white,
          fontSize: 16,
          fontWeight: wBoldWeight,
          fontFamily: wFont,
        ),
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final String image;
  final bool asset;

  ImageDialog({
    required this.image,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.5)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2.5),
          child: asset
              ? Image.file(
                  File(this.image),
                  fit: BoxFit.cover,
                )
              : Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
