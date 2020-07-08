//
//  ViewController+CoreData.swift
//  MyGames
//
//  Created by EPR Exatron on 10/08/2018.
//  Copyright © 2018 Exatron. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController { //framework
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
