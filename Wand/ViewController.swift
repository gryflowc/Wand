//
//  ViewController.swift
//  Wand
//
//  Created by Ella Gryf-Lowczowska on 20/06/2019.
//  Copyright © 2019 Ella Gryf-Lowczowska. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var spells = Spells()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        spells.getSpells {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSpellDetail" {
            let destination = segue.destination as! SpellDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.spellData.name = spells.spellData[selectedIndexPath.row].name
            destination.spellData.apiURL = spells.spellData[selectedIndexPath.row].url
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spells.spellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = spells.spellData[indexPath.row].name
        print("Dequeung the table view cell for indexPath.row = \(indexPath.row) where the cell contains item \(spells.spellData[indexPath.row].name).")
        if indexPath.row+1 == spells.spellData.count && spells.apiURL != "" {
            spells.getSpells {
                self.tableView.reloadData()
            }
        }
        return cell
    }
    
    
    
}


