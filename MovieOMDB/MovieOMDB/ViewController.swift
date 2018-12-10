//
//  ViewController.swift
//  MovieOMDB
//
//  Created by irna on 12/9/18.
//  Copyright © 2018 irna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    
    var dataResults = [Search?]()
    var page = 1
    var totalPage = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callSearchApi(){
        self.dataResults.removeAll()
        guard let searchText = self.searchTextField.text else {return}
        API.searchMovies(searchText: searchText, page: page, completion: { results in
            guard let totalResults = results.totalResults else {return}
            self.totalPage = Int(totalResults)! / (results.search?.count)!
            
            for movie in results.search!{
                self.dataResults.append(movie)
            }
            self.page += 1
            
            self.performSegue(withIdentifier: "ShowMovieList", sender: self)
            
        })
    }

    @IBAction func btnSearchTapped(_ sender: Any) {
        callSearchApi()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieList"{
            let movieListVC = segue.destination as! MovieListViewController
            movieListVC.page = page
            movieListVC.totalPage = totalPage
            movieListVC.dataResults = dataResults
            movieListVC.searchText = searchTextField.text!
        }
    }
    
}

