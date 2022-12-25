//
//  MovieAPIManager.swift
//  Lecture18
//
//  Created by LiziChichua on 25.12.22.
//

import Foundation

/*
 https://api.themoviedb.org/3/movie/upcoming?api_key=9d4be65a0a14784f73ea7a1e4f978ea0
 https://api.themoviedb.org/3/movie/top_rated?api_key=9d4be65a0a14784f73ea7a1e4f978ea0
 https://api.themoviedb.org/3/movie/popular?api_key=9d4be65a0a14784f73ea7a1e4f978ea0
 */

enum MovieCategory: Int, CaseIterable {
    case upcoming = 0
    case topRated
    case popular
    
    var queryParam: String {
        switch self {
        case .upcoming:
            return "upcoming"
        case .topRated:
            return "top_rated"
        case .popular:
            return "popular"
        }
    }
}

protocol MovieAPIManagerProtocol {
    func fetchMovies(with category: MovieCategory, completion: @escaping (Result<MovieResponse, Error>) -> ())
}

class MovieAPIManager: MovieAPIManagerProtocol {
    func fetchMovies(with category: MovieCategory, completion: @escaping (Result<MovieResponse, Error>) -> ()) {
        let urlString = "https://api.themoviedb.org/3/movie/\(category.queryParam)?api_key=9d4be65a0a14784f73ea7a1e4f978ea0"
        
        guard let urll = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: urll) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
