//
//  ProteinViewController.swift
//  swifty-protein
//
//  Created by Mi Hwangbo on 1/15/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit

class ProteinViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UIView!
    
    
    var protein: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "ligands", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                protein = data.components(separatedBy: .newlines)
            } catch {
                print(error)
            }
        }
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return protein.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProteinListViewCell.identifier, for: indexPath) as? ProteinListViewCell {
            cell.proteinName.text = protein[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
