//
//  Photos.swift
//  MarsRovers
//
//  Created by Steven Kirke on 27.04.2023.
//

import Foundation

struct Photos: Codable {
    let photos: [Photo]
}


struct Photo: Codable {
    let id, sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: RoverDiscription

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}


//struct Camera: Codable {
//    let id: Int
//    let name: String
//    let roverID: Int
//    let fullName: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case roverID = "rover_id"
//        case fullName = "full_name"
//    }
//}


struct RoverDiscription: Codable {
    let id: Int
    let name, landingDate, launchDate, status: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
    }
}
