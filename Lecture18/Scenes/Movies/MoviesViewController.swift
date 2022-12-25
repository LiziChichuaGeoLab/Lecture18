//
//  MoviesViewController.swift
//  Lecture18
//
//  Created by LiziChichua on 25.12.22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var movieManager: MovieAPIManagerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieManager = MovieAPIManager()
        
        movieManager?.fetchMovies(with: .upcoming, completion: { result in
            switch result {
            case .success(let movieResponse):
                print(movieResponse.movies)
            case .failure(let error):
                print(error)
            }
        })
    }
}

