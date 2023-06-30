//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var ImgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var languagesLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    
    var repositoryData = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let language = repositoryData["language"] as? String ?? ""
        let stargazers = repositoryData["stargazers_count"] as? Int ?? 0
        let wachers_count = repositoryData["wachers_count"] as? Int ?? 0
        let forks_count = repositoryData["forks_count"] as? Int ?? 0
        let open_issues_count = repositoryData["open_issues_count"] as? Int ?? 0
        
        languagesLabel.text = "Written in \(language)"
        starsLabel.text = "\(stargazers) stars"
        watchersLabel.text = "\(wachers_count) watchers"
        forksLabel.text = "\(forks_count) forks"
        issuesLabel.text = "\(open_issues_count) open issues"
        getImage()
        
    }
    
    private func getImage(){
        
        titleLabel.text = repositoryData["full_name"] as? String
        
        guard let owner = repositoryData["owner"] as? [String: Any] else {
            fatalError("owner not found")
        }
        
        guard let imgURL = owner["avatar_url"] as? String else {
            fatalError("avatar_url not found")
        }
        
        let task = URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
            guard let data = data else {
                fatalError("avatar_url not found")
            }
            let repoImage = UIImage(data: data)!
            Task {
              await MainActor.run {
                  self.ImgView.image = repoImage
              }
            }
        }
        
        task.resume()
        
    }
    
}
