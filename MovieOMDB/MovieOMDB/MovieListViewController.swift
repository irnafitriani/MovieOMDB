//
//  MovieListViewController.swift
//  MovieOMDB
//
//  Created by irna on 12/10/18.
//  Copyright © 2018 irna. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var flowLayout: ColumnFlowLayout!
    
    var dataResults = [Search?]()
    var page = 1
    var totalPage = 1
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.reloadData()
        
    }
    
    func callSearchApi(){
        API.searchMovies(searchText: searchText, page: page, completion: { results in
            
            for movie in results.search!{
                self.dataResults.append(movie)
            }
            
            self.page += 1
            self.collectionView.reloadData()
            
        })
    }
    
    func callSearchByTitleApi(title: String){
        API.searchByTitle(title: title, completion: { result in
            
            print(result)
            
        })
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

extension MovieListViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        guard let dataRow = self.dataResults[indexPath.row] else { return cell}
        cell.configure(dataRow)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let lastItem = self.dataResults.count - 1
        print(indexPath.row)
        if indexPath.row == lastItem{
            if page != totalPage + 1{
                self.callSearchApi()
            }
        }
    }
    
    // Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataRow = dataResults[indexPath.row]
        guard let title = dataRow?.title else { return }
        callSearchByTitleApi(title: title)
    }
}
