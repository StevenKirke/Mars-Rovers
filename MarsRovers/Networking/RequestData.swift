//
//  RequestData.swift
//  MarsRovers
//
//  Created by Steven Kirke on 12.04.2023.
//

import Foundation

class RequestData {
    
    var responseData: ResponseData = ResponseData()
    
    
    func getData<T: Decodable>(request: URLRequest, model: T, returnData: @escaping (T?, String?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                return
            }
            guard let data = data else {
                return
            }
            guard let self = self else {
                return
            }
            self.responseData.convertData(data: data, models: model) { (data, error)  in
                guard (error?.description) != nil else {
                    return returnData(nil, error)
                }
                guard let data = data else {
                    return
                }
                return returnData(data, "")
            }
        }
        dataTask.resume()
    }
    
    func getDataMock<T: Decodable>(mock: String, model: T, returnData: @escaping (T?, String?) -> Void) {
        let data = Data(mock.utf8)
        self.responseData.convertData(data: data, models: model) { data, error in
            guard (error?.description) != nil else {
                return returnData(nil, error)
            }
            guard let data = data else {
                return
            }
            return returnData(data, "")
        }
    }
}
