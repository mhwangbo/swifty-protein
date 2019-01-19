//
//  ProteinListViewController.swift
//  swifty-protein
//
//  Created by Mi Hwangbo on 1/15/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

    import UIKit

    class ProteinViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
        //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        @IBOutlet weak var SearchBar: UISearchBar!
        @IBOutlet weak var tableView: UITableView!
        
        
        var protein: [String] = []
        var searchProtein = [String]()
        var searching = false
        var myindex = 0
        var name: String = ""

        
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
            tableView.delegate = self
            
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if searching {
                return searchProtein.count
            }
            else {
                return protein.count
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProteinListViewCell.identifier, for: indexPath) as? ProteinListViewCell {
                if searching {
                    cell.textLabel?.text = searchProtein[indexPath.row]
                }
                else {
                    cell.textLabel?.text = protein[indexPath.row]
                }
                return cell
            }
            return UITableViewCell()
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            activityIndicatorLoad()
            if searching {
                self.name = searchProtein[indexPath.row]
            }
            else {
                self.name = protein[indexPath.row]
            }
            self.performSegue(withIdentifier: "segue", sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let proteinVC = segue.destination as! DetailViewController
            proteinVC.name = self.name
        }
//        func activityIndicatorLoad() {
//            activityIndicator.startAnimating()
////            activityIndicator.center = self.view.center
//            activityIndicator.hidesWhenStopped = false
//            activityIndicator.style = UIActivityIndicatorView.Style.gray
//            view.addSubview(activityIndicator)
//        }
    }


extension ProteinViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchProtein = protein.filter({$0.prefix(searchText.count).lowercased() == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
}
