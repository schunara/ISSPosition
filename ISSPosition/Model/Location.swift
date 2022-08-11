//
//  Location.swift
//  ISSPosition
//
//  Created by Shashi Chunara on 10/08/22.
//

import Foundation
import CoreLocation

struct Location {
    let message: String
    let timestamp: String
    var issPosition: Position?
}

struct Position {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}

extension Location {
    init(response: [String: Any]) {
        message = response["message"] as? String ?? ""
        timestamp = response["timestamp"] as? String ?? ""
        issPosition = nil
        if let posInfo = response["iss_position"] as? [String: String] {
            issPosition = Position(positionInfo: posInfo)
        }
    }
}

extension Position {
    init(positionInfo: [String: String]) {
        latitude = Double(positionInfo["latitude"] ?? "0.0") ?? 0.0
        longitude = Double(positionInfo["longitude"] ?? "0.0") ?? 0.0
    }
}
