//
//  MoviesViewController.swift
//  Lecture18
//
//  Created by LiziChichua on 25.12.22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieApiManager: MovieAPIManagerProtocol?
    var upcomingMovies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var topRatedMovies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var popularMovies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchMovies()
    }
    
    private func fetchMovies() {
        movieApiManager = MovieAPIManager()
        
        movieApiManager?.fetchMovies(with: .upcoming, completion: { result in
            switch result {
            case .success(let movieResponse):
                self.upcomingMovies = movieResponse.movies
            case .failure(let error):
                print(error)
            }
        })
        
        movieApiManager?.fetchMovies(with: .topRated, completion: { result in
            switch result {
            case .success(let movieResponse):
                self.topRatedMovies = movieResponse.movies
            case .failure(let error):
                print(error)
            }
        })
        
        movieApiManager?.fetchMovies(with: .popular, completion: { result in
            switch result {
            case .success(let movieResponse):
                self.popularMovies = movieResponse.movies
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.black
        
        tableView.register(UINib(nibName: "UpcomingTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "UpcomingTableViewCell")
        
        tableView.register(UINib(nibName: "TopRatedTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "TopRatedTableViewCell")
        
        tableView.register(UINib(nibName: "PopularTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "PopularTableViewCell")
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MovieCategory.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let category = MovieCategory(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch category {
        case .upcoming:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as? UpcomingTableViewCell
            cell?.movies = upcomingMovies
            return cell ?? UITableViewCell()
        case .topRated:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTableViewCell", for: indexPath) as? TopRatedTableViewCell
            cell?.movies = topRatedMovies
            return cell ?? UITableViewCell()
        case .popular:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as? PopularTableViewCell
            cell?.movies = popularMovies
            return cell ?? UITableViewCell()
        }
        
        
        
        // Bad Solution
        
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as? UpcomingTableViewCell
//            cell?.movies = upcomingMovies
//            return cell ?? UITableViewCell()
//        } else if indexPath.row == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTableViewCell", for: indexPath) as? TopRatedTableViewCell
//            cell?.movies = topRatedMovies
//            return cell ?? UITableViewCell()
//        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as? PopularTableViewCell
//        cell?.movies = popularMovies
//        return cell ?? UITableViewCell()
    }
}
