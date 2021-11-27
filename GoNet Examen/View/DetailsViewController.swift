//
//  DetailsViewController.swift
//  GoNet Examen
//
//  Created by A on 26/11/21.
//

import UIKit
import AVKit
import AVFoundation
import youtube_ios_player_helper

class DetailsViewController: UIViewController, YTPlayerViewDelegate {
    
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    lazy var scrollViewDetaill: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
    lazy var imageBackgroundPath: UIImageView = {
        let item = UIImageView()
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var blurBackgroundPath: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
//        visualEffectView.frame = view.bo
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    lazy var imagePosterPath: UIImageView = {
        let item = UIImageView()
        item.layer.cornerRadius = 20
        item.clipsToBounds = true
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var blurPosterPath: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
//        visualEffectView.frame = view.bo
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    lazy var titulo: UILabel = {
        let item = UILabel()
        item.backgroundColor = .clear
        item.numberOfLines = 0
        item.lineBreakMode = .byWordWrapping
        item.textColor = UIColor(named: "Texto")
        item.font = item.font.withSize(26)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var date: UILabel = {
        let item = UILabel()
        item.backgroundColor = .clear
        item.numberOfLines = 0
        item.lineBreakMode = .byWordWrapping
        item.textColor = UIColor(named: "Texto")
        item.font = item.font.withSize(20)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var vote_average: UILabel = {
        let item = UILabel()
        item.backgroundColor = .clear
        item.numberOfLines = 0
        item.lineBreakMode = .byWordWrapping
        item.textColor = UIColor(named: "Texto")
        item.font = item.font.withSize(20)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var overview: UILabel = {
        let item = UILabel()
        item.backgroundColor = .clear
        item.numberOfLines = 0
        item.lineBreakMode = .byWordWrapping
        item.textColor = UIColor(named: "Texto")
        item.font = item.font.withSize(26)
        item.textAlignment = .justified

        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var viewConter: UIView = {
        let item = UIView()
        item.backgroundColor = .clear
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var viewReproductor: UIView = {
        let item = UIView()
        item.backgroundColor = .clear
        item.layer.cornerRadius = 20
        item.clipsToBounds = true
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var imagenReproductor: UIImageView = {
        let item = UIImageView()
        item.backgroundColor = .clear
        item.isHidden = false
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var imgReproducir: UIImageView = {
        let item = UIImageView()
        item.image = UIImage(systemName: "play.circle.fill")
        item.tintColor = .white
        item.isUserInteractionEnabled = true
        item.isHidden = true
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var ytPlayer: YTPlayerView = {
        let item = YTPlayerView()
        item.isUserInteractionEnabled = true
        item.backgroundColor = .clear
        item.delegate = self
        item.isHidden = false
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(viewConter)
//
//        NSLayoutConstraint.activate([
//            viewConter.leftAnchor.constraint(equalTo: self.view.leftAnchor),
//            viewConter.rightAnchor.constraint(equalTo: self.view.rightAnchor),
//            viewConter.topAnchor.constraint(equalTo: self.view.topAnchor),
//            viewConter.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//        ])
        
        constraintUI()
//        getImagePath()

        // Do any additional setup after loading the view.
        imgReproducir.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.playVideo(tapGesture:)) )  )

    }
    
    @objc func playVideo(tapGesture: UITapGestureRecognizer) {
//        if let url = NSURL(string: self.globalURLPlay) {
//            let player = AVPlayer(url: url as URL)
//            let playerLayer = AVPlayerLayer(player: player)
//            player.play()
//        }
        
//        let url: URL = URL(string: self.globalURLPlay)!
//        playerView = AVPlayer(url: url)
//        playerViewController.player = playerView
//        self.present(playerViewController, animated: true) {
//            self.playerViewController.player?.play()
//        }
//
//        print("player url: ", self.globalURLPlay)
                
//        self.ytPlayer.delegate = self
        imgReproducir.isHidden = true
        imagenReproductor.isHidden = true
        ytPlayer.playVideo()

        
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
//        playerView.playVideo()
        imgReproducir.isHidden = false

    }
    
    var dataTrailerArray = [MovieTrailerresult]()
    var dataArray = [MovieTrailerresult]()
    var globalURLPlay = String()
    func getImagePath(movie_ID: Int) {
        let recomendacionMovies = "https://api.themoviedb.org/3/movie/\(String(movie_ID))/videos?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"

        URLSession.shared.dataTask(with: URLRequest(url: URL(string: recomendacionMovies)!)) {
            (data, req, error) in
            self.globalURLPlay = ""
            self.dataTrailerArray.removeAll()
            self.dataArray.removeAll()
            do {
                let result = try JSONDecoder().decode(MovieTrailer.self, from: data!)

                DispatchQueue.main.async {
                    self.dataTrailerArray = result.results
                    
                    for i in 0..<self.dataTrailerArray.count{
                        let type = result.results[i].type
                        
                        if type == "Trailer" {
//                            let trailerKey = result.results[i].key
                            self.dataArray = result.results
                            let imgUrlKey = self.dataArray[0].key!
                            self.ytPlayer.load(withVideoId: imgUrlKey)
//                            let url = "https://i.ytimg.com/vi/\( { movie_id(key) } )\/hqdefault.jpg"

//                            let url = "https://i.ytimg.com/vi/\(imgUrlKey)/hqdefault.jpg"
                            let url = "https://i.ytimg.com/vi/\(imgUrlKey)/sddefault.jpg"
//                            let url = "https://i.ytimg.com/vi/\(imgUrlKey)/maxresdefault.jpg"

                            self.imagenReproductor.loadimagenUsandoCacheConURLString(urlString: url)
                            
                            //id para reproducir trailers de youtube
                            //https://www.youtube.com/watch?v=pBvH8hvnJPk
                            //https://www.youtube.com/watch?v=\(imgUrlKey)
//                            self.globalURLPlay = "https://www.youtube.com/watch?v=\(imgUrlKey)"
                            self.globalURLPlay = imgUrlKey

                            print("datos videos", self.dataArray[0].key!)
                            
                        }

                    }

                }
            } catch {
                
            }
        }.resume()
    }
    
    func getImagePathTV(TV_ID: Int) {
        let recomendacionMovies = "https://api.themoviedb.org/3/tv/\(String(TV_ID))/videos?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"

        URLSession.shared.dataTask(with: URLRequest(url: URL(string: recomendacionMovies)!)) {
            (data, req, error) in
            self.globalURLPlay = ""
            self.dataTrailerArray.removeAll()
            self.dataArray.removeAll()
            do {
                let result = try JSONDecoder().decode(MovieTrailer.self, from: data!)

                DispatchQueue.main.async {
                    self.dataTrailerArray = result.results
                    
                    for i in 0..<self.dataTrailerArray.count{
                        let type = result.results[i].type
                        
                        if type == "Trailer" {
//                            let trailerKey = result.results[i].key
                            self.dataArray = result.results
                            let imgUrlKey = self.dataArray[0].key!
                            self.ytPlayer.load(withVideoId: imgUrlKey)

//                            let url = "https://i.ytimg.com/vi/\( { movie_id(key) } )\/hqdefault.jpg"

//                            let url = "https://i.ytimg.com/vi/\(imgUrlKey)/hqdefault.jpg"
                            let url = "https://i.ytimg.com/vi/\(imgUrlKey)/sddefault.jpg"
//                            let url = "https://i.ytimg.com/vi/\(imgUrlKey)/maxresdefault.jpg"

                            self.imagenReproductor.loadimagenUsandoCacheConURLString(urlString: url)
//                            self.globalURLPlay = "https://www.youtube.com/watch?v=\(imgUrlKey)"
                            self.globalURLPlay = imgUrlKey
//                            print("datos videos", self.dataArray[0].key!)
                        }

                    }

                }
            } catch {
                
            }
        }.resume()
    }
    
    func getDataItems(_ data: Result) {
        let urlbackdrop = "https://image.tmdb.org/t/p/w300" + data.backdrop_path
        let urlpost = "https://image.tmdb.org/t/p/w300" + data.poster_path
                   
        imageBackgroundPath.image = nil
        imageBackgroundPath.loadimagenUsandoCacheConURLString(urlString: urlbackdrop)
        
        imagePosterPath.image = nil
        imagePosterPath.loadimagenUsandoCacheConURLString(urlString: urlpost)
        imagenReproductor.image = nil

        titulo.text = data.title
        date.text = data.release_date
        vote_average.text = String(data.vote_average) + " / " + "10"
        overview.text = "Override \n\n" + data.overview

    }
    
    func getDataTop_Ranked(_ data: ResultTopRated) {
        let urlbackdrop = "https://image.tmdb.org/t/p/w300" + data.backdrop_path
        let urlpost = "https://image.tmdb.org/t/p/w300" + data.poster_path
                   
        imageBackgroundPath.image = nil
        imageBackgroundPath.loadimagenUsandoCacheConURLString(urlString: urlbackdrop)
        
        imagePosterPath.image = nil
        imagePosterPath.loadimagenUsandoCacheConURLString(urlString: urlpost)
        imagenReproductor.image = nil

        titulo.text = data.title
        date.text = data.release_date
        vote_average.text = String(data.vote_average) + " / " + "10"
        overview.text = "Override \n\n" + data.overview

    }
    
    func getDataItemsTV(data: ResultseriesTop) {
        let urlbackdrop = "https://image.tmdb.org/t/p/w300" + data.backdrop_path
        let urlpost = "https://image.tmdb.org/t/p/w300" + data.poster_path
                   
        imageBackgroundPath.image = nil
        imageBackgroundPath.loadimagenUsandoCacheConURLString(urlString: urlbackdrop)
        
        imagePosterPath.image = nil
        imagePosterPath.loadimagenUsandoCacheConURLString(urlString: urlpost)
        imagenReproductor.image = nil

        titulo.text = data.name
        date.text = data.first_air_date
        vote_average.text = String(data.vote_average) + " / " + "10"
        overview.text = "Override \n\n" + data.overview
    }
    
    func getDataItemsTVTop(data: ResultseriesTop) {
        let urlbackdrop = "https://image.tmdb.org/t/p/w300" + data.backdrop_path
        let urlpost = "https://image.tmdb.org/t/p/w300" + data.poster_path
                   
        imageBackgroundPath.image = nil
        imageBackgroundPath.loadimagenUsandoCacheConURLString(urlString: urlbackdrop)
        
        imagePosterPath.image = nil
        imagePosterPath.loadimagenUsandoCacheConURLString(urlString: urlpost)
        
        imagenReproductor.image = nil
        
        titulo.text = data.name
        date.text = data.first_air_date
        vote_average.text = String(data.vote_average) + " / " + "10"
        overview.text = "Override \n\n" + data.overview
    }
    
    // MARK: - UIConstraints
    func constraintUI() {
        self.view.addSubview(scrollViewDetaill)
        self.scrollViewDetaill.addSubview(blurBackgroundPath)
        self.scrollViewDetaill.addSubview(imageBackgroundPath)
//        self.scrollViewDetaill.addSubview(blurPosterPath)
        self.scrollViewDetaill.addSubview(imagePosterPath)
        self.scrollViewDetaill.addSubview(titulo)
        self.scrollViewDetaill.addSubview(date)
        self.scrollViewDetaill.addSubview(vote_average)
        self.scrollViewDetaill.addSubview(viewReproductor)
        self.scrollViewDetaill.addSubview(overview)
        
        self.viewReproductor.addSubview(ytPlayer)
        self.viewReproductor.addSubview(imagenReproductor)
        self.viewReproductor.addSubview(imgReproducir)

        self.imageBackgroundPath.alpha = 0.35

        NSLayoutConstraint.activate([
            scrollViewDetaill.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollViewDetaill.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scrollViewDetaill.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollViewDetaill.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            imageBackgroundPath.topAnchor.constraint(equalTo: scrollViewDetaill.topAnchor, constant: 0),
            imageBackgroundPath.leftAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.leftAnchor, constant: 0),
            imageBackgroundPath.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: 0),
            imageBackgroundPath.heightAnchor.constraint(equalToConstant: 230),
            
            
            blurBackgroundPath.topAnchor.constraint(equalTo: scrollViewDetaill.topAnchor, constant: 0),
            blurBackgroundPath.leftAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.leftAnchor, constant: 0),
            blurBackgroundPath.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: 0),
            blurBackgroundPath.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
//            blurBackgroundPath.heightAnchor.constraint(equalToConstant: 1000),

            imagePosterPath.topAnchor.constraint(equalTo: scrollViewDetaill.topAnchor, constant: 70),
            imagePosterPath.leftAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.leftAnchor, constant: 15),
            imagePosterPath.heightAnchor.constraint(equalToConstant: 200),
            imagePosterPath.widthAnchor.constraint(equalToConstant: 130),
            
            titulo.topAnchor.constraint(equalTo: scrollViewDetaill.topAnchor, constant: 70),
            titulo.leftAnchor.constraint(equalTo: imagePosterPath.rightAnchor, constant: 20),
            titulo.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            date.topAnchor.constraint(equalTo: titulo.bottomAnchor, constant: 15),
            date.leftAnchor.constraint(equalTo: imagePosterPath.rightAnchor, constant: 20),
            date.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            vote_average.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 10),
            vote_average.leftAnchor.constraint(equalTo: imagePosterPath.rightAnchor, constant: 20),
            vote_average.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            viewReproductor.topAnchor.constraint(equalTo: imagePosterPath.bottomAnchor, constant: 20),
            viewReproductor.leftAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.leftAnchor, constant: 15),
            viewReproductor.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: -15),
            viewReproductor.heightAnchor.constraint(equalToConstant: 250),
            
            imagenReproductor.topAnchor.constraint(equalTo: viewReproductor.topAnchor),
            imagenReproductor.leftAnchor.constraint(equalTo: viewReproductor.leftAnchor),
            imagenReproductor.rightAnchor.constraint(equalTo: viewReproductor.rightAnchor),
            imagenReproductor.bottomAnchor.constraint(equalTo: viewReproductor.bottomAnchor),
            
            ytPlayer.topAnchor.constraint(equalTo: viewReproductor.topAnchor),
            ytPlayer.leftAnchor.constraint(equalTo: viewReproductor.leftAnchor),
            ytPlayer.rightAnchor.constraint(equalTo: viewReproductor.rightAnchor),
            ytPlayer.bottomAnchor.constraint(equalTo: viewReproductor.bottomAnchor),

            imgReproducir.centerXAnchor.constraint(equalTo: viewReproductor.centerXAnchor),
            imgReproducir.centerYAnchor.constraint(equalTo: viewReproductor.centerYAnchor),
            imgReproducir.heightAnchor.constraint(equalToConstant: 75),
            imgReproducir.widthAnchor.constraint(equalToConstant: 75),
            
//            viewReproductor.bottomAnchor.constraint(equalTo: scrollViewDetaill.bottomAnchor, constant: -20),
            
            overview.topAnchor.constraint(equalTo: viewReproductor.bottomAnchor, constant: 20),
            overview.leftAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.leftAnchor, constant: 15),
            overview.rightAnchor.constraint(equalTo: scrollViewDetaill.safeAreaLayoutGuide.rightAnchor, constant: -15),
            overview.bottomAnchor.constraint(equalTo: scrollViewDetaill.bottomAnchor, constant: -20),
            
            


        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
