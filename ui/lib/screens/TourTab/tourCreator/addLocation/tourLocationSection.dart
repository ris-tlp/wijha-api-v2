import 'package:flutter/material.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'package:wijha/models/Notifications/Fact.dart';
import 'package:wijha/widgets/constants.dart';

class TourAddLocationTab extends StatefulWidget {
  final List<Location> locations;
  final List<Fact> facts;
  final bool preview;

  const TourAddLocationTab(
      {Key? key,
      required this.locations,
      required this.facts,
      this.preview = false})
      : super(key: key);

  @override
  State<TourAddLocationTab> createState() => _TourAddLocationTabState();
}

class _TourAddLocationTabState extends State<TourAddLocationTab> {
  List ids = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.locations.length + 10; i++) {
      ids.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return !widget.preview
        ? ReorderableListView.builder(
            shrinkWrap: true,
            itemCount: this.widget.locations.length,
            onReorder: (int oldIndex, int newIndex) {
              final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
              final location = this.widget.locations.removeAt(oldIndex);
              final fact = this.widget.facts.removeAt(oldIndex);
              this.widget.locations.insert(index, location);
              this.widget.facts.insert(index, fact);
            },
            itemBuilder: (context, index) {
              final id = ids[index];
              final location = this.widget.locations[index];
              final fact = this.widget.facts[index];
              return buildLocation(index, id, location, fact);
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: this.widget.locations.length,
            itemBuilder: (context, index) {
              final id = ids[index];
              final location = this.widget.locations[index];
              final fact = this.widget.facts[index];
              return buildLocation(index, id, location, fact);
            },
          );
  }

  Widget buildLocation(int index, int id, Location location, Fact fact) => Card(
      key: ValueKey(id),
      margin: const EdgeInsets.fromLTRB(0, 2.5, 0, 0),
      child: Container(
        height: 105,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.horizontal(
              right: Radius.circular(25), left: Radius.circular(2.5)),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: Container(
                height: 105,
                width: 150,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: wGrey, blurRadius: 1.25)],
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(15), left: Radius.circular(2.5)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(15), left: Radius.circular(2.5)),
                  child: Image(
                    image: NetworkImage(location.imageUrl),
                    fit: BoxFit.fill,
                  ),
                  // child: Image.network(location.imageUrl)
                ),
              ),
            ),
            Positioned(
                left: 155,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .45,
                      child: Text(
                        location.name,
                        style: TextStyle(
                          fontFamily: wFont,
                          fontSize: 18,
                          fontWeight: wBoldWeight,
                          color: wMagenta,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: .5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .45,
                      child: Text(
                        fact.content,
                        style: TextStyle(
                          fontFamily: wFont,
                          fontSize: 14,
                          color: wGrey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )),
            Positioned(
              right: 2,
              bottom: .05,
              child: !widget.preview
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: wPrimaryColor,
                            ),
                            onPressed: () => {edit(index)}),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: wPrimaryColor,
                          ),
                          onPressed: () => remove(index),
                        ),
                      ],
                    )
                  : Text(
                      'Preview',
                      style: TextStyle(
                        fontSize: 10,
                        color: wGrey,
                      ),
                    ),
            ),
          ],
        ),
      )
      // ListTile(
      //   leading: ClipRRect(
      //     borderRadius: BorderRadius.circular(20),
      //     child: Image(
      //       image: AssetImage(location.imageUrl),
      //     ),
      //   ),
      //   title: Text(
      //     location.name,
      //     style: TextStyle(
      //       fontFamily: wFont,
      //       fontSize: 16,
      //       fontWeight: wBoldWeight,
      //       color: wMagenta,
      //     ),
      //     overflow: TextOverflow.ellipsis,
      //   ),
      //   subtitle: Text(
      //     fact.content,
      //     style: TextStyle(
      //       fontFamily: wFont,
      //       fontSize: 12,
      //       color: wGrey,
      //     ),
      //     maxLines: 1,
      //     overflow: TextOverflow.ellipsis,
      //   ),
      //   trailing: !widget.preview ? Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       IconButton(
      //           icon: Icon(
      //             Icons.edit,
      //             color: wPrimaryColor,
      //           ),
      //           onPressed: () => {edit(index)}
      //       ),
      //       IconButton(
      //         icon: Icon(
      //           Icons.delete,
      //           color: wPrimaryColor,
      //         ),
      //         onPressed: () => remove(index),
      //       ),
      //     ],
      //   ) : null
      // ),
      );

  void remove(int index) => setState(() => {
        this.widget.locations.removeAt(index),
        this.widget.facts.removeAt(index)
      });

  void edit(int index) => showDialog(
      context: context,
      builder: (context) {
        final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
        String _fact = widget.facts[index].content;

        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Container(
            height: 180,
            padding: EdgeInsets.all(wDefaultPadding),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Change fact',
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
                      initialValue: _fact,
                      maxLength: 250,
                      onChanged: (value) {
                        setState(() {
                          _fact = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Fact cannot be empty!";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      print(_fact);
                      if (_formKey.currentState!.validate()) {
                        super.setState(() {
                          widget.facts[index].content = _fact;
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => wPrimaryColor),
                    ),
                    child: Text(
                      'Change',
                      style: TextStyle(
                        fontFamily: wFont,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
