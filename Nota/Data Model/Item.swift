//
//  Item.swift
//  Nota
//
//  Created by Matej Kolimar on 07/08/2018.
//  Copyright © 2018 Matej Kolimar. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: String = ""
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
   
}
