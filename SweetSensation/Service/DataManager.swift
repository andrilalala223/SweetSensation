//
//  DataManager.swift
//  SweetSensation
//
//  Created by D K on 20.10.2024.
//

import SwiftUI


class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func parseJSON(filename: String) -> [SweetProduct]? {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                
                let decoder = JSONDecoder()
                let questions = try decoder.decode([SweetProduct].self, from: data)
                
                return questions
            } catch {
                print("Ошибка парсинга JSON: \(error)")
            }
        } else {
            print("Файл не найден")
        }
        return nil
    }
    
    func filterSweetProductsByType(products: [SweetProduct], type: String) -> [SweetProduct] {
        if type != "ALL" {
            return products.filter { $0.type == type }
        } else {
            return products
        }
    }
}
