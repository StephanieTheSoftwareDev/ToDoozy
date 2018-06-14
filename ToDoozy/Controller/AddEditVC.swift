//
//  AddEditVC.swift
//  ToDoozy
//
//  Created by Stephanie Fischer on 5/29/18.
//  Copyright © 2018 SUMA_. All rights reserved.
//

import UIKit
import CoreData

protocol AddEditVCDelegate {
    func saveButtonPressed(toDoDescription: String, toDoTitle: String, indexPath: IndexPath?)
}


class AddEditVC: UIViewController {

    var delegate: AddEditVCDelegate!
    var toDo: ToDos?
    var indexPath: IndexPath?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let toDoTitle = titleField.text!
        let toDoDescription = descriptionField.text!
        delegate.saveButtonPressed(toDoDescription: toDoDescription, toDoTitle: toDoTitle, indexPath: indexPath)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let toDoozy = toDo {
            titleField.text = toDoozy.toDoTitle
            descriptionField.text = toDoozy.toDoDescription
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
