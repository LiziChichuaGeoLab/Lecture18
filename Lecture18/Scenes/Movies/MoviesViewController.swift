//
//  MoviesViewController.swift
//  Lecture18
//
//  Created by LiziChichua on 25.12.22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var apiManager: MovieAPIManagerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager = MovieAPIManager()
        
        apiManager?.fetchMovies(with: .upcoming, completion: { result in
            switch result {
            case .success(let movieResponse):
                print(movieResponse.movies)
            case .failure(let error):
                print(error)
            }
        })
    }
}

