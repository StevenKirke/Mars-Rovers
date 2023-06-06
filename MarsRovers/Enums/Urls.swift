//
//  Urls.swift
//  MarsRovers
//
//  Created by Steven Kirke on 05.06.2023.
//

import Foundation

enum URLS {
    case apiKey
    case mainUrl
    case assambly(_ roverName: String)
    
    var url: String {
        switch self {
            case .apiKey:
                return "PN6lrB0EfMLX8Gfc8JVyOyOmL56BLLaxZg1A5aAZ"
            case .mainUrl:
                return "https://api.nasa.gov/mars-photos/api/v1/rovers"
            case .assambly(let roverName):
                return "https://api.nasa.gov/mars-photos/api/v1/rovers/" + roverName + "/photos/"
        }
    }
}
