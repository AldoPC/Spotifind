//
//  showMoreInfoViewController.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 10/05/21.
//

import UIKit
import MapKit
import FirebaseFirestore
import Firebase

class showMoreInfoViewController: UIViewController {
    
    let artist: String
    var artistName: String?
    var pLat: Double?
    var pLong: Double?
    
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
        
        let db = Firestore.firestore()
        
        db.collection("artists").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let docId = document.documentID
                    print(docId)
                    print(self.artist)
                    if(docId == self.artist){
                        nameArtist.text = document.get("name") as? String ?? ""
                        pLat = (document.get("latitud") as? NSString)!.doubleValue
                        pLong = (document.get("longitud") as? NSString)!.doubleValue
                        print(docId, nameArtist.text ?? "", pLat ?? 0.0, pLong ?? 0.0)
                        let center = CLLocationCoordinate2D(latitude: pLat ?? 0.0, longitude: pLong ?? 0.0)
                        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                        map.setRegion(region, animated: true)
                        let band = MKPointAnnotation()
                        band.coordinate = CLLocationCoordinate2DMake(pLat ?? 0.0, pLong ?? 0.0)
                        band.title = document.get("name") as? String ?? ""
                        map.addAnnotation(band)
                        map.showsCompass = true
                        map.isZoomEnabled = true
                        return
                    } else { print("next") }
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameArtist.frame = CGRect(x: 0, y: 90, width: view.width, height: 50*2)
        map.frame = CGRect(x: (view.width)/2-(view.width)/2, y: ((view.height)/2-(view.width)/2)+nameArtist.bottom-60, width: view.width, height: view.width)
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
