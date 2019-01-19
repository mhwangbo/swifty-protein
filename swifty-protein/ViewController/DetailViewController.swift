//
//  DetailViewController.swift
//  swifty-protein
//
//  Created by Kristine Sonu on 1/15/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit
import SceneKit

class DetailViewController: UIViewController {
    
    


    @IBOutlet weak var atomName: UILabel!
    @IBOutlet weak var atomMass: UILabel!
    @IBOutlet weak var atomBoil: UILabel!
    @IBOutlet weak var atomNumber: UILabel!
    @IBOutlet weak var ProteinView: SCNView!
    let activityIndicator = ActivityIndicator.shared
    var name : String?
    var pdb_file : String?
    var http: String = "https://files.rcsb.org/ligands/view/"
    var pdb: String = "_ideal.pdb"
    var atom: Elements?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = name
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "menlo-Bold", size: 20)!]
        getproteinInfo(pName: name!)
        ProteinView.allowsCameraControl = true
        ProteinView.autoenablesDefaultLighting = true
        sceneSetup()
        ProteinView.layer.cornerRadius = 10
        atomName.layer.cornerRadius = 5
        atomMass.layer.cornerRadius = 5
        atomBoil.layer.cornerRadius = 5
        atomNumber.layer.cornerRadius = 5
        ProteinView.layer.masksToBounds = true
        atomName.layer.masksToBounds = true
        atomMass.layer.masksToBounds = true
        atomBoil.layer.masksToBounds = true
        atomNumber.layer.masksToBounds = true
        atom = GetAtomInfo().getAtomInfo()
        atomName.isHidden = true
        atomMass.isHidden = true
        atomBoil.isHidden = true
        atomNumber.isHidden = true
        //show atom information
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.didTap(_:)))
        self.view.addGestureRecognizer(tapGR)
        
        //share button
        let addButton = UIBarButtonItem(title: "share", style: .plain, target: self, action: #selector(shareButton))
        self.navigationItem.rightBarButtonItem = addButton
        activityIndicator.animateActivity(title: "Loading...", view: self.view, navigationItem: navigationItem)

        
    }

    func getproteinInfo(pName: String) {
        let url = URL(string: http + pName + pdb)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if error == nil {
                let urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                var lines:[String] = []
                let string = urlContent! as String
                string.enumerateLines { (line, _) in
                    lines.append(line)
                }

                self.activityIndicator.stopAnimating(navigationItem: self.navigationItem)
                self.ProteinView!.scene = ProteinSCN(pdb_file: lines)
            }
            else {
                self.performSegue(withIdentifier: "warning", sender: self)
                print("error")
            }
        })
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        task.resume()
    }
    
    func sceneSetup() {
        ProteinView.backgroundColor = UIColor.darkGray
        ProteinView.autoenablesDefaultLighting = true
        ProteinView.allowsCameraControl = true
    }
    @objc func didTap(_ tapGR: UITapGestureRecognizer) {
        let v = self.ProteinView as SCNView
        let tapPoint = tapGR.location(in: v)
        let hits = self.ProteinView!.hitTest(tapPoint, options: nil)
        
        if let tappedNode = hits.first?.node {
            atomName.isHidden = false
            if tappedNode.name?.isEmpty != nil {
                for atom in (self.atom?.elements)! {
                    if (atom.symbol?.lowercased()) == tappedNode.name?.lowercased() {
                        atomName.isHidden = false
                        atomMass.isHidden = false
                        atomBoil.isHidden = false
                        atomNumber.isHidden = false
                        atomName.text = "  Selected Element: " + tappedNode.name!
                        atomMass.text = "  Atomic Mass: " + (atom.atomic_mass == nil ? "no info" : String(format: "%.3f", atom.atomic_mass!))
                        atomBoil.text = "  Boiling Point: " + (atom.boil == nil ? "no info" : String(format: "%.3f", atom.boil!))
                        atomNumber.text = "  Atomic Number: " + String(format: "%d", atom.number!)
                    }
                }
            }
            else {
                atomName.isHidden = true
            }

        }
    }
    @objc func shareButton(_ sender: UINavigationItem) {
            let image = ProteinView.snapshot()
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            self.present(activityVC, animated: true, completion: nil)
        }
    }

