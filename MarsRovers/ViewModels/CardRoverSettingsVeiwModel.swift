//
//  CardRoverSettingsVeiwModel.swift
//  MarsRovers
//
//  Created by Steven Kirke on 15.04.2023.
//

import Foundation


class CardRoverSettingsVeiwModel: ObservableObject {
    
    @Published var countForPicker: Int = 0
    @Published var breakSol: [Int] = [0]
    
    func countNumbers(_ sol: Int) {
         var count = 0
         var num = sol
         if (num == 0) {
             return
         }
         while (num > 0) {
             num = num / 10
             count += 1
         }
        self.countForPicker = count
     }
    
    func breakNumberSol(_ sol: Int) {
        self.breakSol = []
        let currentString = String(sol)
        for (_, element) in currentString.enumerated() {
            if let number = Int(String(element)) {
                breakSol.append(number)
            }
        }
    }
    
}
