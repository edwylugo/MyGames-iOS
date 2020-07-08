//
//  ConsolesTableViewController.swift
//  MyGames
//
//  Created by EPR Exatron on 10/08/2018.
//  Copyright © 2018 Exatron. All rights reserved.
//

import UIKit

class ConsolesTableViewController: UITableViewController {
    
    var consolesManager = ConsolesManager.shared
   

    override func viewDidLoad() {
        super.viewDidLoad()
        loadConsoles()
        
    }

    func loadConsoles() {
        consolesManager.loadConsoles(with: context)
        tableView.reloadData()
    }
    
    @IBAction func addConsole(_ sender: UIBarButtonItem) {
        showAlert(with: nil)
    }
    
    func showAlert(with console: Console?) {
        let title = console == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " plataforma", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Nome da plataforma"
            if let name = console?.name {
                textField.text = name
            }
        }
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            let console = console ?? Console(context: self.context)
            console.name = alert.textFields?.first?.text
            do {
                try self.context.save()
                self.loadConsoles()
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor(named: "second")
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return consolesManager.consoles.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let console = consolesManager.consoles[indexPath.row]
        showAlert(with: console)
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            consolesManager.deleteConsole(index: indexPath.row, context: context)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let console = consolesManager.consoles[indexPath.row]
            cell.textLabel?.text = console.name
        return cell
    }


}



