//
//  CalculateSolModel.swift
//  MarsRovers
//
//  Created by Steven Kirke on 25.04.2023.
//

import Foundation

struct CurrentRover {
    var roverName: String
    var sol: Int
    var tempSol: Int
    var camera: String
}

class CalculateRoverSettingModel: ObservableObject {
    
    @Published var countPickers: Int = 0
    @Published var numberSolsInWheel: [Int] = [] {
        willSet {
           
        } didSet {
            self.removingExtraZeros()
        }
    }
    
    @Published var tempSol = 0
    @Published var currentRover: CurrentRover
    @Published var currentSol: String = ""
    
    init() {
        currentRover =  CurrentRover(roverName: "", sol: 0, tempSol: 0, camera: "")
    }
    
    
    func breakdownWheel(_ countSol: Int) {
        var count = 0
        var num = countSol
        if (num == 0) {
            return
        }
        while (num > 0) {
            num = num / 10
            count += 1
        }
        self.countPickers = count
        breakNumberSol(countSol)
    }
    
    
    private func breakNumberSol(_ currentSol: Int) {
        self.numberSolsInWheel = []
        let currentString = String(currentSol)
        for (_, element) in currentString.enumerated() {
            if let number = Int(String(element)) {
                numberSolsInWheel.append(number)
            }
        }
    }
    
    
    func saveCurrentSol(maxSol: Int) -> Int {
        var myString = ""
        _ = self.numberSolsInWheel.map {
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
    
    func removingExtraZeros() {
        var tempString = ""
        _ = self.numberSolsInWheel.map {
            tempString = tempString + "\($0)"
        }
        let trim: String? = tempString.replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
        
        guard let tempTrim = trim else {
            return self.currentSol = ""
        }
        self.currentSol = tempTrim
    }
}



