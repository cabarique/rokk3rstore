//
//  ViewController.swift
//  Rokk3rStore
//
//  Created by luis cabarique on 11/11/15.
//  Copyright © 2015 cabarique inc. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var storeDAO: StoreDAO?
    var store: ShoppingCartModel?
    var items: Results<ItemModel>?

    @IBOutlet weak var cart: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeDAO = StoreDAO()
        store = storeDAO?.getShoppingCart()
        items = storeDAO?.getStockItems()
        self.cart.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "getCart"))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as UITableViewCell
        let item = items![indexPath.row]
        print(items!.count)
        if item.stock > 0 {
            cell.textLabel?.text = item.name as String
            cell.detailTextLabel?.text = "$\(item.price) QTY: \(item.stock)" as String
            let plusImageView = UIImageView(image: UIImage(named: "plus"))
            plusImageView.frame.size.width = 30
            plusImageView.frame.size.height = 30
            cell.accessoryView = plusImageView
        }else{
            cell.textLabel?.text = item.name as String
            cell.detailTextLabel?.text = "$\(item.price) Sold out" as String
        }
        

        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = items![indexPath.row]
        tableView.beginUpdates()
        if item.stock > 0 {
            let realm = try! Realm()
            try! realm.write({ () -> Void in
                item.stock -= 1
            })
            
            if item.stock == 0 {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                items = storeDAO?.getStockItems()
            }
            
            addItemToCart(item)
        }
        
        tableView.endUpdates()
        tableView.reloadData()
    }
    
    func addItemToCart(addedItem: ItemModel){
        let realm = try! Realm()
        try! realm.write({ () -> Void in
            self.store?.items.append(addedItem)
        })
    }
    
    func getCart(){
        let cartView:CartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CartView") as! CartViewController
        self.presentViewController(cartView, animated: true, completion: nil)
    }


}

