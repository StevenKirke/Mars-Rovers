//
//  CalculateSolModel.swift
//  MarsRovers
//
//  Created by Steven Kirke on 25.04.2023.
//

import Foundation

struct Filter {
    var roverName: String
    var sol: Int
    var tempSol: Int
    var camera: String
}

class CalculateSolModel: ObservableObject {
    
    
    @Published var countPicker: Int = 0
    @Published var breakSol: [Int] = []
    @Published var tempSol = 0
    @Published var filterRover: Filter
    
    init() {
        filterRover =  Filter(roverName: "", sol: 0, tempSol: 0, camera: "")
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
        self.countPicker = count
        print("Count - \(count)")
        breakNumberSol(countSol)
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


//private func initFilter() {
//        guard let rover = self.rovers.rovers.first else {
//            return
//        }
//        guard let firstCamera = rover.cameras.first?.name else {
//            return
//        }
//        calculateSol.filterRover.roverName = rover.name.lowercased()
//        calculateSol.filterRover.sol = rover.maxSol
//        calculateSol.filterRover.camera = firstCamera
//}
