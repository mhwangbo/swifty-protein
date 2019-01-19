//
//  AtomInfo.swift
//  swifty-protein
//
//  Created by Kristine Sonu on 1/17/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import Foundation

struct Elements : Decodable {
    let elements : [AtomInfo]?
}

struct AtomInfo: Decodable {
    let name: String?
    let atomic_mass: Double?
    let boil: Double?
    let category: String?
    let density: Double?
    let discovered_by: String?
    let melt: Double?
    let number: Int?
    let period: Int?
    let phase: String?
    let summary: String?
    let symbol: String?
    let molar_heat: Double?
}

class GetAtomInfo {
    func getAtomInfo() -> Elements? {
        var data:Elements? = nil
        if let path = Bundle.main.path(forResource: "PTJSON", ofType: "json") {
            do {
                let result = try Data(contentsOf: URL(fileURLWithPath: path))
                data = try JSONDecoder().decode(Elements.self, from: result) as Elements?
                return data
            }
            catch {
                print("error reading json file")
            }
        }
        return data
    }
}
