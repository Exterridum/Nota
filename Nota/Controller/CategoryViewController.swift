//
//  CategoryViewController.swift
//  Nota
//
//  Created by Matej Kolimar on 06/08/2018.
//  Copyright © 2018 Matej Kolimar. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: - Load items from array
        loadCategories()
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: - Send user to Items sections when click on Category, save context
//        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            //This change content in Todocontroller... to new and this triggers didSet and cause loadItems
            destinationVC.selectedCategory = categoryArray[indexPath.row]
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
            let newCategory = Category(context: self.context)
            newCategory.name = textfield.text!
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
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
    
    fileprivate func saveCategories() {
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    fileprivate func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
            
        } catch  {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
}
