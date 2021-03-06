//
//  ViewController.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 21/04/21.
//

import UIKit
import WatchConnectivity

enum BrowseSectionType{
    case recommendedTracks(viewModels:[RecommendedTrackCellViewModel])
}

class HomeViewController: UIViewController {
    
    private var tracks:[AudioTrack] = []
    var session: WCSession?
    
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
        title = "Find Your Groove"
        session = WCSession.default
        session?.delegate = self
        session?.activate()
        
        view.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(didTapRefresh))
        
        view.addSubview(spinner)
        
        configureCollectionView()
        fetchData()
        addLongTapGesture()
    }
    
    private var sections = [BrowseSectionType]()
    
     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func addLongTapGesture(){
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        collectionView.isUserInteractionEnabled = true
        collectionView.addGestureRecognizer(gesture)
    }
    
    @objc func didLongPress(_ gesture: UILongPressGestureRecognizer){
        guard gesture.state == .began else{
            return
        }
        let touchPoint = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: touchPoint), indexPath.section == 0 else{
            return
        }
        let model = tracks[indexPath.row]
        let actionSheet = UIAlertController(title: model.name, message: "Would you like to add this to a playlist?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Add to Playlist", style: .default, handler: { _ in
            
            DispatchQueue.main.async {
                let vc = LibraryPlaylistViewController()
                vc.selectionHandler = { playlist in
                    APICaller.shared.addTrackToPlaylist(track: model, playlist: playlist) { success in
                        if success{
                        HapticsManager.shared.vibrate(for: .success)
                        } else {
                        HapticsManager.shared.vibrate(for: .error)
                        }
                    }
                }
                vc.title = "Select Playlist"
                self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            }
        }))
        present(actionSheet, animated: true)
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
        
        sections.removeAll()
        
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
    
    @objc func didTapRefresh(){
        fetchData()
    }


}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource, WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HapticsManager.shared.vibrateForSelection()
        collectionView.deselectItem(at: indexPath, animated: true)
        let section = sections[indexPath.section]
        switch section {
        case .recommendedTracks:
            let track = tracks[indexPath.row]
            let message = ["songName":track.name,"artistName":track.artists.first?.name]
            session?.sendMessage(message, replyHandler: nil, errorHandler: nil)
            PlaybackPresenter.shared.startPlayback(from: self, track: track)
        }
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

