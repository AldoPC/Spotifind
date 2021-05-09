//
//  SettingsViewController.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 21/04/21.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero , style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
        return tableView
    }()
    
    private var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        title = "Settings"
        view.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    private func configureModels(){
        sections.append(Section(title: "Profile", options: [Option(title: "View Your Profile", handler: {[weak self] in
            DispatchQueue.main.async{
                self?.viewProfile()
            }
        })]))
        sections.append(Section(title: "Account", options: [Option(title: "Sign Out", handler: {[weak self] in
            DispatchQueue.main.async{
                self?.signOutTaped()
            }
        })]))
    }
    
    private func signOutTaped(){
        
    }
    
    private func viewProfile(){
        let vc = ProfileViewController()
        vc.title = "Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        cell.textLabel?.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Call handler for cell
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
    
}
