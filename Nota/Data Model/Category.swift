//
//  Category.swift
//  Nota
//
//  Created by Matej Kolimar on 07/08/2018.
//  Copyright © 2018 Matej Kolimar. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
