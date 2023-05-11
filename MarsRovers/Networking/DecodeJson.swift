//
//  DecodeJson.swift
//  MarsRovers
//
//  Created by Steven Kirke on 12.04.2023.
//

import Foundation

class DecodeJson {
    
    func JSONDecode<T: Decodable>(data: Data, model: T, returnJSON: @escaping (T?, String?) -> Void)  {
        DispatchQueue.main.async {
            do {
                let decodedUsers = try JSONDecoder().decode(T.self, from: data)
                return returnJSON(decodedUsers, "")
            } catch let error {
                print("error JSON --- \(error.localizedDescription)")
                return returnJSON(nil, "Error decode JSON \(error)")
            }
        }
    }
}
