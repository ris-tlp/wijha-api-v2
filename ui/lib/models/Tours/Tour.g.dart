// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Tour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tour _$TourFromJson(Map<String, dynamic> json) =>
    Tour.orderedLocationsConstructor(
        capacity: json['capacity'] as int,
        title: json['title'] as String,
        price: (json['price'] as num).toDouble(),
        images:
            (json['images'] as List<dynamic>).map((e) => e as String).toList(),
        guide: Guide.fromJson(json["guide"]),

        /// Change to Guide
        orderedLocations: (json['orderedLocations'] as List<dynamic>)
            .map((e) => OrderedTourLocation.fromJson(e as Map<String, dynamic>))
            .toList(),
        categories: (json['categories'] as List<dynamic>)
            .map((e) => WCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
        description: json['description'] as String,
        rating: (json['rating'] as num).toDouble(),
        city: City(description: "", name: "", imageUrl: "", province: ""),
        dateTime: DateTime.parse(json['dateTime'] as String),
        included: (json['included'] as List<dynamic>)
            .map((e) => TourInclude.fromJson(e as Map<String, dynamic>))
            .toList(),
        id: json["tour_id"]);
// ..id = json['id'] as int
// ..registered = (json['registered'] as List<dynamic>)
//     .map((e) => User.fromJson(e as Map<String, dynamic>))
//     .toList()
// ..attendance = (json['attendance'] as List<dynamic>)
//     .map((e) => User.fromJson(e as Map<String, dynamic>))
//     .toList()
// ..reviews = (json['reviews'] as List<dynamic>)
//     .map((e) => Review.fromJson(e as Map<String, dynamic>))
//     .toList()
// ..registrationRequests = (json['registrationRequests'] as List<dynamic>)
//     .map((e) => Request.fromJson(e as Map<String, dynamic>))
//     .toList();

Map<String, dynamic> _$TourToJson(Tour instance) => <String, dynamic>{
      'capacity': instance.capacity,
      'id': instance.id,
      'rating': instance.rating,
      'price': instance.price,
      'title': instance.title,
      'description': instance.description,
      'guide': instance.guide,
      'city': instance.city,
      'dateTime': instance.dateTime.toIso8601String(),
      'facts': instance.facts,
      'images': instance.images,
      'destinations': instance.destinations,
      'categories': instance.categories,
      'included': instance.included,
      'attendance': instance.attendance,
      'reviews': instance.reviews,
      'registrationRequests': instance.registrationRequests,
    };

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as int? ?? 0,
      participants: json['participants'] as int? ?? 1,
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'user': instance.user,
      'date': instance.date.toIso8601String(),
      'status': instance.status,
      'participants': instance.participants,
    };
