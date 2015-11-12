//
//  CartViewController.swift
//  Rokk3rStore
//
//  Created by luis cabarique on 11/11/15.
//  Copyright © 2015 cabarique inc. All rights reserved.
//

import UIKit
import RealmSwift

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var storeDAO: StoreDAO?
    var store: ShoppingCartModel?

    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var total: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeDAO = StoreDAO()
        store = storeDAO?.getShoppingCart()
        total.text = "total $\(store!.total)"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store!.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCartCell", forIndexPath: indexPath) as UITableViewCell
        let item = store!.items[indexPath.row]
        cell.textLabel?.text = item.name as String
        cell.detailTextLabel?.text = "$\(item.price) QTY: \(item.onSale)" as String
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            tableView.beginUpdates()
            let item = store?.items[indexPath.row]
            let realm = try! Realm()
            try! realm.write({ () -> Void in
                item!.stock += item!.onSale
                item!.onSale = 0
                self.store?.items.removeAtIndex(indexPath.row)
            })
            
            store = storeDAO?.getShoppingCart()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
        }
    }
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
