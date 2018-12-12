//
//  PostListTableViewController.swift
//  MyFavoriteApp23
//
//  Created by Karissa McDaris on 12/12/18.
//  Copyright © 2018 Karissa McDaris. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    var posts: [Post] = []

    fileprivate func reloadPosts() {
        PostController.fetchPosts { (posts) in
            DispatchQueue.main.async {
                self.posts = posts ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadPosts()
    }
    
    @IBAction func refreshPostsButtonTapped(_ sender: Any) {
        reloadPosts()
    }
    
    @IBAction func addPostsButtonTapped(_ sender: Any) {
        self.presentAddPostAlert()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        
        let post = posts[indexPath.row]
        
        cell.textLabel?.text = post.favApp
        cell.detailTextLabel?.text = post.name

        return cell
    }
    
    func presentAddPostAlert(){
        let addPostAlert = UIAlertController(title: "Post Your FavoriteApp!", message: "", preferredStyle: .alert)
        addPostAlert.addTextField { (nameTextField) in
            nameTextField.placeholder = "Enter your name here..."
        }
        addPostAlert.addTextField { (favAppTextField) in
            favAppTextField.placeholder = "Enter your favorite app here..."
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addPostAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let faveApp = addPostAlert.textFields?[1].text, !faveApp.isEmpty,
                let name = addPostAlert.textFields?[0].text, !name.isEmpty else {return}
            
            PostController.postReason(name:name, faveApp: faveApp)
        }
        addPostAlert.addAction(cancelAction)
        addPostAlert.addAction(addPostAction)
        
        self.present(addPostAlert, animated: true)
    }
}
