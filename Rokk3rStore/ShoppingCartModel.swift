//
//  ShoppingCartModel.swift
//  Rokk3rStore
//
//  Created by luis cabarique on 11/11/15.
//  Copyright © 2015 cabarique inc. All rights reserved.
//

import RealmSwift

class ShoppingCartModel: Object {
    dynamic var uuid = NSUUID().UUIDString
    dynamic var total = 0
    var items = List<ItemModel>()
 
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}