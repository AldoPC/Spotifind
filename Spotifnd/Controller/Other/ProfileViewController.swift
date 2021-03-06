//
//  ProfileViewController.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 21/04/21.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = .clear
        return tableView
    }()
    
    private var models = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        fetchProfile()
        view.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchProfile(){
        APICaller.shared.getCurrentUserProfile{ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.failedToGetProfile()
                }
            }
        }
    }
    
    private func updateUI(with model: UserProfile){
        tableView.isHidden = false
        //Configure table models
        models.append("Full name: \(model.display_name)")
        models.append("Email Address: \(model.email)")
        models.append("User ID: \(model.id)")
        models.append("Plan: \(model.product)")
        createTableHeader(with: model.images.first?.url)
        tableView.reloadData()
    }
    
    private func createTableHeader(with string: String?){
        guard let urlString = string, let url = URL(string: urlString)else{
            return
        }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        
        let imageSize: CGFloat = headerView.height/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url, completed: nil)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2
        tableView.tableHeaderView = headerView
    }
    
    private func failedToGetProfile(){
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
    
    //MARK : TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
        return cell
    }
    
}
