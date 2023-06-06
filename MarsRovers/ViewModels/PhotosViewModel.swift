//
//  PhotosViewModel.swift
//  MarsRovers
//
//  Created by Steven Kirke on 27.04.2023.
//

import Foundation


class PhotosViewModel: ObservableObject {
    var requestData: RequestData = RequestData()
    
    @Published var photos: Photos = Photos(photos: [])
    
    
    func assamblyURL(rover: Filter)  -> URLRequest?  {
        //let url = "https://api.nasa.gov/mars-photos/api/v1/rovers/" + rover.roverName + "/photos/"
        let url = URLS.assambly(rover.roverName).url
        guard var currentUrl = URL(string: url) else {
            print("Error convert URL")
            return nil
        }

        currentUrl.append(queryItems: [URLQueryItem.init(name: "api_key", value: URLS.apiKey.url)])
        currentUrl.append(queryItems: [URLQueryItem.init(name: "sol", value: "\(rover.tempSol)")])
        if rover.camera != "" {
            currentUrl.append(queryItems: [URLQueryItem.init(name: "camera", value: rover.camera)])
        }
        var request = URLRequest(url: currentUrl)
        request.httpMethod = "GET"
        return request
    }
    
    
    func getPhoto(rover: Filter) {
        let request = assamblyURL(rover: rover)
        guard let currentRequest = request else {
            return
        }
        print("currentRequest - \(currentRequest)")
        self.requestData.getData(request: currentRequest, model: photos) { [weak self] data, error in
            if error != "" {
                print("errors \(String(describing: error))")
            }
            guard let currentData = data else {
                return
            }
            guard let self = self else {
                return
            }
            self.photos = currentData
            print("\(self.photos.photos.count)")

//            for (_, elem) in self.photos.photos.enumerated() {
//                print("\(elem.imgSrc)")
//            }
            
//            guard let name = currentData.rovers.first?.name else {
//                return
//
//            }
//            self.title = name
//
//            if !self.rovers.rovers.isEmpty {
//                self.addImage()
//            }
        }
    }
}
        
        /*
         let queryItems = [
         URLQueryItem(name: "api_key", value: apiKey),
         URLQueryItem(name: "sol", value: "\(rover.tempSol)"),
         URLQueryItem(name: "camera", value: rover.camera)
         ]
         let urlComps = URLComponents(string: url)
         guard var urlComp = urlComps else {
         return
         }
         urlComp.queryItems = queryItems
         
         guard let urls = urlComp.url else {
         print("Error convert URL")
         return
         }
         print(urls)
         //        var rover: String = "\(rover.roverName)"
         //        var sol: String = "sol" + "\(rover.tempSol)"
         //        var camera: String = "camera" + "\(rover)"
         //        var assambly: String = url + rover + "/photos/" +
         
         // print(assambly)
         */
    //}
    //
    //    func getData() {
    //    }
    
    /*
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
     */

