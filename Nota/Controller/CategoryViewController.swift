//
//  CategoryViewController.swift
//  Nota
//
//  Created by Matej Kolimar on 06/08/2018.
//  Copyright © 2018 Matej Kolimar. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: - Load items from array
        loadCategories()
        tableView.rowHeight = 80.0
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet."
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            //Load items in todolistcontroler for selected category
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: - Add New Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //Alert window
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        var textfield = UITextField()
        //Alert button
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textfield.text!
            self.saveCategory(category: newCategory)
        }
        //Add textfield into alert window with placeholder
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new category"
            textfield = alertTextfield
        }
        //Add button into alert window
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func saveCategory(category: Category) {
        do{
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving into Realm database \(error)")
        }
        tableView.reloadData()
    }
    
    fileprivate func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(category)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
}


