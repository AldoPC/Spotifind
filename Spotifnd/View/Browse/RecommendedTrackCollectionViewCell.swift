//
//  RecommendedTrackCollectionViewCell.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 25/04/21.
//

import UIKit
import SDWebImage

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.width-10
        let trackNameLabelSize = trackNameLabel.sizeThatFits(CGSize(width: contentView.width - imageSize - 10, height: contentView.height - imageSize - 10))
        let artistNameLabelSize = artistNameLabel.sizeThatFits(CGSize(width: contentView.width - imageSize - 10, height: contentView.height - imageSize - 10))

        

        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        trackNameLabel.frame = CGRect(
            x: contentView.width/2 - trackNameLabel.width/2,
            y: imageSize+30,
            width: min(trackNameLabelSize.width, contentView.width),
            height: trackNameLabelSize.height)
        artistNameLabel.frame = CGRect(x: contentView.width/2 - artistNameLabel.width/2, y: imageSize+60, width: artistNameLabelSize.width, height: artistNameLabelSize.height)
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedTrackCellViewModel){
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    
}
