//
//  StorageManager.swift
//  SweetSensation
//
//  Created by D K on 20.10.2024.
//

import Foundation
import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    @ObservedResults(RealmCart.self) var carts
    
    
    func addToCart(item: SweetProduct) {
        let cart = realm.objects(RealmCart.self).first ?? RealmCart()
        
        if cart.realm == nil {
            try! realm.write {
                realm.add(cart)
            }
        }
        
        if let existingElement = cart.elements.first(where: { $0.name == item.name }) {
            do {
                try realm.write {
                    existingElement.quantity = (existingElement.quantity ?? 0) + 1
                }
            } catch {
                print("Error updating count")
            }
        } else {
            let newElement = RealmCartElement()
            newElement.name = item.name
            newElement.price = Double(item.price)
            newElement.quantity = 1
            
            do {
                try realm.write {
                    cart.elements.append(newElement)
                }
            } catch {
                print("Error adding new element to cart")
            }
            
            
        }
        
        updateOrderTotalValue(cart: cart)
    }
    
    func updateOrderTotalValue(cart: RealmCart) {
        var total: Double = 0
        
        for element in cart.elements {
            let elementValue = element.price ?? 0
            let elementQuantity = Double(element.quantity ?? 0)
            total += elementValue * elementQuantity
        }
        do {
            try realm.write {
                cart.totalValue = total
            }
        } catch {
            print("Error updating")
        }
        
    }
    
    func removeElement(element: RealmCartElement) {
        let cart = realm.objects(RealmCart.self).first ?? RealmCart()
        
        if let itemToUpdate = realm.object(ofType: RealmCartElement.self, forPrimaryKey: element.id), let quantity = itemToUpdate.quantity {
            let newQuantity = quantity - 1
            do {
                try realm.write {
                    itemToUpdate.quantity = newQuantity
                }
                if newQuantity <= 0 {
                    deleteFoodItem(element: element)
                }
                updateOrderTotalValue(cart: cart)
                
            } catch {
                
            }
        } else {
            print("Элемент с id не найден в базе данных.")
        }
    }
    
    func deleteFoodItem(element: RealmCartElement) {
        
        do {
            try realm.write {
                realm.delete(element)
            }
        } catch {
            print("Error deleting")
        }
    }
    
    func deleteCart() {
        let allCarts = realm.objects(RealmCart.self)
        let allOrderElements = realm.objects(RealmCartElement.self)
        
        do {
            try realm.write {
                realm.delete(allCarts)
                realm.delete(allOrderElements)
            }
        } catch {
            print("Error deleting cart")
        }
    }
    
    func sumQuantitiesInFirstCart() -> Int {
        guard let firstCart = realm.objects(RealmCart.self).first else {
            print("No RealmCart found")
            return 0
        }

        let totalQuantity = firstCart.elements.reduce(0) { (result, element) in
            return result + (element.quantity ?? 0)
        }

        return totalQuantity
    }
}
