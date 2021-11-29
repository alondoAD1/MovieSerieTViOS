//
//  imageURL.swift
//  GoNet Examen
//
//  Created by A on 26/11/21.
//

import Foundation
import UIKit
import RNCryptor

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadimagenUsandoCacheConURLString(urlString: String){
        
        self.image = nil
    
        //checar cache para la primer imagen
        
        if let cacheImagen = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cacheImagen
            return
            
        }
    
    let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                
                if error != nil {
                    print(error as Any)
                    return
                }
                
                
                
                DispatchQueue.main.async { // Correct

                    if let imageDescargada = UIImage(data: data){
                        imageCache.setObject(imageDescargada, forKey: urlString as AnyObject)
                        
                        self.image = imageDescargada

                    }
                }
            }
        }
        task.resume()
    
    
    }
    
}


extension UIViewController {
    func loader(message: String) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let loadingIndicador = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicador.hidesWhenStopped = true
        loadingIndicador.style = UIActivityIndicatorView.Style.large
        loadingIndicador.startAnimating()
        alert.view.addSubview(loadingIndicador)
        return alert
    }
    
    func pausarLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
    
    func erroAlert(message: String) {
        let alert = UIAlertController(title: "Atencion", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
}

let oncryptKey = "xDnMQpKDSREksd342JKS"
extension UIViewController {
    
    func encrypt(textEncrypt: String, password: String) -> String {
        let data: Data = textEncrypt.data(using: .utf8)!
        let encruptedData = RNCryptor.encrypt(data: data, withPassword: oncryptKey)
        let encryptedString: String = encruptedData.base64EncodedString()
        
        return encryptedString
    }
    
    func decrypt(oncryptedText: String, password: String) -> String {
        let mensaje = "Error al desencriptar"
        do {
            let data: Data = Data(base64Encoded: oncryptedText)!
            let decryptedData = try RNCryptor.decrypt(data: data, withPassword: password)
            let decryptedString = String(data: decryptedData, encoding: .utf8)
            return decryptedString ?? ""
        } catch {
            return mensaje
        }
                
    }
    
}
