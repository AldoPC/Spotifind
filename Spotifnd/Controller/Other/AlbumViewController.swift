//
//  AlbumViewController.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 28/04/21.
//

import UIKit

class AlbumViewController: UIViewController {

    private let album: Album
    
    init(album:Album){
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
        APICaller.shared.getAlbumDetails(for: album){ result in
            DispatchQueue.main.async {
                switch result{
                case .success(let model):
                    break
                case .failure(let error):
                    break
                }
            }
        }
    }
}
