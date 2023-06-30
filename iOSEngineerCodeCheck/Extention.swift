import Foundation

protocol RootViewControllerProtocol: AnyObject {
    func getRepoInfo(wordParams: String)
}

extension RootViewController: RootViewControllerProtocol{
    
    func getRepoInfo(wordParams: String) {        
        let url = "https://api.github.com/search/repositories?q=\(wordParams)"
        task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            if let response = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                if let items = response["items"] as? [[String: Any]] {
                    self.repositoriesArray = items
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
}
