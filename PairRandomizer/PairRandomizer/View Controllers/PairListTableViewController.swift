//
//  PairListTableViewController.swift
//  PairRandomizer
//
//  Created by Jeremy Taylor on 12/18/20.
//

import UIKit

class PairListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        PersonController.sharedInstance.fetchPeople()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        presentAddPersonAlert()
    }
    @IBAction func randomizeButtonTapped(_ sender: UIBarButtonItem) {
        PersonController.sharedInstance.randomize()
        
        tableView.reloadData()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if PersonController.sharedInstance.people.count % 2 == 0 {
            return PersonController.sharedInstance.people.count / 2
        } else {
            return (PersonController.sharedInstance.people.count + 1) / 2
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.sharedInstance.pairs[section].count
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \([section + 1][0])"
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)

        let person = PersonController.sharedInstance.pairs[indexPath.section][indexPath.row]
        cell.textLabel?.text = person.name

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = PersonController.sharedInstance.people[indexPath.row]
            PersonController.sharedInstance.deletePerson(person: personToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Methods
    
    func presentAddPersonAlert() {
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Full Name"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alertController.textFields?.first?.text,
                  !name.isEmpty else { return }
            print("Added: \(name)")
            PersonController.sharedInstance.addPerson(name: name)
            PersonController.sharedInstance.fetchPeople()
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }

} //End of class
