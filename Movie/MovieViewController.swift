//
//  ViewController.swift
//  Movie
//
//  Created by kathy yin on 4/2/17.
//  Copyright © 2017 kathy. All rights reserved.
//

import UIKit
import AFNetworking



class MoviewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tablview setup
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = 120
        
        // add pull to refresh control
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(loadMovies), for: .valueChanged)
        loadMovies()
    }
    
    func loadMovies() {
        Movie.loadMovies(queryCategory: FetchType.nowPlaying, success: { [weak self](movies) in
            self?.movies = movies
            self?.tableView.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
        }) { [weak self] (error) in
            self?.tableView.refreshControl?.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movie.loadDetail" {
            
            let movieDetailViewController = segue.destination as! MovieDetailViewController
            let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
            movieDetailViewController.movie = movies[(indexPath?.row)!]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.codepath.moviecell", for: indexPath) as? MoveCell
        
        cell?.movieTitle.text = movies[indexPath.row].title
        cell?.movieOverview.text = movies[indexPath.row].overview
        let posterUrlStr = movies[indexPath.row].imageUrl
        let posterUrl = URL(string:posterUrlStr)
        cell?.posterView.setImageWith(posterUrl!)
        return cell!
    }
}

