//
//  TVTableViewCell.swift
//  GoNet Examen
//
//  Created by A on 26/11/21.
//

import UIKit

class TVTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var datalistTV = [ResultseriesTop]()
    var datalistTop_ratedTV = [ResultseriesTop]()
    

    lazy var collectionViewMovie: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
//        collectionView.isPagingEnabled = true
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
//        collectionView.register(TVTableViewCell.self, forCellWithReuseIdentifier: "MovieTopRatedCollectionViewCell")

//        collectionView.register(MoviesHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MoviesHeaderCollectionReusableView.identificador)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
//        let cellWidthHeightConstant: CGFloat = UIScreen.main.bounds.width * 0.45
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 7.5,
                                           bottom: 7.5,
                                           right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 165, height: 250)
        
        return layout
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return datalistTV.count
        } else {
            return datalistTop_ratedTV.count
        }

        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell

        let row = indexPath.row
        let section = indexPath.section

        
        if section == 0 {
            cell.setDatosTV(datalistTV[row])
        }
        else if section == 1 {
            cell.setDatosTV(datalistTop_ratedTV[row])
        }
        

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let VC = DetailsViewController()
            VC.getDataItemsTV(data: datalistTV[indexPath.row])
            VC.getImagePathTV(TV_ID: datalistTV[indexPath.row].id)

            self.window?.rootViewController?.present(VC, animated: true, completion: nil)
        } else {
            let VC = DetailsViewController()
            VC.getDataItemsTV(data: datalistTop_ratedTV[indexPath.row])
            VC.getImagePathTV(TV_ID: datalistTop_ratedTV[indexPath.row].id)
            self.window?.rootViewController?.present(VC, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 90
        let cellHeight = 150
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MoviesHeaderCollectionReusableView.identificador, for: indexPath) as! MoviesHeaderCollectionReusableView
        
//        let movieObjc = datalist[indexPath.row]
        header.configureUI()
//        header.label.text = "Peliculas favoritas"
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if(section==0) {
            return CGSize(width: 150, height: 45)
        } else {
            return CGSize(width:collectionView.frame.size.width, height:133)
        }
        
    }
    

    
    
    lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var imagePelicula: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    lazy var texto: UILabel = {
        let texto = UILabel()
        texto.text = "Row"
        texto.textColor = .red
        texto.translatesAutoresizingMaskIntoConstraints = false
        return texto
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func constraints() {
        self.contentView.addSubview(collectionViewMovie)
        NSLayoutConstraint.activate([
            
                        collectionViewMovie.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                        collectionViewMovie.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
                        collectionViewMovie.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
                        collectionViewMovie.heightAnchor.constraint(equalToConstant: 250),
                        collectionViewMovie.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            
        ])
    }
    

}
