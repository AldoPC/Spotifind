//
//  ViewController.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 21/04/21.
//

import UIKit

enum BrowseSectionType{
    case recommendedTracks(viewModels:[RecommendedTrackCellViewModel])
}

class HomeViewController: UIViewController {
    
    private var tracks:[AudioTrack] = []
    
    private var collectionView: UICollectionView = UICollectionView(
    frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
    return HomeViewController.createSectionLayout(section: sectionIndex)
})
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        
        view.addSubview(spinner)
        
        configureCollectionView()
        fetchData()
    }
    
    private var sections = [BrowseSectionType]()
    
     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(RecommendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        let section = sections[indexPath.section]
//        switch section {
//        case .recommendedTracks:
//            let track = tracks[indexPath.row]
//            break
//        default:
//            let track = tracks[indexPath.row]
//        }
//    }
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection{
        //item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        //group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.7)),
                subitem: item, count: 1)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func fetchData(){

        
        //Featured Playlist, Recommended Tracks, NewReleases
        let group = DispatchGroup()
        group.enter()
        var recommendations: RecommendationsResponse?
        
        let number = Int.random(in: 1...2)
        print(number)
        switch number {
        case 1:
            APICaller.shared.getTopArtists{ result in
                switch result{
                case .success(let model):
                    let artist = model.items
                    var seeds = Set<String>()
                    while seeds.count < 5{
                        if let random = artist.randomElement(){
                            seeds.insert(random.id)
                        }
                    }
                    APICaller.shared.getRecommendationsArtists(genres: seeds) { recommendedResults in
                        defer{
                            group.leave()
                        }
                        switch recommendedResults {
                        case .success(let model):
                            recommendations = model
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case 2:
            APICaller.shared.getTopTracks{ result in
                switch result{
                case .success(let model):
                    let artist = model.items
                    var seeds = Set<String>()
                    while seeds.count < 5{
                        if let random = artist.randomElement(){
                            seeds.insert(random.id)
                        }
                    }
                    APICaller.shared.getRecommendationsTracks(genres: seeds) { recommendedResults in
                        defer{
                            group.leave()
                        }
                        switch recommendedResults {
                        case .success(let model):
                            recommendations = model
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            print("epic")
        }
        
        

        group.notify(queue: .main){
            guard let tracks = recommendations?.tracks else{
                return
            }
            self.configureModel(tracks: tracks)
        }
    }
    
    
    
    private func configureModel(tracks: [AudioTrack]){
        self.tracks = tracks
        
        sections.append(.recommendedTracks(viewModels: tracks.compactMap({
            return RecommendedTrackCellViewModel(name: $0.name, artistName: $0.artists.first?.name ?? "-", artworkURL: URL(string: $0.album?.images.first?.url ?? ""))
        })))
        collectionView.reloadData()
    }
    
    @objc func didTapSettings(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }


}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .recommendedTracks(let viewModels):
            return viewModels.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
        case .recommendedTracks(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier, for: indexPath) as? RecommendedTrackCollectionViewCell else{
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
        
    }
}

