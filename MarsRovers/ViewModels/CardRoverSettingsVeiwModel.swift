//
//  CardRoverSettingsVeiwModel.swift
//  MarsRovers
//
//  Created by Steven Kirke on 15.04.2023.
//

import Foundation


class CardRoverSettingsVeiwModel: ObservableObject {
    
    @Published var countForPicker: Int = 0
    @Published var breakSol: [Int] = []
    @Published var tempSol = 0
        
    
    func calculateSol(_ filter: Filter) {
        var count = 0
        var num = filter.sol
        if (num == 0) {
            return
        }
        while (num > 0) {
            num = num / 10
            count += 1
        }
        self.countForPicker = count
        breakNumberSol(filter.sol)
    }
    
    private func breakNumberSol(_ currentSol: Int) {
        self.breakSol = []
        let currentString = String(currentSol)
        for (_, element) in currentString.enumerated() {
            if let number = Int(String(element)) {
                breakSol.append(number)
            }
        }
    }
    
    
    
    func saveCurrentSol(maxSol: Int) -> Int {
        var myString = ""
        _ = self.breakSol.map {
            myString = myString + "\($0)"
        }
        let currentNumber = Int(myString)
        guard let currentSol = currentNumber else {
            return maxSol
        }
        if currentSol > maxSol {
            return maxSol
        }
        return currentSol
    }
    

}
