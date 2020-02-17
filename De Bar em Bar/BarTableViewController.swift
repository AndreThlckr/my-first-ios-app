//
//  BarTableViewController.swift
//  De Bar em Bar
//
//  Created by Jonathan on 04/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import os.log
import MapKit

class BarTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var bares = [Bar]()
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? BarViewController, let bar = sourceViewController.bar {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //Update an existing bar
                bares[selectedIndexPath.row] = bar
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                //Add a new bar to the list
                let newIndexPath = IndexPath(row: bares.count, section: 0)
                
                bares.append(bar)
                
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveBares()
        }
    }
    
    @IBAction func sort(_ sender: UIBarButtonItem) {
        
        var isSorted = true
        
        for i in 0 ..< (bares.count - 1) {
            if bares[i].rating < bares[i+1].rating {
                isSorted = false
                break
            }
        }
        
        if(isSorted) {
            bares.sort(by:{ $0.rating < $1.rating })
            sender.title = "Sort ☝️"
        } else {
            bares.sort(by:{ $0.rating > $1.rating })
            sender.title = "Sort 👇"
        }
        
        tableView.reloadData()
    }
    
    
    //MARK: Private Methods
    
    private func loadSampleBares(){
        let photo1 = UIImage(named: "bar1")
        let photo2 = UIImage(named: "bar2")
        let photo3 = UIImage(named: "bar3")
        
        guard let bar1 = Bar(name: "Barzinho da esquina", address: "Blumenau", phone: "3382 9038", photo: photo1, rating: 3, coordinate: CLLocationCoordinate2D(latitude: -26.9168374, longitude: -49.0712756)) else {
            fatalError("Unable to instantiate bar1")
        }
        
        guard let bar2 = Bar(name: "Bar top", address: "Timbó", phone: "3382 9038", photo: photo2, rating: 4, coordinate: CLLocationCoordinate2D(latitude: -26.917876, longitude: -49.0709269)) else {
            fatalError("Unable to instantiate bar2")
        }
        
        guard let bar3 = Bar(name: "TÁ CHOVENDO HAMBURGUER", address: "Londres", phone: "3382 9038", photo: photo3, rating: 1, coordinate: CLLocationCoordinate2D(latitude: -26.9164362, longitude: -49.0718351)) else {
            fatalError("Unable to instantiate bar3")
        }
        
        bares += [bar1, bar2, bar3]
    }
    
    private func saveBares() {
        let isSucessfulSave = NSKeyedArchiver.archiveRootObject(bares, toFile: Bar.ArchiveURL.path)
        
        if isSucessfulSave {
            os_log("Bares salvos com sucesso.", log: OSLog.default, type: .debug)
        } else {
            os_log("Tentativa de salvar bares falhou...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadBares() -> [Bar]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Bar.ArchiveURL.path) as? [Bar]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem

        if let savedBares = loadBares() {
            bares += savedBares
        } else {
            loadSampleBares()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bares.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BarTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BarTableViewCell else {
            fatalError("The dequeued cell is not an instance of BarTableViewCell.")
        }

        let bar = bares[indexPath.row]
        
        cell.nameLabel.text = bar.name
        cell.photoImageView.image = bar.photo
        cell.ratingBar.rating = bar.rating

        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bares.remove(at: indexPath.row)
            saveBares()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new meal.", log:OSLog.default, type: .debug)
        case "ShowDetail":
            guard let barDetailViewController = segue.destination as? BarViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedBarCell = sender as? BarTableViewCell else {
                fatalError("Unexpected sender: \(sender!)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedBarCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedBar = bares[indexPath.row]
            
            barDetailViewController.bar = selectedBar
        default:
            fatalError("Unexpected Segue Identifier: \(segue.identifier!)")
        }
    }
    
}
