//
//  MovieViewModel.swift
//  GoNet Examen
//
//  Created by A on 24/11/21.
//

import Foundation

class MoviewViewModel {
    private var popularMovies = [Movie]()

    func obtenerDatosPeliculas(completion: @escaping () -> ()) {
//        apiService.obtenerPopularMoviews { [weak self] (result) in
//            switch result {
//            case .success(let listOf):
//                self?.popularMovies = listOf.movies
//                completion()
//            case .failure(let error):
//                print("Error processing json data: \(error)")
//            }
//        }
//        
    }
    
    
    
    func numberOfRowsInSection(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Movie {
        return popularMovies[indexPath.row]
    }
    
}
