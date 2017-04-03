//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by kathy yin on 4/2/17.
//  Copyright © 2017 kathy. All rights reserved.
//

import UIKit
import AFNetworking
class MovieDetailViewController: UIViewController {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    var movie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.posterView.setImageWith(URL(string:(movie?.imageUrl)!)!)
        self.movieOverview.text = movie?.overview
        self.movieTitle.text = movie?.title
        self.movieOverview.sizeToFit()
        
        self.infoView.frame.origin.y = self.posterView.frame.origin.y + self.posterView.frame.size.height
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: infoView.frame.origin.y + infoView.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
