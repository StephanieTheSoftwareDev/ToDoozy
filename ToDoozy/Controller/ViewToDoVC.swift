//
//  ViewToDoVC.swift
//  ToDoozy
//
//  Created by Stephanie Fischer on 5/29/18.
//  Copyright © 2018 SUMA_. All rights reserved.
//

import UIKit
import CoreData

class ViewToDoVC: UIViewController {

    var toDo: ToDos!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = toDo.toDoTitle
        descriptionLabel.text = toDo.toDoDescription
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
