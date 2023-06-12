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



@available(iOS 16.0, *)
class ContentVewModel: ObservableObject {
    
    var requestData: RequestData = RequestData()
    
    @Published var isActive: Bool = false
    @Published var isSetting: Bool = false
    @Published var rovers: Rovers = Rovers(rovers: [])
    @Published var arrayRovers: [ImagesRovers] = []
    @Published var title: String = ""
    
    @Published var currentIndex: Int = 0 {
        didSet {
            title = isSetting ? "Settings" : rovers.rovers[currentIndex].name
        }
    }
    
    init() {
       getData()
        //getMock()
    }
    
    
    private func assamblyURL(url: String, key: String, value: String) -> URLRequest? {
        guard var currentUrl = URL(string: url) else {
            print("Error convert URL")
            return nil
        }
        currentUrl.append(queryItems: [URLQueryItem.init(name: key, value: value)])
        var request = URLRequest(url: currentUrl)
        request.httpMethod = "GET"
        return request
    }
    
    
    private func getData() {
        let request = assamblyURL(url: URLS.mainUrl.url, key: "api_key", value: URLS.apiKey.url)
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
            
            guard let name = currentData.rovers.first?.name else {
                return
            }
            self.title = name
            self.isActive = true
            
            if !self.rovers.rovers.isEmpty {
                self.addImage()
            }
        }
    }
    
    
    private func getMock() {
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
                guard let name = currentData.rovers.first?.name else {
                    return
                }
                self.title = name
                self.addImage()
            }
        }
    }
    
    
    private func addImage() {
        if !rovers.rovers.isEmpty {
            for (_, elem) in rovers.rovers.enumerated() {
                for name in RoverImages.allCases {
                    if (elem.name.lowercased() == name.title.lowercased()) {
                        arrayRovers.append( ImagesRovers(bigImage: name.bigImage, littleImage: name.littleImage))
                    }
                }
            }
        }
    }
}
