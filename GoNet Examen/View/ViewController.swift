//
//  ViewController.swift
//  GoNet Examen
//
//  Created by A on 23/11/21.
//

import UIKit
import Network

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    
    private var popularMovies = [Movie]()
    private var viewModel = MoviewViewModel()
    var datalist = [Result]()
    var datalistTop_rated = [ResultTopRated]()
    var datalistPageSwipe = [Result]()
    
    var datalistTV = [ResultseriesTop]()
    var datalistTop_ratedTV = [ResultseriesTop]()
    var datalistPageSwipeTV = [ResultseriesTop]()

    var itemscount = [Int]()
    var ui = ViewControllerUI()
    
    var toogleSgmt = false
    @objc func segmentClick(tapGesture: UITapGestureRecognizer) {
        if toogleSgmt == false {
            toogleSgmt = true
            ui.segmentBtn.selectedSegmentIndex = 1
            ui.tableViewMovies.isHidden = true
            ui.viewEspacio.isHidden = true
            ui.tableViewTV.isHidden = false
            ui.viewEspacioTV.isHidden = false
            
        } else {
            toogleSgmt = false
            ui.segmentBtn.selectedSegmentIndex = 0
            ui.tableViewMovies.isHidden = false
            ui.viewEspacio.isHidden = false
            ui.tableViewTV.isHidden = true
            ui.viewEspacioTV.isHidden = true
        }
        
    }
    
    
    lazy var navigationControllerLargeTitleFrame: CGRect = {
            let navigationController = UINavigationController()
            navigationController.navigationBar.prefersLargeTitles = true
            return navigationController.navigationBar.frame
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemscount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ui.tableViewMovies {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
            if indexPath.section == 0 {
                cell.datalist = datalist

            } else {
                cell.datalistTop_rated = datalistTop_rated

            }
            
            return cell
        }

       
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVTableViewCell", for: indexPath) as! TVTableViewCell
        if indexPath.section == 0 {
            cell.datalistTV = datalistTV

        } else {
            cell.datalistTop_ratedTV = datalistTop_ratedTV

        }
        
        return cell
    }
 
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == ui.tableViewMovies {
            return (section%2 == 0) ? "Mis peliculas favoritas" : "Recomendaciones para ti"

        }
        return (section%2 == 0) ? "Mis seriesTV favoritas" : "Recomendaciones para ti"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        itemscount.append(1)
//        sectioncount.append(2)


        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
//        self.collectionViewMovie.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
//        self.collectionViewMovie.reloadData()
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
            
        }
        
        
        if (UserDefaults.standard.string(forKey: userKeyDefault) != nil) {
//            self.getPersistenciaDataDecrypted()
            self.navigationItem.rightBarButtonItem = nil
            self.navigationitem()
//            self.monitorNetwork()
            let loader = self.loader(message: "Por favor espere...")

            self.getPersistenciaDataDecrypted(loader: loader)
        } else {
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = "Login"
            self.ui.viewlogin.isHidden = false
            self.ui.tableViewMovies.isHidden = true
            self.ui.viewScroll.isHidden = true
        }
        
        
        self.monitorNetwork()

        
    }
    

    
    var mon: NWPathMonitor = NWPathMonitor()
    var queue = DispatchQueue(label: "Monitor")

    func monitorNetwork() {
        mon.pathUpdateHandler = { p in
            if p.status == .satisfied {
                DispatchQueue.main.async {
//                    let loader = self.loader(message: "Por favor espere...")

                    print("Satisfied") // add animation connection
                    // Movie TMDB
                    
                    if (UserDefaults.standard.string(forKey: self.userKeyDefault) != nil) {
                        self.navigationItem.rightBarButtonItem = nil
                        self.navigationitem()
//                        self.getPersistenciaDataDecrypted()

                    } else {
                        self.navigationItem.rightBarButtonItem = nil
                        self.navigationItem.title = "Login"
                        self.ui.viewlogin.isHidden = false
                        self.ui.tableViewMovies.isHidden = true
                        self.ui.viewScroll.isHidden = true


                    }
                }
            } else if p.status == .requiresConnection {
                DispatchQueue.main.async {
                    print("Requires Connection") // add animation no connection
                    self.mensajeNoConexion()

                }
            } else if p.status == .unsatisfied {
                DispatchQueue.main.async { [self] in
                    print("Unsatisfied") // add animation no connection
                    self.mensajeNoConexion()

                }
            } else {
                DispatchQueue.main.async {
                    print("Unknown") // add animation no connection
                    self.mensajeNoConexion()
                }
            }
        }
        mon.start(queue: queue)
        
        
    }
    
    func mensajeNoConexion() {
        let alert = UIAlertController(title: "Atencion!", message: "No se pueden ver las listas por el momento. Verifica tu conexion a internet o datos moviles!.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Aceptar", style: .default) { _ in
            self.monitorNetwork()
        })
        
        self.present(alert, animated: true, completion: nil)
    }
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ui.username.delegate = self
        ui.password.delegate = self
        ui.tableViewMovies.delegate = self
        ui.tableViewMovies.dataSource = self
        ui.tableViewTV.delegate = self
        ui.tableViewTV.dataSource = self
        
        ui.btnlogin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.loginFuncion)))
        ui.btnMyAccount.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.loginInvitado)))

        guard let navigationController = navigationController else { return }
            navigationController.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController.navigationBar.sizeToFit()
        
        self.view.backgroundColor = UIColor(named: "bafound")
        
        ui.LayoutConstraint(view: self.view)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(segmentClick))
        tapGesture.numberOfTapsRequired = 1
        ui.segmentBtn.addGestureRecognizer(tapGesture)
        

    }
    
    var navString = "Logout"
    func navigationitem(){
        let label = UILabel()
        label.text = navString
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.isEnabled = true
        label.isUserInteractionEnabled = true
        let item = UIBarButtonItem.init(customView: label)
        let widthConstraint = label.widthAnchor.constraint(equalToConstant: 80)
        let heightConstraint = label.heightAnchor.constraint(equalToConstant: 50)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        self.navigationItem.rightBarButtonItem =  item
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.cerrarsesion)))
            
    }
    
    @objc func cerrarsesion() {
        UserDefaults.standard.removeObject(forKey: self.userKeyDefault)
        UserDefaults.standard.removeObject(forKey: self.passworKeyDefault)
        UserDefaults.standard.removeObject(forKey: self.requestKeyDefault)
        UserDefaults.standard.removeObject(forKey: self.sessionIDKeyDefault)
        UserDefaults.standard.removeObject(forKey: self.userIDKeyDefault)
        UserDefaults.standard.synchronize()
        
            DispatchQueue.main.async { [self] in
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = "Login"
            ui.viewlogin.isHidden = false
            ui.tableViewMovies.isHidden = true
            ui.viewScroll.isHidden = true
        }
        
    }
                                         
    
    @objc func orientationDidChangeNotification(_ notification: NSNotification) {
        if UIDevice.current.orientation == .portrait {
            navigationController?.navigationBar.frame = navigationControllerLargeTitleFrame
        }
    }
    
    let userKeyDefault = "userKeyDefault"
    let passworKeyDefault = "passworKeyDefault"
    let requestKeyDefault = "requestKeyDefault"
    let sessionIDKeyDefault = "sessionIDKeyDefault"
    let userIDKeyDefault = "userIDKeyDefault"
    var usernameSt = String()
    var passwordSt = String()

    @objc func loginFuncion(TapGesture: UITapGestureRecognizer) {
            usernameSt = ui.username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            passwordSt = ui.password.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            if ui.username.text!.isEmpty {
                ui.labelMessage.text = "Nombre de usuario vacio."
            } else if ui.password.text!.isEmpty {
                ui.labelMessage.text = "Contraseña vacio."
        } else {
               // create a session here
            let loader = self.loader(message: "Por favor espere...")
            present(loader, animated: true, completion: nil)
            self.getRequestToken(loader: loader)

        }
    }
    
    @objc func loginInvitado(TapGesture: UITapGestureRecognizer) {
        usernameSt = "RicardoAD"
        passwordSt = "123456aD"

        let message = "Es una aplicacion simple que en un caso real no se usara pero asigne mi cuenta para puedan iniciar sesion con ella y puedan ver mis listas agregadas a favoritos."
        let alert = UIAlertController(title: "Atencion!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let loader = self.loader(message: "Por favor espere...")
            self.present(loader, animated: true, completion: nil)
            self.getRequestToken(loader: loader)
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    let apiKey = "7662169d6cde796d24b257cd0f8a268e"
    let getTokenMethod = "authentication/token/new"
    let baseURLSecureString = "https://api.themoviedb.org/3/"
    var requestToken = String()
    
    func getRequestToken(loader: UIAlertController) {
        let urlString = baseURLSecureString + getTokenMethod + "?api_key=" + apiKey
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(url: url as URL)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, downloadError in
            if let error = downloadError {
                DispatchQueue.main.async { [self] in
                    ui.labelMessage.text = "Login Failed. (Request token.)"
                    ui.viewlogin.isHidden = false
                    
                    ui.tableViewTV.isHidden = true
                    ui.viewScrollTV.isHidden = true
                    
                    ui.tableViewMovies.isHidden = true
                    ui.viewScroll.isHidden = true
                    
                }
                print("Could not complete the request \(error)")
            } else {
                let parsedResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                if let requestToken = parsedResult["request_token"] as? String {
                    self.requestToken = requestToken
                    print("requestToken ", self.requestToken)
                    self.loginWithToken(requestToken: self.requestToken, loader: loader)

                    // we will soon replace this successful block with a method call

                    DispatchQueue.main.async {
                        self.ui.labelMessage.text = "got request token: \(requestToken)"
                    }
                } else {
                    DispatchQueue.main.async { [self] in
                        ui.labelMessage.text = "Login Failed. (Request token.)"
                        ui.viewlogin.isHidden = false
                        
                        ui.tableViewTV.isHidden = true
                        ui.viewScrollTV.isHidden = true
                        
                        ui.tableViewMovies.isHidden = true
                        ui.viewScroll.isHidden = true
                    }
                    print("Could not find request_token in \(parsedResult)")
                }
            }
        }
        task.resume()
    }
    
    let loginMethod = "authentication/token/validate_with_login"

    // cambiar username y password por el de sus cuentas de TMDB
    func loginWithToken(requestToken: String, loader: UIAlertController) {
        let parameters = "?api_key=\(apiKey)&request_token=\(requestToken)&username=\(self.usernameSt)&password=\(self.passwordSt)"
//        let parameters = "?api_key=\(apiKey)&request_token=\(requestToken)&username=RicardoAD&password=123456aD"

        let urlString = baseURLSecureString + loginMethod + parameters
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(url: url as URL)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, downloadError in
            if let error = downloadError {
                DispatchQueue.main.async {
                    self.ui.labelMessage.text = "Login Failed. (Login Step.)"
                }
                print("Could not complete the request \(error)")
            } else {
                let parsedResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                if let success = parsedResult["success"] as? Bool {
                    // we will soon replace this successful block with a method call
                    self.getSessionID(requestToken: self.requestToken, loader: loader)
                    DispatchQueue.main.async {
                        self.ui.labelMessage.text = "Login status: \(success)"

                    }
                } else {
                    if let status_code = parsedResult["status_code"] as? Int {
                        DispatchQueue.main.async {
                            let message = parsedResult["status_message"]
                            self.ui.labelMessage.text = "\(status_code): \(message!)"
                        }
                    } else {
                        DispatchQueue.main.async { [self] in
                            ui.labelMessage.text = "Login Failed. (Login Step.)"
                            
                        }
                        print("Could not find success in \(parsedResult)")
                    }
                }
            }
        }
        task.resume()
    }
    
    let getSessionIdMethod = "authentication/session/new"
    var sessionID = String()

    func getSessionID(requestToken: String, loader: UIAlertController) {
        let parameters = "?api_key=\(apiKey)&request_token=\(requestToken)"
        let urlString = baseURLSecureString + getSessionIdMethod + parameters
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(url: url as URL)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, downloadError in
            if let error = downloadError {
                DispatchQueue.main.async {
                    self.ui.labelMessage.text = "Login Failed. (Session ID.)"
                    
                    
                }
                print("Could not complete the request \(error)")
            } else {
                let parsedResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                if let sessionID = parsedResult["session_id"] as? String {
                    self.sessionID = sessionID
                    // we will soon replace this successful block with a method call
                    print("sesion ID: ", sessionID)
                    self.getUserID(sessionID: self.sessionID, loader: loader)
                    DispatchQueue.main.async {
                        self.ui.labelMessage.text = "Session ID: \(sessionID)"
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        self.ui.labelMessage.text = "Login Failed. (Session ID.)"
                        
                    }
                    print("Could not find session_id in \(parsedResult)")
                }
            }
        }
        task.resume()
    }
    
    let getUserIdMethod = "account"
    var userID = Int()

    func getUserID(sessionID: String, loader: UIAlertController) {
        let urlString = baseURLSecureString + getUserIdMethod + "?api_key=" + apiKey + "&session_id=" + sessionID
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(url: url as URL)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, downloadError in
            if let error = downloadError {
                DispatchQueue.main.async {
                    self.ui.labelMessage.text = "Login Failed. (Get userID.)"
                }
                print("Could not complete the request \(error)")
            } else {
                let parsedResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                if let userID = parsedResult["id"] as? Int {
                    self.userID = userID
                                        
                    DispatchQueue.main.async {
                        self.navigationItem.title = "TMDB Movies"
                        self.navString = "Logout"
                        self.ui.labelMessage.text = "your user id: \(userID)"
                        self.completeLoginFavMovies(loader: loader)
                        self.completeLoginFavTV()
                        
                        self.getPopularMovies()
                        self.getPopularSeries()
                        
                        self.getRecomendacionMovies()
                        self.getRecomendacionTV()
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.ui.labelMessage.text = "Login Failed. (Get userID.)"
                    }
                    print("Could not find user id in \(parsedResult)")
                }
            }
        }
        task.resume()
    }
    
    func completeLoginFavMovies(loader: UIAlertController) {
        let getFavoritesMethod = "account/\(String(describing: self.userID))/favorite/movies"
        let urlString = baseURLSecureString + getFavoritesMethod + "?api_key=" + apiKey + "&session_id=" + sessionID
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(url: url as URL)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, downloadError in
            if let error = downloadError {
                DispatchQueue.main.async {
                    self.ui.labelMessage.text = "Cannot retrieve information about user \(String(describing: self.userID))."
                    self.ui.viewlogin.isHidden = false
                    
                    self.ui.tableViewTV.isHidden = true
                    self.ui.viewScrollTV.isHidden = true
                    
                    self.ui.tableViewMovies.isHidden = true
                    self.ui.viewScroll.isHidden = true
                    self.pausarLoader(loader: loader)
                    
                }
                print("Could not complete the request \(error)")
            } else {
                self.datalist.removeAll()
                do {
                    let result = try JSONDecoder().decode(MovieResult.self, from: data!)
                    DispatchQueue.main.async {
                        self.datalist = result.results

                        self.ui.tableViewMovies.reloadData()
                        self.savePersistenciaDataCrypet()


                        self.pausarLoader(loader: loader)
                        
                    }

                    print("movies favoritos ", result.results)

                } catch {
                    
                }
                
            }
        }
        task.resume()
    }
    
    
    func savePersistenciaDataCrypet() {
        let cryptedUsername = self.encrypt(textEncrypt: self.usernameSt, password: oncryptKey)
        let cryptedPassword = self.encrypt(textEncrypt: self.passwordSt, password: oncryptKey)
        let cryptedRequest = self.encrypt(textEncrypt: self.requestToken, password: oncryptKey)
        let cryptedSessionID = self.encrypt(textEncrypt: self.sessionID, password: oncryptKey)
        let cryptedUserID = self.encrypt(textEncrypt: String(self.userID), password: oncryptKey)

        UserDefaults.standard.set(cryptedUsername, forKey: self.userKeyDefault)
        UserDefaults.standard.set(cryptedPassword, forKey: self.passworKeyDefault)
        UserDefaults.standard.set(cryptedRequest, forKey: self.requestKeyDefault)
        UserDefaults.standard.set(cryptedSessionID, forKey: self.sessionIDKeyDefault)
        UserDefaults.standard.set(cryptedUserID, forKey: self.userIDKeyDefault)
        UserDefaults.standard.synchronize()
    }
    
    func getPersistenciaDataDecrypted(loader: UIAlertController) {
        let decryptedUsernameSt = UserDefaults.standard.string(forKey: self.userKeyDefault)!
        let decryptedPasswordSt = UserDefaults.standard.string(forKey: self.passworKeyDefault)!
        let decrypedRequestToken = UserDefaults.standard.string(forKey: self.requestKeyDefault)!
        let decryptedSessionID = UserDefaults.standard.string(forKey: self.sessionIDKeyDefault)!
        let decryptedUserID = UserDefaults.standard.string(forKey: self.userIDKeyDefault)!
        
        usernameSt = self.decrypt(oncryptedText: decryptedUsernameSt, password: oncryptKey)
        passwordSt = self.decrypt(oncryptedText: decryptedPasswordSt, password: oncryptKey)
        requestToken = self.decrypt(oncryptedText: decrypedRequestToken, password: oncryptKey)
        sessionID = self.decrypt(oncryptedText: decryptedSessionID, password: oncryptKey)
        userID = Int(self.decrypt(oncryptedText: decryptedUserID, password: oncryptKey))!
        
        DispatchQueue.main.async {
            self.getUserID(sessionID: self.sessionID, loader: loader)
//            self.completeLoginFavMovies(loader: loader)
//            self.completeLoginFavTV()
            
        }

    }
    
    func completeLoginFavTV() {
        let getFavoritesMethod = "account/\(String(describing: self.userID))/favorite/tv"
        let urlString = baseURLSecureString + getFavoritesMethod + "?api_key=" + apiKey + "&session_id=" + sessionID
        print("url tv: ", urlString)

        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(url: url as URL)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        self.datalistTV.removeAll()
        let task = session.dataTask(with: request as URLRequest) { data, response, downloadError in
            if let error = downloadError {
                DispatchQueue.main.async { [self] in
                    self.ui.labelMessage.text = "Cannot retrieve information about user \(String(describing: self.userID))."
                }
                print("Could not complete the request \(error)")
            } else {
                
                do {
                    let result = try JSONDecoder().decode(TVResultTop.self, from: data!)
                    DispatchQueue.main.async { [self] in
                        self.datalistTV = result.results

                        self.ui.tableViewTV.reloadData()
                    }

                } catch {
                    
                }
                
            }
        }
        task.resume()
    }
    
    func getRecomendacionMovies() {
        let recomendacionMovies = "https://api.themoviedb.org/3/movie/343611/recommendations?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"
//        let popularMovies = "https://api.themoviedb.org/3/movie/top_rated?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"

        URLSession.shared.dataTask(with: URLRequest(url: URL(string: recomendacionMovies)!)) {
            (data, req, error) in
            self.datalistTop_rated.removeAll()
            do {
                let result = try JSONDecoder().decode(MovieResultTopRated.self, from: data!)
                DispatchQueue.main.async { [self] in
                    self.datalistTop_rated = result.results
                    
                    self.ui.viewlogin.isHidden = true
                    self.ui.tableViewMovies.isHidden = false
                    self.ui.viewScroll.isHidden = false
                    self.navigationItem.rightBarButtonItem = nil
                    self.navigationitem()

//
                }
            } catch {
                
            }
        }.resume()
    }
    
    //Para obtener recomendaciones se escogio el ID de la serie de loki
    func getRecomendacionTV() {
        let recomendacionMovies = "https://api.themoviedb.org/3/tv/84958/recommendations?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"
//        let popularMovies = "https://api.themoviedb.org/3/movie/top_rated?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"

        self.datalistTop_ratedTV.removeAll()
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: recomendacionMovies)!)) {
            (data, req, error) in
            
            do {
                let result = try JSONDecoder().decode(TVResultTop.self, from: data!)
//                print("top_rated: ", result)
//                self.datalistTop_rated.removeAll()
                DispatchQueue.main.async {
                    self.datalistTop_ratedTV = result.results
                }
                
            } catch {
                
            }
        }.resume()
    }
    
    
    

    
    var timer = Timer()
    func getPopularMovies() {
        let popularMovies = "https://api.themoviedb.org/3/movie/top_rated?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"
//        let getFavoritesMethod = "account/\(String(describing: self.userID))/rated/movies"
//        let urlString = baseURLSecureString + getFavoritesMethod + "?api_key=" + apiKey + "&session_id=" + sessionID!
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: popularMovies)!)) {
            (data, req, error) in
            self.datalistPageSwipe.removeAll()
            do {
                let result = try JSONDecoder().decode(MovieResult.self, from: data!)
                print("top_rated: ", result)
                print("scroll page: ", result)

//                self.datalistTop_rated.removeAll()
                DispatchQueue.main.async { [self] in
                    self.datalistPageSwipe = result.results
                    ui.pageControl.numberOfPages = self.datalistPageSwipe.count
                    
                        for i in 0..<self.datalistPageSwipe.count{

                            let imageview = UIImageView()
                            imageview.contentMode = .scaleToFill
                            imageview.layer.cornerRadius = 20
                            imageview.clipsToBounds = true
                            imageview.tag = i
                            let urlimg = result.results[i].poster_path

                            self.actualizarDatos(imagenURL: urlimg, imagePelicula: imageview)

                            let xPos = CGFloat(i) * ui.viewScroll.frame.size.width
                            // add when rotate screen y cambiar imageview.frame el widht por height del viewespacio
                            switch UIDevice.current.userInterfaceIdiom {
                            case .phone:
                                imageview.frame = CGRect(x: xPos + 10, y: 0, width: ui.viewEspacio.frame.size.width - 20, height: ui.viewScroll.frame.size.height)
                                ui.viewScroll.contentSize.width = ui.viewEspacio.frame.size.width * CGFloat(i+1)

                            case .pad:
                                imageview.frame = CGRect(x: xPos + 10, y: 0, width: ui.viewEspacio.frame.size.width - 20, height: ui.viewScroll.frame.size.height)
                                ui.viewScroll.contentSize.width = ui.viewEspacio.frame.size.width * CGFloat(i+1)



                            default: break

                            }

                            ui.viewScroll.addSubview(imageview)
                            imageview.isUserInteractionEnabled = true

                            imageview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(tapGesture:)) )  )

                    }
                
                }
            } catch {
                
            }
        }.resume()
        
    }
    
    func getPopularSeries() {
        let urlTV = "https://api.themoviedb.org/3/tv/103768/recommendations?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"
//        let urlTV = "https://api.themoviedb.org/3/tv/top_rated?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"
//        let urlTV = "https://api.themoviedb.org/3/tv/popular?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"
//        let urlTV = "https://api.themoviedb.org/3/tv/popular?api_key=7662169d6cde796d24b257cd0f8a268e&language=en-US&page=1"

        self.datalistPageSwipeTV.removeAll()
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: urlTV)!)) {
            (data, req, error) in
            do {
                let result = try JSONDecoder().decode(TVResultTop.self, from: data!)
//                let myJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]


                DispatchQueue.main.async { [self] in
                    self.datalistPageSwipeTV = result.results
                    ui.pageControlTV.numberOfPages = self.datalistPageSwipeTV.count
//                    self.savePersistanceData(namePlist: "movfavoritos", data: myJson)
                        for i in 0..<self.datalistPageSwipeTV.count{

                            let imageview = UIImageView()
                            imageview.contentMode = .scaleToFill
                            imageview.layer.cornerRadius = 20
                            imageview.clipsToBounds = true
                            imageview.tag = i
                            let urlimg = result.results[i].poster_path

                            self.actualizarDatos(imagenURL: urlimg, imagePelicula: imageview)
                            let xPos = CGFloat(i) * ui.viewScrollTV.frame.size.width

                            // add when rotate screen y cambiar imageview.frame el widht por height del viewespacio
                            switch UIDevice.current.userInterfaceIdiom {
                            case .phone:
                                imageview.frame = CGRect(x: xPos + 10, y: 0, width: ui.viewEspacioTV.frame.size.width - 20, height: ui.viewScrollTV.frame.size.height)
                                ui.viewScrollTV.contentSize.width = ui.viewEspacioTV.frame.size.width * CGFloat(i+1)

                            case .pad:
                                imageview.frame = CGRect(x: xPos + 10, y: 0, width: ui.viewEspacioTV.frame.size.width - 20, height: ui.viewScrollTV.frame.size.height + 150)
                                ui.viewScrollTV.contentSize.width = ui.viewEspacioTV.frame.size.width * CGFloat(i+1)

                            default: break

                            }

                            ui.viewScrollTV.addSubview(imageview)
                            imageview.isUserInteractionEnabled = true

                            imageview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTapTV(tapGesture:)) )  )

                    }
                
                }
            } catch {
                
            }
        }.resume()
        
        
    }
    

    @objc func handleTap(tapGesture: UITapGestureRecognizer) {
        let imageView = tapGesture.view as? UIImageView
        let VC = DetailsViewController()
        VC.getDataItems(datalistPageSwipe[imageView!.tag])
        VC.getImagePath(movie_ID: datalistPageSwipe[imageView!.tag].id)
//        print("pelicula movieID: ", datalistPageSwipe[imageView!.tag].id)
        self.present(VC, animated: true, completion: nil)
                
    }
    
    @objc func handleTapTV(tapGesture: UITapGestureRecognizer) {
        let imageView = tapGesture.view as? UIImageView
        let VC = DetailsViewController()
        VC.getDataItemsTV(data: datalistPageSwipeTV[imageView!.tag])
        VC.getImagePathTV(TV_ID: datalistPageSwipeTV[imageView!.tag].id)
        self.present(VC, animated: true, completion: nil)
                
    }
    
    private func actualizarDatos(imagenURL: String?, imagePelicula: UIImageView) {
        let urlString = "https://image.tmdb.org/t/p/w300" + imagenURL!
        imagePelicula.image = UIImage(systemName: "photo")
        
        imagePelicula.image = nil
        imagePelicula.loadimagenUsandoCacheConURLString(urlString: urlString)

    }
    
    


}


