//
//  ContentVewModel.swift
//  MarsRovers
//
//  Created by Steven Kirke on 12.04.2023.
//

import SwiftUI

class ContentVewModel: ObservableObject {
    
    
    var requestData: RequestData = RequestData()
    
    @Published var isStart: Bool = false
    @Published var rovers: modelsRovers = modelsRovers(rovers: [])
    @Published var roverIcons: [RoverIcons] = []
    @Published var title: String = "Loading..."
    
    @Published var currentIndex: Int = 0 {
        didSet {
            title = isStart ? rovers.rovers[currentIndex].name : "Settings"
        }
    }
    
    init() {
        getMock()
    }
    
    private func getMock() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
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
                
                if !self.rovers.rovers.isEmpty {
                    self.getIconsForRovers(startModule: {
                        self.title = name
                        self.isStart = true
                    })
                }
            }
        }
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
            
            if !self.rovers.rovers.isEmpty {
                self.getIconsForRovers(startModule: {
                    self.title = name
                    self.isStart = true
                })
            }
        }
    }
    
    
    private func getIconsForRovers(startModule: () -> Void) {
        if !rovers.rovers.isEmpty {
            for (_, elem) in rovers.rovers.enumerated() {
                for name in RoverImages.allCases {
                    if (elem.name.lowercased() == name.title.lowercased()) {
                        roverIcons.append(RoverIcons(image: name.image, icon: name.icon))
                    }
                }
            }
            return startModule()
        }
    }
}


 
 
 

