//
//  PostController.swift
//  MyFavoriteApp23
//
//  Created by Karissa McDaris on 12/12/18.
//  Copyright © 2018 Karissa McDaris. All rights reserved.
//

import Foundation

class PostController {
    static let baseURL = URL(string: "https://favoriteapp-375c6.firebaseio.com/users")
    
    static func fetchPosts(completion: @escaping ([Post]?) -> Void) {
    
    guard let url = baseURL else {completion(nil) ; return}
        let fullURL = url.appendingPathExtension("json")
        
        var request = URLRequest(url: fullURL)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        print(request.url?.absoluteString ?? "⚠️ NO URL ⚠️")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function \(#function)")
                completion(nil)
                return
            }
            
            guard let data = data else {completion(nil) ; return}
            
            do{
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : [String : String]]
                let posts = jsonDictionary?.compactMap{Post(dictionary: $0.value)}
                completion(posts)
            } catch {
                print("\(error.localizedDescription) in \(#function)")
            }
        }.resume()
    }
    
    static func postReason(name: String, faveApp: String){
        guard let url = baseURL?.appendingPathExtension("json") else {return}
        
        let post = Post(name: name, favApp: faveApp)
        
        do {
        
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(post)
            var request = URLRequest(url: url)
            request.httpBody = data
            request.httpMethod = "POST"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("\(error.localizedDescription) \(error) in function \(#function)")
                }
                print(response ?? "⚠️ NO RESPONSE ⚠️")
                fetchPosts(completion: { (_) in
                })
            }.resume()
            
        } catch {
            print("There was an \(error): \(error.localizedDescription). Check function: \(#function)")
        }
    }
}
