//
//  showMoreInfoViewController.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 10/05/21.
//

import UIKit
import MapKit

class showMoreInfoViewController: UIViewController {
    
    let artist: String
    
    let map = MKMapView()
    
    private let nameArtist: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 45, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        view.addSubview(nameArtist)
        view.addSubview(map)
        
        let pLat = 48.858794866049806
        let pLong = 2.294441390335718
        let center = CLLocationCoordinate2D(latitude: pLat, longitude: pLong)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        map.setRegion(region, animated: true)
        nameArtist.text = artist
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameArtist.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        map.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
    }
    
    init(artist: String){
        self.artist = artist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    
}
