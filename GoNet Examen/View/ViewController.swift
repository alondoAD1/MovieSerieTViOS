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
        tableView.delegate = self
        tableView.dataSource = self
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
        tableView.delegate = self
        tableView.dataSource = self
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
        text.delegate = self
        text.placeholder = "Nombre de usuario"
        text.borderStyle = .roundedRect
        text.isEnabled = true
//        text.textColor = UIColor.lightGray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var password: UITextField = {
        let text = UITextField()
        text.delegate = self
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
        btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.loginFuncion)))
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
    
    var toogleSgmt = false
    @objc func segmentClick(tapGesture: UITapGestureRecognizer) {
        if toogleSgmt == false {
            toogleSgmt = true
            segmentBtn.selectedSegmentIndex = 1
            tableViewMovies.isHidden = true
            viewEspacio.isHidden = true
            tableViewTV.isHidden = false
            viewEspacioTV.isHidden = false
            
        } else {
            toogleSgmt = false
            segmentBtn.selectedSegmentIndex = 0
            tableViewMovies.isHidden = false
            viewEspacio.isHidden = false
            tableViewTV.isHidden = true
            viewEspacioTV.isHidden = true
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
        if tableView == tableViewMovies {
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
        if tableView == tableViewMovies {
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
            self.viewlogin.isHidden = false
            self.tableViewMovies.isHidden = true
            self.viewScroll.isHidden = true
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
                        self.viewlogin.isHidden = false
                        self.tableViewMovies.isHidden = true
                        self.viewScroll.isHidden = true


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
        
        btnMyAccount.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.loginInvitado)))

        guard let navigationController = navigationController else { return }
            navigationController.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController.navigationBar.sizeToFit()
        
        self.view.backgroundColor = UIColor(named: "bafound")
        
        LayoutConstraint()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(segmentClick))
        tapGesture.numberOfTapsRequired = 1
        segmentBtn.addGestureRecognizer(tapGesture)
        

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
        
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = "Login"
            self.viewlogin.isHidden = false
            self.tableViewMovies.isHidden = true
            self.viewScroll.isHidden = true
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
        usernameSt = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        passwordSt = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if username.text!.isEmpty {
            labelMessage.text = "Nombre de usuario vacio."
        } else if password.text!.isEmpty {
            labelMessage.text = "Contraseña vacio."
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
                DispatchQueue.main.async {
                    self.labelMessage.text = "Login Failed. (Request token.)"
                    self.viewlogin.isHidden = false
                    
                    self.tableViewTV.isHidden = true
                    self.viewScrollTV.isHidden = true
                    
                    self.tableViewMovies.isHidden = true
                    self.viewScroll.isHidden = true
                    
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
                        self.labelMessage.text = "got request token: \(requestToken)"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.labelMessage.text = "Login Failed. (Request token.)"
                        self.viewlogin.isHidden = false
                        
                        self.tableViewTV.isHidden = true
                        self.viewScrollTV.isHidden = true
                        
                        self.tableViewMovies.isHidden = true
                        self.viewScroll.isHidden = true
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
                    self.labelMessage.text = "Login Failed. (Login Step.)"
                }
                print("Could not complete the request \(error)")
            } else {
                let parsedResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                if let success = parsedResult["success"] as? Bool {
                    // we will soon replace this successful block with a method call
                    self.getSessionID(requestToken: self.requestToken, loader: loader)
                    DispatchQueue.main.async {
                        self.labelMessage.text = "Login status: \(success)"

                    }
                } else {
                    if let status_code = parsedResult["status_code"] as? Int {
                        DispatchQueue.main.async {
                            let message = parsedResult["status_message"]
                            self.labelMessage.text = "\(status_code): \(message!)"
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.labelMessage.text = "Login Failed. (Login Step.)"
                            
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
                    self.labelMessage.text = "Login Failed. (Session ID.)"
                    
                    
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
                        self.labelMessage.text = "Session ID: \(sessionID)"
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        self.labelMessage.text = "Login Failed. (Session ID.)"
                        
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
                    self.labelMessage.text = "Login Failed. (Get userID.)"
                }
                print("Could not complete the request \(error)")
            } else {
                let parsedResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                if let userID = parsedResult["id"] as? Int {
                    self.userID = userID
                                        
                    DispatchQueue.main.async {
                        self.navigationItem.title = "TMDB Movies"
                        self.navString = "Logout"
                        self.labelMessage.text = "your user id: \(userID)"
                        self.completeLoginFavMovies(loader: loader)
                        self.completeLoginFavTV()
                        
                        self.getPopularMovies()
                        self.getPopularSeries()
                        
                        self.getRecomendacionMovies()
                        self.getRecomendacionTV()
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.labelMessage.text = "Login Failed. (Get userID.)"
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
                    self.labelMessage.text = "Cannot retrieve information about user \(String(describing: self.userID))."
                    self.viewlogin.isHidden = false
                    
                    self.tableViewTV.isHidden = true
                    self.viewScrollTV.isHidden = true
                    
                    self.tableViewMovies.isHidden = true
                    self.viewScroll.isHidden = true
                    self.pausarLoader(loader: loader)
                    
                }
                print("Could not complete the request \(error)")
            } else {
                self.datalist.removeAll()
                do {
                    let result = try JSONDecoder().decode(MovieResult.self, from: data!)
                    DispatchQueue.main.async {
                        self.datalist = result.results

                        self.tableViewMovies.reloadData()
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
                DispatchQueue.main.async {
                    self.labelMessage.text = "Cannot retrieve information about user \(String(describing: self.userID))."
                }
                print("Could not complete the request \(error)")
            } else {
                
                do {
                    let result = try JSONDecoder().decode(TVResultTop.self, from: data!)
                    DispatchQueue.main.async {
                        self.datalistTV = result.results

                        self.tableViewTV.reloadData()
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
                DispatchQueue.main.async {
                    self.datalistTop_rated = result.results
                    
                    self.viewlogin.isHidden = true
                    self.tableViewMovies.isHidden = false
                    self.viewScroll.isHidden = false
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
                DispatchQueue.main.async {
                    self.datalistPageSwipe = result.results
                    self.pageControl.numberOfPages = self.datalistPageSwipe.count
                    
                        for i in 0..<self.datalistPageSwipe.count{

                            let imageview = UIImageView()
                            imageview.contentMode = .scaleToFill
                            imageview.layer.cornerRadius = 20
                            imageview.clipsToBounds = true
                            imageview.tag = i
                            let urlimg = result.results[i].poster_path

                            self.actualizarDatos(imagenURL: urlimg, imagePelicula: imageview)

                            let xPos = CGFloat(i) * self.viewScroll.frame.size.width
                            // add when rotate screen y cambiar imageview.frame el widht por height del viewespacio
                            switch UIDevice.current.userInterfaceIdiom {
                            case .phone:
                                imageview.frame = CGRect(x: xPos + 10, y: 0, width: self.viewEspacio.frame.size.width - 20, height: self.viewScroll.frame.size.height)
                                self.viewScroll.contentSize.width = self.viewEspacio.frame.size.width * CGFloat(i+1)

                            case .pad:
                                imageview.frame = CGRect(x: xPos + 10, y: 0, width: self.viewEspacio.frame.size.width - 20, height: self.viewScroll.frame.size.height)
                                self.viewScroll.contentSize.width = self.viewEspacio.frame.size.width * CGFloat(i+1)



                            default: break

                            }

                            self.viewScroll.addSubview(imageview)
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


                DispatchQueue.main.async {
                    self.datalistPageSwipeTV = result.results
                    self.pageControlTV.numberOfPages = self.datalistPageSwipeTV.count
//                    self.savePersistanceData(namePlist: "movfavoritos", data: myJson)
                        for i in 0..<self.datalistPageSwipeTV.count{

                            let imageview = UIImageView()
                            imageview.contentMode = .scaleToFill
                            imageview.layer.cornerRadius = 20
                            imageview.clipsToBounds = true
                            imageview.tag = i
                            let urlimg = result.results[i].poster_path

                            self.actualizarDatos(imagenURL: urlimg, imagePelicula: imageview)
                            let xPos = CGFloat(i) * self.viewScrollTV.frame.size.width

                            // add when rotate screen y cambiar imageview.frame el widht por height del viewespacio
                            switch UIDevice.current.userInterfaceIdiom {
                            case .phone:
                                imageview.frame = CGRect(x: xPos + 10, y: 0, width: self.viewEspacioTV.frame.size.width - 20, height: self.viewScrollTV.frame.size.height)
                                self.viewScrollTV.contentSize.width = self.viewEspacioTV.frame.size.width * CGFloat(i+1)

                            case .pad:
                                imageview.frame = CGRect(x: xPos + 10, y: 0, width: self.viewEspacioTV.frame.size.width - 20, height: self.viewScrollTV.frame.size.height + 150)
                                self.viewScrollTV.contentSize.width = self.viewEspacioTV.frame.size.width * CGFloat(i+1)

                            default: break

                            }

                            self.viewScrollTV.addSubview(imageview)
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
    
    func LayoutConstraint() {
        self.view.addSubview(scrollView)
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

        self.view.addSubview(viewlogin)
        self.viewlogin.addSubview(username)
        self.viewlogin.addSubview(password)
        self.viewlogin.addSubview(btnlogin)
        self.viewlogin.addSubview(labelMessage)
        self.viewlogin.addSubview(btnMyAccount)
                
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
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
            
            viewlogin.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            viewlogin.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            viewlogin.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            viewlogin.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
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
            
            labelMessage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            labelMessage.widthAnchor.constraint(equalToConstant: 150),
            labelMessage.centerXAnchor.constraint(equalTo: self.viewlogin.centerXAnchor),

            btnMyAccount.topAnchor.constraint(equalTo: self.btnlogin.bottomAnchor, constant: 20),
            btnMyAccount.widthAnchor.constraint(equalToConstant: self.view.frame.size.width),
            btnMyAccount.centerXAnchor.constraint(equalTo: self.viewlogin.centerXAnchor),
            
        ])
    }
    
 


}


