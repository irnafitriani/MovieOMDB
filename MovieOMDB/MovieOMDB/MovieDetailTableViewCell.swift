//
//  MovieDetailTableViewCell.swift
//  MovieOMDB
//
//  Created by irna on 12/11/18.
//  Copyright © 2018 irna. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ model: Movie) {
        print(model)
        if let title = model.title {
             titleLabel.text = "Title : " + title
        }else {
            titleLabel.text = "Title : "
        }
        
        if let released = model.released {
            releasedLabel.text =  "Released : " + released
        }else {
            releasedLabel.text =  "Released : "
        }
        
        if let runtime = model.runtime{
            runtimeLabel.text = "Runtime : " + runtime
        } else {
            runtimeLabel.text = "Runtime : "
        }

        if let genre = model.genre{
            genreLabel.text = "Genre : " + genre
        } else {
            genreLabel.text = "Genre : "
        }

        if let director = model.director {
            directorLabel.text = "Director : " + director
        }else {
            directorLabel.text = "Director : "
        }
        
        if  let writer = model.director{
            writerLabel.text = "Writer : " + writer
        } else {
            writerLabel.text = "Writer : "
        }
        
        if let actor = model.actor{
            actorLabel.text = "Actor : " + actor
        } else {
            actorLabel.text = "Actor : "
        }
        
        if let plot = model.plot{
          plotLabel.text = "Plot : " + plot
        } else {
            plotLabel.text = "Plot : "
        }
    }
}
