//
//  RecommendedTrackListCollectionViewCell.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 29/04/21.
//

import UIKit
import SDWebImage

class RecommendedTrackListCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.textColor = .lightText
        label.shadowColor = UIColor.black
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
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(trackNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        albumCoverImageView.frame = CGRect(
            x: 5,
            y: 2,
            width: contentView.height-4,
            height: contentView.height-4)
        
        trackNameLabel.frame = CGRect(
            x: albumCoverImageView.right+10,
            y: 0,
            width: contentView.width-albumCoverImageView.right-15,
            height: contentView.height/2)
        
        artistNameLabel.frame = CGRect(
            x: albumCoverImageView.right+10,
            y: trackNameLabel.bottom,
            width: contentView.width-albumCoverImageView.right-15,
            height: contentView.height/2)
        
        
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        artistNameLabel.text = nil
        trackNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedTrackCellViewModel){
        artistNameLabel.text = viewModel.artistName
        trackNameLabel.text = viewModel.name
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    
}
