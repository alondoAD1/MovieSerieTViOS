//
//  MovieCollectionViewCell.swift
//  GoNet Examen
//
//  Created by A on 25/11/21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    
    lazy var view: UIView = {
        let view = UIView()
//        view.backgroundColor = .yellow
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
//        texto.textColor = .red
        texto.translatesAutoresizingMaskIntoConstraints = false
        return texto
    }()

    
    func configureUICell(_ movie: Result) {
        setDatosCell(movie)
    }
    
    func configureUICellTopRated(_ movie: ResultTopRated) {
        setDatosCellTopRated(movie)
    }
    
    override func layoutSubviews() {
      
        constraintsUI()

    }
    
    func setDatosCell(_ movie: Result) {
        actualizarDatos(imagenURL: movie.poster_path)
        texto.text = movie.title
    }
    
    func setDatosCellTopRated(_ movie: ResultTopRated) {
        self.imagePelicula.image = nil
        actualizarDatos(imagenURL: movie.poster_path)
        texto.text = movie.title
    }
    
    func setDatosTV(_ movie: ResultseriesTop) {
        actualizarDatos(imagenURL: movie.poster_path)
//        texto.text = movie.title
    }
    
    
//https://image.tmdb.org/t/p/w300/ikN8ABD9pXHuW4JFqTEHr3ae8rd.jpg
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
    
    func constraintsUI() {
        imagePelicula.contentMode = .scaleAspectFill

        self.contentView.addSubview(view)
        view.addSubview(imagePelicula)
//        view.addSubview(texto)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 7.5),
            view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -7.5),
            view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),

            imagePelicula.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            imagePelicula.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imagePelicula.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
//            imagePelicula.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 5),
            imagePelicula.widthAnchor.constraint(equalToConstant: 165),
//            imagePelicula.heightAnchor.constraint(equalToConstant: 150),
            
//            texto.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
//            texto.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            texto.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
//            texto.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 5),
//            texto.widthAnchor.constraint(equalToConstant: 40),
            
            
        ])
    }

    
}
