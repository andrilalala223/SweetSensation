//
//  RealmModel.swift
//  SweetSensation
//
//  Created by D K on 20.10.2024.
//

import Foundation
import RealmSwift


class RealmCart: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var totalValue: Double?
    @Persisted var elements = RealmSwift.List<RealmCartElement>()
}

class RealmCartElement: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String?
    @Persisted var price: Double?
    @Persisted var quantity: Int?
}
