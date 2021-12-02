//
//  ViewControllerUI.swift
//  GoNet Examen
//
//  Created by A on 02/12/21.
//

import Foundation
import UIKit

class ViewControllerUI: UIViewController {
    
    var vc = UIViewController()
    lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = .clear
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
    lazy var tableViewMovies: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: "MoviesTableViewCell")
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.bounces = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var tableViewTV: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(TVTableViewCell.self, forCellReuseIdentifier: "TVTableViewCell")
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.bounces = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
    
    lazy var username: UITextField = {
        let text = UITextField()
//        text.delegate = self
        text.placeholder = "Nombre de usuario"
        text.borderStyle = .roundedRect
        text.isEnabled = true
//        text.textColor = UIColor.lightGray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var password: UITextField = {
        let text = UITextField()
//        text.delegate = self
        text.placeholder = "Contraseña"
        text.borderStyle = .roundedRect
//        text.textColor = UIColor.lightGray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    

    
    lazy var btnlogin: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.setTitle("Iniciar sesion", for: .normal)
        btn.backgroundColor = UIColor(named: "btnLogin")
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var labelMessage: UILabel = {
        let lbl = UILabel()
//        lbl.text = "Request message"
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var viewlogin: UIView = {
       let view = UIView()
        view.isHidden = true
        view.backgroundColor = UIColor(named: "bafound")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        let pagecontrol = UIPageControl()
        pagecontrol.translatesAutoresizingMaskIntoConstraints = false
        return pagecontrol
    }()
    
    lazy var pageControlTV: UIPageControl = {
        let pagecontrol = UIPageControl()
        pagecontrol.translatesAutoresizingMaskIntoConstraints = false
        return pagecontrol
    }()
    
    lazy var viewScroll: UIScrollView = {
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    lazy var viewEspacio: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewScrollTV: UIScrollView = {
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    lazy var viewEspacioTV: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let segmentBtn: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Movies", "TV Shows"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let btnMyAccount: UILabel = {
        let item = UILabel()
        item.text = "Usar cuenta invitado"
        item.textColor = .systemBlue
        item.textAlignment = .center
        item.isUserInteractionEnabled = true
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    

    func LayoutConstraint(view: UIView) {
        view.addSubview(scrollView)
        self.scrollView.addSubview(viewEspacio)
        self.scrollView.addSubview(viewEspacioTV)
        self.scrollView.addSubview(viewlogin)
        
        viewEspacioTV.isHidden = true
        tableViewTV.isHidden = true
        
        self.scrollView.addSubview(tableViewMovies)
        self.scrollView.addSubview(tableViewTV)

        self.scrollView.addSubview(segmentBtn)

        self.viewEspacio.addSubview(viewScroll)
        self.viewEspacioTV.addSubview(viewScrollTV)

        view.addSubview(viewlogin)
        self.viewlogin.addSubview(username)
        self.viewlogin.addSubview(password)
        self.viewlogin.addSubview(btnlogin)
        self.viewlogin.addSubview(labelMessage)
        self.viewlogin.addSubview(btnMyAccount)
                
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            segmentBtn.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor, constant: 10),
            segmentBtn.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor, constant: -10),
            segmentBtn.heightAnchor.constraint(equalToConstant: 35),
            segmentBtn.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),

            viewEspacio.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor, constant: 10),
            viewEspacio.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor, constant: -10),
            viewEspacio.heightAnchor.constraint(equalToConstant: 250),
            viewEspacio.topAnchor.constraint(equalTo: segmentBtn.bottomAnchor, constant: 15),
            
                        
            viewScroll.heightAnchor.constraint(equalToConstant: 250),
            viewScroll.topAnchor.constraint(equalTo: viewEspacio.topAnchor, constant: 0),
            viewScroll.leftAnchor.constraint(equalTo: viewEspacio.leftAnchor, constant: 0),
            viewScroll.rightAnchor.constraint(equalTo: viewEspacio.rightAnchor, constant: 0),
            viewScroll.centerXAnchor.constraint(equalTo: viewEspacio.centerXAnchor),
            viewScroll.centerYAnchor.constraint(equalTo: viewEspacio.centerYAnchor),
            
            viewEspacioTV.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor, constant: 10),
            viewEspacioTV.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor, constant: -10),
            viewEspacioTV.heightAnchor.constraint(equalToConstant: 250),
            viewEspacioTV.topAnchor.constraint(equalTo: segmentBtn.bottomAnchor, constant: 15),
            
                        
            viewScrollTV.heightAnchor.constraint(equalToConstant: 250),
            viewScrollTV.topAnchor.constraint(equalTo: viewEspacioTV.topAnchor, constant: 0),
            viewScrollTV.leftAnchor.constraint(equalTo: viewEspacioTV.leftAnchor, constant: 0),
            viewScrollTV.rightAnchor.constraint(equalTo: viewEspacioTV.rightAnchor, constant: 0),
            viewScrollTV.centerXAnchor.constraint(equalTo: viewEspacioTV.centerXAnchor),
            viewScrollTV.centerYAnchor.constraint(equalTo: viewEspacioTV.centerYAnchor),
            
            tableViewMovies.topAnchor.constraint(equalTo: viewEspacio.bottomAnchor),
            tableViewMovies.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor),
            tableViewMovies.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor),
            tableViewMovies.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor), // eliminando esto hace que el puedan scrollear
            tableViewMovies.heightAnchor.constraint(equalToConstant: 650),
            
            tableViewTV.topAnchor.constraint(equalTo: viewEspacioTV.bottomAnchor),
            tableViewTV.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor),
            tableViewTV.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor),
            tableViewTV.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor), // eliminando esto hace que el puedan scrollear
            tableViewTV.heightAnchor.constraint(equalToConstant: 650),
            
            viewlogin.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewlogin.leftAnchor.constraint(equalTo: view.leftAnchor),
            viewlogin.rightAnchor.constraint(equalTo: view.rightAnchor),
            viewlogin.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            username.topAnchor.constraint(equalTo: self.viewlogin.topAnchor, constant: 20),
            username.leftAnchor.constraint(equalTo: self.viewlogin.leftAnchor, constant: 50),
            username.rightAnchor.constraint(equalTo: self.viewlogin.rightAnchor, constant: -50),
            
            password.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 10),
            password.leftAnchor.constraint(equalTo: self.viewlogin.leftAnchor, constant: 50),
            password.rightAnchor.constraint(equalTo: self.viewlogin.rightAnchor, constant: -50),
            
            btnlogin.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 65),
            btnlogin.widthAnchor.constraint(equalToConstant: 250),
            btnlogin.heightAnchor.constraint(equalToConstant: 40),
            btnlogin.centerXAnchor.constraint(equalTo: self.viewlogin.centerXAnchor),
            
            labelMessage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            labelMessage.widthAnchor.constraint(equalToConstant: 150),
            labelMessage.centerXAnchor.constraint(equalTo: self.viewlogin.centerXAnchor),

            btnMyAccount.topAnchor.constraint(equalTo: self.btnlogin.bottomAnchor, constant: 20),
            btnMyAccount.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            btnMyAccount.centerXAnchor.constraint(equalTo: self.viewlogin.centerXAnchor),
            
        ])
    }


}
