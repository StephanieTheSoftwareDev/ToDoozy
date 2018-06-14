//
//  MainVC.swift
//  ToDoozy
//
//  Created by Stephanie Fischer on 5/29/18.
//  Copyright © 2018 SUMA_. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    //This connects the table view to the MainVC View Controller
    @IBOutlet weak var tableView: UITableView!
    
    //Not currently used, but this is supposed to do functionality based on if the object was double tapped
    @IBAction func doubleTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        print("double tap")
    }
    //Not currently used, but this is supposed to do functionality based on if the object was single tapped
    @IBAction func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        print("single tap")
    }
    
    //MARK: - Variables
    var tableData = [ToDos]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //Sets the row height to 75 programmatically
        tableView.rowHeight = 75
        //Grabs all the items in the ToDos datamodel
        fetchAllToDos()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Prepares for the segue. Passes certain info depending on the segue identifier
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddEditSegue" {
            let nav = segue.destination as! UINavigationController
            let dest = nav.topViewController as! AddEditVC
            dest.delegate = self
            if let indexPath = sender as? IndexPath {
                let toDo = tableData[indexPath.row]
                dest.toDo = toDo
                dest.indexPath = indexPath
            }
        }
        else if segue.identifier == "ViewToDoSegue" {
            let nav = segue.destination as! UINavigationController
            let dest = nav.topViewController as! ViewToDoVC
            let indexPath = sender as! IndexPath
            dest.toDo = tableData[indexPath.row]
        }
    }
    
    func fetchAllToDos() {
        let toDoRequest: NSFetchRequest<ToDos> = ToDos.fetchRequest()
        do {
            tableData = try context.fetch(toDoRequest)
        } catch {
            print("\(error)")
        }
    }
    
//    @objc func cellTapped (recognizer:UITapGestureRecognizer) {
//        print("tapped..")
//    }

}


//MARK: - Extensions
extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TDCell", for: indexPath) as! TDCell
        let toDoozy = tableData[indexPath.row]
        cell.titleLabel.text = toDoozy.toDoTitle
        cell.descriptionLabel.text = toDoozy.toDoDescription
        return cell
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let toDo = tableData[indexPath.row]
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            context.delete(toDo)
            tableData.remove(at: indexPath.row)
            saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
//    func tapped() {
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainVC.cellTapped(recognizer:)))
//        tapGestureRecognizer.numberOfTapsRequired = 2
//        tableView.isUserInteractionEnabled = true
//        tableView.addGestureRecognizer(tapGestureRecognizer)
//    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let updateAction = UIContextualAction(style: .normal, title: "Edit"){
            (ac:UIContextualAction, view: UIView, success:(Bool) -> Void) in
            self.performSegue(withIdentifier: "AddEditSegue", sender: indexPath)
            success(true)
        }
        updateAction.backgroundColor = .purple
        return UISwipeActionsConfiguration(actions: [updateAction])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        performSegue(withIdentifier: "ViewToDoSegue", sender: indexPath)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension MainVC: AddEditVCDelegate {
    func saveButtonPressed(toDoDescription: String, toDoTitle: String, indexPath: IndexPath?) {
        let toDoozy: ToDos
        if let ip = indexPath {
            toDoozy = tableData[ip.row]
        } else {
            toDoozy = ToDos(context: context)
            tableData.append(toDoozy)
        }
        
        
        toDoozy.toDoTitle = toDoTitle
        toDoozy.toDoDescription = toDoDescription
        saveContext()
        
        if let ip = indexPath {
            tableView.reloadRows(at: [ip], with: .automatic)
        } else {
            let indexPath = IndexPath(row: tableData.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        dismiss(animated: true, completion: nil)
    }
}
