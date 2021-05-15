//
//  WelcomeViewController.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 21/04/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.layer.cornerRadius = 15.0
        button.setTitleColor(UIColor(red: 0.2353, green: 0.7804, blue: 0.3804, alpha: 1.0), for: .normal)
        return button
    }()
    
    private let findYourGroove: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 27, weight: .bold)
        label.textColor = UIColor(red: 0.2353, green: 0.7804, blue: 0.3804, alpha: 1.0)
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.layer.cornerRadius = 15.0
        label.layer.masksToBounds = true
        return label
    }()
    
    private let explanation1: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let search: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 27, weight: .bold)
        label.textColor = UIColor(red: 0.2353, green: 0.7804, blue: 0.3804, alpha: 1.0)
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.layer.cornerRadius = 15.0
        label.layer.masksToBounds = true
        return label
    }()
    
    private let explanation2: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let Library: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 27, weight: .bold)
        label.textColor = UIColor(red: 0.2353, green: 0.7804, blue: 0.3804, alpha: 1.0)
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.layer.cornerRadius = 15.0
        label.layer.masksToBounds = true
        return label
    }()
    
    private let explanation3: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotifind"
        view.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
        view.addSubview(signInButton)
        view.addSubview(findYourGroove)
        view.addSubview(explanation1)
        view.addSubview(search)
        view.addSubview(explanation2)
        view.addSubview(Library)
        view.addSubview(explanation3)
        findYourGroove.text = "Find Your Groove"
        explanation1.text = "Find new music depending on your taste."
        search.text = "Search"
        explanation2.text = "Search for new tracks, albums and playlists."
        Library.text = "Library"
        explanation3.text = "Manage your playlists and Saved Albums."
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(
            x: 20,
            y: view.height-90-view.safeAreaInsets.bottom,
            width: view.width-40,
            height: 50
        )
        findYourGroove.frame = CGRect(
            x: 10,
            y: 150,
            width: 217,
            height: 50
        )
        explanation1.frame = CGRect(
            x: 10,
            y: findYourGroove.bottom-10,
            width: view.width,
            height: 50
        )
        search.frame = CGRect(
            x: 10,
            y: explanation1.bottom+20,
            width: 91,
            height: 50
        )
        explanation2.frame = CGRect(
            x: 10,
            y: search.bottom,
            width: view.width,
            height: 50
        )
        Library.frame = CGRect(
            x: 10,
            y: explanation2.bottom+20,
            width: 91,
            height: 50
        )
        explanation3.frame = CGRect(
            x: 10,
            y: Library.bottom-10,
            width: view.width,
            height: 50
        )
    }
    
    @objc func didTapSignIn(){
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool){
        //Log user in or throw error
        guard success else{
            let alert = UIAlertController(title: "Woops", message: "Algo salió mal", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC, animated: true)
    }
}
