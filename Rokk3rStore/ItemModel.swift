//
//  ItemModel.swift
//  Rokk3rStore
//
//  Created by luis cabarique on 11/11/15.
//  Copyright © 2015 cabarique inc. All rights reserved.
//

import RealmSwift

class ItemModel: Object {
    
    dynamic var uuid = NSUUID().UUIDString
    dynamic var name = ""
    dynamic var price = 0
    dynamic var stock = 0
    
    
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
