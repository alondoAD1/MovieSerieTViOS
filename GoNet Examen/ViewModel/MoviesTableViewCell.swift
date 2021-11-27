//
//  MoviesTableViewCell.swift
//  GoNet Examen
//
//  Created by A on 24/11/21.
//

import UIKit

class MoviesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    

    var datalist = [Result]()
    var datalistTop_rated = [ResultTopRated]()
    
    var datalistTV = [Resultseries]()
    var datalistTop_ratedTV = [Resultseries]()
    
    var typeTableV = Int()


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
    
    lazy var collectionViewTopRated: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
//        collectionView.isPagingEnabled = true
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.register(MoviesHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MoviesHeaderCollectionReusableView.identificador)
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

//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageNames.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MyCollectionViewCell
//        cell.imageView.image  = UIImage.init(named: imageNames[indexPath.row])
//        cell.titleLabel.text  = gameNames[indexPath.row]
//        cell.detailLabel.text = "Games"
//
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return datalist.count
//        if typeTableV == 0 {
//            if section == 0 {
//                return datalist.count
//            } else {
//                return datalistTop_rated.count
//            }
//        } else {
//
//        }
        
        if section == 0 {
            return datalist.count
        } else {
            return datalistTop_rated.count
        }
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell

        let row = indexPath.row
        let section = indexPath.section

//        if typeTableV == 0 {
//            if section == 0 {
//                cell.setDatosCell(datalist[row])
//            }
//            else if section == 1 {
//                cell.configureUICellTopRated(datalistTop_rated[row])
//            }
//        }
        
        if section == 0 {
            cell.setDatosCell(datalist[row])
        }
        else if section == 1 {
            cell.setDatosCellTopRated(datalistTop_rated[row])
        }
        
//        let movieObjc = datalist[indexPath.row]
//
//        cell.configureUICell(movieObjc)
//        print("Dato especificos: ", movieObjc.overview)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = self.storyboard?.instantiateViewController(
//                                            withIdentifier: "ResultadosQuiz") as! DetailsViewController
//                             
//        
//        // checar valores double al enviar actividades
//                                        
//        vc.getIDClase = msn.IDClase!
//        vc.getActividad = msn.NumerodeAct!
//        vc.getIDMaestro = msn.IDMaestro!
////                    vc.getUid = self.getUid
//        vc.getusername = self.getusername
////                    vc.getChildID = msn.childID!
//        vc.getPuntosMax = msn.puntosMax!
//     
//        vc.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(vc, animated: true)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "WeekViewController")
//        present(vc, animated: true)
//
//        let vc = (storyboard.instantiateViewController(withIdentifier: "YourTableViewController") as? YourTableViewController)!
//        UINavigationController.pushViewController( vc, animated: true)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let messagesViewController = storyboard.instantiateViewController(withIdentifier: "MessagesViewController") as! DetailsViewController
       
        
        if indexPath.section == 0 {
            let VC = DetailsViewController()
            VC.getDataItems(datalist[indexPath.row])
            VC.getImagePath(movie_ID: datalist[indexPath.row].id)
            self.window?.rootViewController?.present(VC, animated: true, completion: nil)
        } else {
            let VC = DetailsViewController()
            VC.getDataTop_Ranked(datalistTop_rated[indexPath.row])
            VC.getImagePath(movie_ID: datalistTop_rated[indexPath.row].id)
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
//        return CGSize(width: view.frame.size.width, height: 40)
        
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

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDatosCell(_ movie: Result) {
        actualizarDatos(imagenURL: movie.poster_path)
        texto.text = movie.title
    }
    
    private var urlString: String = ""
    private func actualizarDatos(imagenURL: String?) {
        guard let imagenString = imagenURL else { return }
        urlString = "https://image.tmdb.org/t/p/w300" + imagenString
        guard let posterImagenURL = URL(string: urlString) else {
            self.imagePelicula.image = UIImage(systemName: "photo")
            return
        }
        
        self.imagePelicula.image = nil
        
        obtenerImagenData(url: posterImagenURL)
    }
    
    private func obtenerImagenData(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Dato vacio")
                return
            }
            
            DispatchQueue.main.async {
                if let image  = UIImage(data: data) {
                    self.imagePelicula.image = image
                }
            }
            
        }.resume()
    }
    
    func constraints() {
//        print("cargando datos")

//        self.contentView.addSubview(view)
        self.contentView.addSubview(collectionViewMovie)
//        view.addSubview(imagePelicula)
//        view.addSubview(texto)
        
        NSLayoutConstraint.activate([
//            view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
//            view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0),
//            view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0),
//            view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
//
//            imagePelicula.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
//            imagePelicula.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            imagePelicula.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
////            imagePelicula.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 5),
//            imagePelicula.widthAnchor.constraint(equalToConstant: 90),
//            imagePelicula.heightAnchor.constraint(equalToConstant: 150),
//
//            texto.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
//            texto.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            texto.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
//            texto.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 5),
//            texto.widthAnchor.constraint(equalToConstant: 40),
            
                        collectionViewMovie.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                        collectionViewMovie.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
                        collectionViewMovie.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
                        collectionViewMovie.heightAnchor.constraint(equalToConstant: 250),
                        collectionViewMovie.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            
        ])
    }
    

}
