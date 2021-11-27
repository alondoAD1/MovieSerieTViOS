//
//  MoviesHeaderCollectionReusableView.swift
//  GoNet Examen
//
//  Created by A on 25/11/21.
//

import UIKit

class MoviesHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identificador = "MoviesHeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Titulo peliculas"
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()

    }
    
    public func configureUI() {
        backgroundColor = .white
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            label.heightAnchor.constraint(equalToConstant: 40)

        ])
        
    }
    
 
        
}
