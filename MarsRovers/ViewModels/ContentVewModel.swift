//
//  ContentVewModel.swift
//  MarsRovers
//
//  Created by Steven Kirke on 12.04.2023.
//

import SwiftUI

struct ImagesRovers {
    let bigImage: Image
    let littleImage: Image
}

struct Filter {
    var roverName: String
    var sol: Int
    var camera: String
}

class ContentVewModel: ObservableObject {
    

    var apiKey: String = "PN6lrB0EfMLX8Gfc8JVyOyOmL56BLLaxZg1A5aAZ"
    var url: String = "https://api.nasa.gov/mars-photos/api/v1/rovers"
    
    var requestData: RequestData = RequestData()
    
    @Published var rovers: Rovers = Rovers(rovers: [])
    @Published var arrayRovers: [ImagesRovers] = []
    
    
    @Published var filter: Filter = Filter(roverName: "", sol: -1, camera: "")
    
    @Published var currentIndex: Int = 0 {
        willSet {
            filter.roverName = rovers.rovers[newValue].name
            filter.sol = rovers.rovers[newValue].maxSol
            guard let camera = rovers.rovers[newValue].cameras.first else {
                return
            }
            filter.camera = camera.name
        }
    }
    
    init() {
        getMock()
    }
    
    
    
    
    
    
    func assamblyURL(url: String, key: String, value: String) -> URLRequest? {
        guard var currentUrl = URL(string: url) else {
            print("Error convert URL")
            return nil
        }
        currentUrl.append(queryItems: [URLQueryItem.init(name: key, value: value)])
        var request = URLRequest(url: currentUrl)
        request.httpMethod = "GET"
        return request
    }
    
    func getData() {
        let request = assamblyURL(url: url, key: "api_key", value: apiKey)
        guard let currentRequest = request else {
            return
        }

        self.requestData.getData(request: currentRequest, model: rovers) { [weak self] data, error in
            if error != "" {
                print("errors \(String(describing: error))")
            }
            guard let currentData = data else {
                return
            }
            guard let self = self else {
                return
            }
            self.rovers = currentData
            if !self.rovers.rovers.isEmpty {
                self.addImage()

            }
        }
    }
    
    func getMock() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.requestData.getDataMock(mock: mockRovers, model: self.rovers) { [weak self] data, error in
                if error != "" {
                    print("errors \(String(describing: error))")
                }
                guard let currentData = data else {
                    return
                }
                guard let self = self else {
                    return
                }
                self.rovers = currentData
                self.addImage()
                self.initFilter()
            }
        }
    }
    
    private func addImage() {
        if !rovers.rovers.isEmpty {
            for (_, elem) in rovers.rovers.enumerated() {
                for name in RoverImages.allCases {
                    if (elem.name.lowercased() == name.title.lowercased()) {
                        let tempImage: ImagesRovers = ImagesRovers(bigImage: name.bigImage, littleImage: name.littleImage)
                        arrayRovers.append(tempImage)
                    }
                }
            }
        }
    }
    
    private func initFilter() {
        guard let rover = self.rovers.rovers.first else {
            return
        }
        guard let firstCamera = rover.cameras.first?.name else {
            return
        }
        self.filter.roverName = rover.name
        self.filter.sol = rover.maxSol
        self.filter.camera = firstCamera
    }

}
