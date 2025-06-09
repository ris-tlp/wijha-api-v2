import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wijha/models/Locations/CustomLocation.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/screens/TourTab/guide/customLocation/customLocationList.dart';
import 'package:wijha/screens/map/chooseLocation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomLocationPage extends StatefulWidget {
  State<CustomLocationPage> createState() => CustomLocationPageState();
}

class CustomLocationPageState extends State<CustomLocationPage> {
  var _image;
  var _coordinates;
  var mapPreview;
  Completer<GoogleMapController> _controller = Completer();
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  CustomLocation location = new CustomLocation.empty();
  User? user;

  // Form keys for each stepper step
  List<GlobalKey<FormState>> _formKeys = [
    for (var i = 0; i < 4; i += 1) GlobalKey<FormState>()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final _auth = ref.watch(userProvider.notifier);
      user = _auth.getUser();
      return Scaffold(
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
        ),
        body: Container(
            child: Column(
          children: [
            Theme(
                data: ThemeData(
                    colorScheme: Theme.of(context)
                        .colorScheme
                        .copyWith(primary: wJetBlack)),
                child: Form(
                    child: Expanded(
                        child: Stepper(
                            type: stepperType,
                            physics: ScrollPhysics(),
                            currentStep: _currentStep,
                            onStepTapped: (step) => onStepTapped(step),
                            onStepContinue: onStepContinue,
                            onStepCancel: onStepCancel,
                            steps: returnStepList()))))
          ],
        )),
      );
    });
  }

  returnStepList() {
    return [
      Step(
          title: new Text(
            "Pin Location on Map",
            style: TextStyle(
                color: wMagenta,
                fontFamily: wFont,
                fontSize: 20,
                fontWeight: wBoldWeight),
          ),
          content: Form(
              key: _formKeys[0],
              child: Column(children: <Widget>[
                _coordinates == null
                    ? Text("No location selected")
                    : returnMap(_coordinates),
                MaterialButton(
                  color: wPrimaryColor,
                  child: Text("Open Map"),
                  onPressed: _getCoordinatesFromMap,
                ),
              ]))),
      Step(
          title: new Text(
            "Location Information",
            style: TextStyle(
                color: wMagenta,
                fontFamily: wFont,
                fontSize: 20,
                fontWeight: wBoldWeight),
          ),
          content: Form(
              key: _formKeys[1],
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "Name"),
                    validator: (value) => validateTextField(value),
                    onSaved: (newValue) => location.setName = newValue!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Description"),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (value) => validateTextField(value),
                    onSaved: (newValue) => location.setDescription = newValue!,
                  )
                ],
              ))),
      Step(
          title: new Text(
            "Location Fact",
            style: TextStyle(
                color: wMagenta,
                fontFamily: wFont,
                fontSize: 20,
                fontWeight: wBoldWeight),
          ),
          content: Form(
              key: _formKeys[2],
              child: new Column(
                children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(labelText: "Fact"),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) => validateTextField(value),
                      onSaved: (newValue) =>
                          location.setLocationFact = newValue!)
                ],
              ))),
      Step(
          title: new Text(
            "Upload an Image",
            style: TextStyle(
                color: wMagenta,
                fontFamily: wFont,
                fontSize: 20,
                fontWeight: wBoldWeight),
          ),
          content: Form(
              key: _formKeys[3],
              child: Column(
                children: <Widget>[
                  // Show text if image has noot been uploaded yet
                  _image == null
                      ? Text("No image uploaded")
                      : Image.file(File(_image!.path)),
                  MaterialButton(
                    color: wPrimaryColor,
                    child: Text("Pick Image from Gallery"),
                    onPressed: _getImageFromGallery,
                  ),
                ],
              )))
    ];
  }

  _getCoordinatesFromMap() async {
    // Renders the Map and fetches the coordinates of the chosen location
    Marker chosenLocation = await Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ChooseLocation()));
    _coordinates = chosenLocation.position;
    // Refresh the step for coordinates display
    onStepRefresh();
  }

  SizedBox returnMap(LatLng position) {
    var newPosition = CameraPosition(target: position, zoom: 14.5);
    CameraUpdate update = CameraUpdate.newCameraPosition(newPosition);
    CameraUpdate zoom = CameraUpdate.zoomTo(14.5);

    Set<Marker> _markers = Set<Marker>();
    _markers.add(Marker(
      markerId: MarkerId('_name'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      position: position,
    ));
    return SizedBox(
      height: MediaQuery.of(context).size.longestSide * 0.25,
      width: MediaQuery.of(context).size.shortestSide * 0.5,
      child: AbsorbPointer(
        absorbing: true,
        child: GoogleMap(
          mapType: MapType.normal,
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: _markers.last.position,
            zoom: 14.5,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
        ),
      ),
    );
  }

  Future<void> moveCamera(LatLng point) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: point,
      zoom: 14.5,
    )));
  }

  _getImageFromGallery() async {
    // Picks an image from the user's gallery
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // final File? image_file = File(image!.path);
    _image = image;

    // Refresh the step for image display
    onStepRefresh();
  }

  validateTextField(value) {
    // Validator for text fields
    if (value == null || value.isEmpty) {
      return "Please enter some text";
    }
  }

  onStepRefresh() {
    // Refreshes the step so that an image uploaded is displayed immediately
    setState(() => _currentStep = _currentStep);
  }

  onStepTapped(int step) {
    // State Method to update the current state of the Stepper Widget
    setState(() => _currentStep = step);
  }

  onStepContinue() async {
    // State Method, submits form if on the last step and continued
    // If not, goes to next step
    if (_formKeys[_currentStep].currentState!.validate()) {
      _formKeys[_currentStep].currentState!.save();
      if (_currentStep == returnStepList().length - 1) {
        onStepSubmit(user!);
      } else {
        _currentStep < returnStepList().length
            ? setState(() => _currentStep += 1)
            : null;
      }
    }
  }

  onStepCancel() {
    // State Method to change state to the previous one
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  onStepSubmit(User user) {
    // Submit on the last stepper after validating everything
    location.createCustomLocation(_image, _coordinates, user);
    CustomLocationList();
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }
}
