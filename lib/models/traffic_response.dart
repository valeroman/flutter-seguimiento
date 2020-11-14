// To parse this JSON data, do
//
//     final drivingResponse = drivingResponseFromJson(jsonString);

import 'dart:convert';

DrivingResponse drivingResponseFromJson(String str) => DrivingResponse.fromJson(json.decode(str));

String drivingResponseToJson(DrivingResponse data) => json.encode(data.toJson());

class DrivingResponse {
    DrivingResponse({
        this.routes,
        this.waypoints,
        this.code,
        this.uuid,
    });

    List<Route> routes;
    List<Waypoint> waypoints;
    String code;
    String uuid;

    factory DrivingResponse.fromJson(Map<String, dynamic> json) => DrivingResponse(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
        waypoints: List<Waypoint>.from(json["waypoints"].map((x) => Waypoint.fromJson(x))),
        code: json["code"],
        uuid: json["uuid"],
    );

    Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toJson())),
        "code": code,
        "uuid": uuid,
    };
}

class Route {
    Route({
        this.weightName,
        this.weight,
        this.duration,
        this.distance,
        this.legs,
        this.geometry,
    });

    String weightName;
    double weight;
    double duration;
    double distance;
    List<Leg> legs;
    String geometry;

    factory Route.fromJson(Map<String, dynamic> json) => Route(
        weightName: json["weight_name"],
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        geometry: json["geometry"],
    );

    Map<String, dynamic> toJson() => {
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
        "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
        "geometry": geometry,
    };
}

class Leg {
    Leg({
        this.steps,
        this.admins,
        this.duration,
        this.distance,
        this.weight,
        this.summary,
    });

    List<Step> steps;
    List<Admin> admins;
    double duration;
    double distance;
    double weight;
    String summary;

    factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
        admins: List<Admin>.from(json["admins"].map((x) => Admin.fromJson(x))),
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        weight: json["weight"].toDouble(),
        summary: json["summary"],
    );

    Map<String, dynamic> toJson() => {
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
        "admins": List<dynamic>.from(admins.map((x) => x.toJson())),
        "duration": duration,
        "distance": distance,
        "weight": weight,
        "summary": summary,
    };
}

class Admin {
    Admin({
        this.iso31661Alpha3,
        this.iso31661,
    });

    String iso31661Alpha3;
    String iso31661;

    factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        iso31661Alpha3: json["iso_3166_1_alpha3"],
        iso31661: json["iso_3166_1"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1_alpha3": iso31661Alpha3,
        "iso_3166_1": iso31661,
    };
}

class Step {
    Step({
        this.maneuver,
        this.intersections,
        this.weight,
        this.duration,
        this.distance,
        this.name,
        this.drivingSide,
        this.mode,
        this.geometry,
        this.destinations,
        this.ref,
    });

    Maneuver maneuver;
    List<Intersection> intersections;
    double weight;
    double duration;
    double distance;
    String name;
    String drivingSide;
    String mode;
    String geometry;
    String destinations;
    String ref;

    factory Step.fromJson(Map<String, dynamic> json) => Step(
        maneuver: Maneuver.fromJson(json["maneuver"]),
        intersections: List<Intersection>.from(json["intersections"].map((x) => Intersection.fromJson(x))),
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        name: json["name"],
        drivingSide: json["driving_side"],
        mode: json["mode"],
        geometry: json["geometry"],
        destinations: json["destinations"] == null ? null : json["destinations"],
        ref: json["ref"] == null ? null : json["ref"],
    );

    Map<String, dynamic> toJson() => {
        "maneuver": maneuver.toJson(),
        "intersections": List<dynamic>.from(intersections.map((x) => x.toJson())),
        "weight": weight,
        "duration": duration,
        "distance": distance,
        "name": name,
        "driving_side": drivingSide,
        "mode": mode,
        "geometry": geometry,
        "destinations": destinations == null ? null : destinations,
        "ref": ref == null ? null : ref,
    };
}

class Intersection {
    Intersection({
        this.bearings,
        this.entry,
        this.mapboxStreetsV8,
        this.isUrban,
        this.adminIndex,
        this.out,
        this.geometryIndex,
        this.location,
        this.intersectionIn,
        this.turnWeight,
        this.turnDuration,
        this.duration,
        this.weight,
    });

    List<int> bearings;
    List<bool> entry;
    MapboxStreetsV8 mapboxStreetsV8;
    bool isUrban;
    int adminIndex;
    int out;
    int geometryIndex;
    List<double> location;
    int intersectionIn;
    double turnWeight;
    double turnDuration;
    double duration;
    double weight;

    factory Intersection.fromJson(Map<String, dynamic> json) => Intersection(
        bearings: List<int>.from(json["bearings"].map((x) => x)),
        entry: List<bool>.from(json["entry"].map((x) => x)),
        mapboxStreetsV8: json["mapbox_streets_v8"] == null ? null : MapboxStreetsV8.fromJson(json["mapbox_streets_v8"]),
        isUrban: json["is_urban"] == null ? null : json["is_urban"],
        adminIndex: json["admin_index"],
        out: json["out"] == null ? null : json["out"],
        geometryIndex: json["geometry_index"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
        intersectionIn: json["in"] == null ? null : json["in"],
        turnWeight: json["turn_weight"] == null ? null : json["turn_weight"].toDouble(),
        turnDuration: json["turn_duration"] == null ? null : json["turn_duration"].toDouble(),
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "bearings": List<dynamic>.from(bearings.map((x) => x)),
        "entry": List<dynamic>.from(entry.map((x) => x)),
        "mapbox_streets_v8": mapboxStreetsV8 == null ? null : mapboxStreetsV8.toJson(),
        "is_urban": isUrban == null ? null : isUrban,
        "admin_index": adminIndex,
        "out": out == null ? null : out,
        "geometry_index": geometryIndex,
        "location": List<dynamic>.from(location.map((x) => x)),
        "in": intersectionIn == null ? null : intersectionIn,
        "turn_weight": turnWeight == null ? null : turnWeight,
        "turn_duration": turnDuration == null ? null : turnDuration,
        "duration": duration == null ? null : duration,
        "weight": weight == null ? null : weight,
    };
}

class MapboxStreetsV8 {
    MapboxStreetsV8({
        this.mapboxStreetsV8Class,
    });

    Class mapboxStreetsV8Class;

    factory MapboxStreetsV8.fromJson(Map<String, dynamic> json) => MapboxStreetsV8(
        mapboxStreetsV8Class: classValues.map[json["class"]],
    );

    Map<String, dynamic> toJson() => {
        "class": classValues.reverse[mapboxStreetsV8Class],
    };
}

enum Class { TERTIARY, STREET, SECONDARY, SECONDARY_LINK, TRUNK }

final classValues = EnumValues({
    "secondary": Class.SECONDARY,
    "secondary_link": Class.SECONDARY_LINK,
    "street": Class.STREET,
    "tertiary": Class.TERTIARY,
    "trunk": Class.TRUNK
});

class Maneuver {
    Maneuver({
        this.type,
        this.instruction,
        this.bearingAfter,
        this.bearingBefore,
        this.location,
        this.modifier,
    });

    String type;
    String instruction;
    int bearingAfter;
    int bearingBefore;
    List<double> location;
    String modifier;

    factory Maneuver.fromJson(Map<String, dynamic> json) => Maneuver(
        type: json["type"],
        instruction: json["instruction"],
        bearingAfter: json["bearing_after"],
        bearingBefore: json["bearing_before"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
        modifier: json["modifier"] == null ? null : json["modifier"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "instruction": instruction,
        "bearing_after": bearingAfter,
        "bearing_before": bearingBefore,
        "location": List<dynamic>.from(location.map((x) => x)),
        "modifier": modifier == null ? null : modifier,
    };
}

class Waypoint {
    Waypoint({
        this.distance,
        this.name,
        this.location,
    });

    double distance;
    String name;
    List<double> location;

    factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"].toDouble(),
        name: json["name"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "distance": distance,
        "name": name,
        "location": List<dynamic>.from(location.map((x) => x)),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
