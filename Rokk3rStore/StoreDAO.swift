//
//  StoreDAO.swift
//  Rokk3rStore
//
//  Created by luis cabarique on 11/11/15.
//  Copyright © 2015 cabarique inc. All rights reserved.
//

import Foundation
import RealmSwift

class StoreDAO: NSObject {
    
    
    func getIsDataLoaded() -> Bool{
        var isDataLoaded = false
        let defaults = NSUserDefaults.standardUserDefaults()
        if let loadedData = defaults.valueForKey("loadedData") as? Bool {
            isDataLoaded = loadedData
        }
        return isDataLoaded
    }
    
    func saveIsDataLoaded(isLoaded: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(isLoaded, forKey: "loadedData")
    }
    
    
    func saveItem(newItem: ItemModel){
        let realm = try! Realm()
        try! realm.write({ () -> Void in
            realm.add(newItem, update: true)
        })
    }
    
    
    func getItems() -> Results<ItemModel>{
        let realm = try! Realm()
        let items = realm.objects(ItemModel)
        return items
    }
    
    func getStockItems() -> Results<ItemModel>{
        let realm = try! Realm()
        let items = realm.objects(ItemModel)
        return items.filter("stock > 0")
    }

    
    
    func getShoppingCart() -> ShoppingCartModel{
        let realm = try! Realm()
        let cart = realm.objects(ShoppingCartModel)
        if cart.count > 0 {
            let cart = cart.first
            return cart!
        }else{
            let newShoppingCart = ShoppingCartModel()
            newShoppingCart.total = 0
            try! realm.write({
                realm.add(ShoppingCartModel())
            })
            return newShoppingCart
//            let carts = realm.objects(ShoppingCartModel)
//            let cart = carts.first
//            try! realm.write({
//                cart!.items.appendContentsOf(self.getItems())
//            })
//
//            return cart!
        }
    }
}
