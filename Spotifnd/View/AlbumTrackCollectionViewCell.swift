//
//  AlbumTrackCollectionViewCell.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 03/05/21.
//

import Foundation
import UIKit

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumTrackCollectionViewCell"
    
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.shadowColor = UIColor.black
        label.textColor = .lightText
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.shadowColor = UIColor.black
        label.textColor = .white
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .black
        contentView.backgroundColor = .black
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(trackNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        trackNameLabel.frame = CGRect(x: 10, y: 0, width: contentView.width-15, height: contentView.height/2)
        artistNameLabel.frame = CGRect(x: 10, y: contentView.height/2, width: contentView.width-15, height: contentView.height/2)
        
        
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        artistNameLabel.text = nil
        trackNameLabel.text = nil
    }
    
    func configure(with viewModel: RecommendedTrackCellViewModel){
        artistNameLabel.text = viewModel.artistName
        trackNameLabel.text = viewModel.name
    }
    
}
