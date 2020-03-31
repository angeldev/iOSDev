//
//  ViewController.swift
//  AdministrationExam
//
//  Created by Angel David Macho Esperilla on 29/03/2020.
//  Copyright © 2020 TuLotero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    
    /// Administration service
    let administrationService = AdministrationService.shared
    
    /// List of administrations
    var administrations = [Administration]()
    
    /// List of administrations filtered by searchgin
    var filteredAdministrations = [Administration]()
    
    /// Table View connection of list of administrations
    @IBOutlet weak var administrationsTableView: UITableView!
    
    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "AdministrationTableViewCell"
    
    /// Indicate if search is activated
    var searchActive : Bool = false
    
    ///	Search controller
    @IBOutlet weak var searchBar: UISearchBar!
    
    /// Administrations counter
    @IBOutlet weak var counterLabel: UILabel!
    
    /// Loading indicator
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    /// SeachBar and Counter View
    @IBOutlet weak var searchAndCounterView: UIView!
    
    /// No Admin View
    @IBOutlet weak var noAdminView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        administrationsTableView.dataSource = self
        searchBar.delegate = self
        
        // Avoid some layour errors
        definesPresentationContext = true
        
        // Set up top and bottom borer in counterLabel
        let frame = counterLabel.frame
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: frame.height, width: frame.width - 1, height: 0.5)
        let topLayer = CALayer()
        topLayer.frame = CGRect(x: 0, y: 0, width: frame.width - 1, height: 0.5)
        bottomLayer.backgroundColor = UIColor(displayP3Red: 190.0/255, green: 190.0/255, blue: 190.0/255, alpha: 1).cgColor
        topLayer.backgroundColor = UIColor(displayP3Red: 180.0/255, green: 180.0/255, blue: 180.0/255, alpha: 1).cgColor
        counterLabel.layer.addSublayer(bottomLayer)
        counterLabel.layer.addSublayer(topLayer)
        
        administrationService.getAllAdministrations() { (result: Result<[AdministrationDTO], URLResponse, ServiceError>) in
            switch result {
            case .success(let administrationsResponse):
                self.loadAdministrations(administrationsDTO: administrationsResponse.data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadAdministrations(administrationsDTO: [AdministrationDTO]) {
        for administrationDTO in administrationsDTO {
            let name = administrationDTO.nombre ?? "Nombre no disponible"
            
            var photo: UIImage? = nil
            if let url = URL(string: administrationDTO.urlFoto ?? "") {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        photo = image
                    }
                }
            }
            
            var address: String
            if let city = administrationDTO.poblacion {
                address = "\(city)"
            } else {
                address = ""
            }
            if let state = administrationDTO.provincia {
                address += " (\(state))"
            } else {
                address += ""
            }
            if address.isEmpty {
                address = "Direccion no disponible"
            }
            
            if let administration = Administration(name: name, photo: photo, address: address) {
                administrations += [administration]
            }
        }
        DispatchQueue.main.async {
            self.administrationsTableView.reloadData()
            self.loadingIndicator.stopAnimating()
            self.administrationsTableView.isHidden = false
            self.searchAndCounterView.isHidden = false
        }
    }
    
    private func showNoAdminNotification(show: Bool) {
        switch show {
            case true:
                self.administrationsTableView.isHidden = true
                self.noAdminView.isHidden = false
            case false:
                self.administrationsTableView.isHidden = false
                self.noAdminView.isHidden = true
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int
        if searchActive && searchBar.text != "" {
            count = filteredAdministrations.count
        } else {
            count = administrations.count
        }
        counterLabel.text = String(count)
        
        if count != 0 {
            showNoAdminNotification(show: false)
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AdministrationTableViewCell  else {
            fatalError("The dequeued cell is not an instance of AdministrationTableViewCell.")
        }
        
        let administration: Administration
        // Fetches the appropriate administrations for the data source layout.
        if searchActive && searchBar.text != "" {
            administration = filteredAdministrations[indexPath.row]
        } else {
            administration = administrations[indexPath.row]
        }
        
        cell.nameLabel.text = administration.name
        cell.photoImageView.image = administration.photo
        cell.addressLabel.text = administration.address
        
        return cell
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterAdministrations(textDidChange: searchText)
    }
    
    /**
     Filter administrations depending on passed text and reload the table.
     
     - Parameters:
     - searchText: Text to filter by
     */
    private func filterAdministrations(textDidChange searchText: String) {
        filteredAdministrations = administrations.filter { administration in
            return administration.name.lowercased().contains(searchText.lowercased()) || administration.address.lowercased().contains(searchText.lowercased())
        }
        
        if filteredAdministrations.count == 0 {
            showNoAdminNotification(show: true)
        }
        
        administrationsTableView.reloadData()
    }
    
}

