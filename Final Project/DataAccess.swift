//
//  DataAccess.swift
//  Final Project
//
//  Created by Zach Biggs on 6/27/23.
//


import Foundation

//calls REST API to get all songs. Parses songs into the Song Class as a song list
func getAllSongs(completion: @escaping ([Song]?, Error?) -> Void) {
    guard let url = URL(string: "https://zbiggs.com/api/3260/song.php?apiCode=abcd1234") else {
        let error = NSError(domain: "Invalid URL", code: 0)
        completion(nil, error)
        return
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            let error = NSError(domain: "Invalid response", code: 0)
            completion(nil, error)
            return
        }
        
        if response.statusCode == 200 {
            // Request succeeded
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let songs = try decoder.decode([Song].self, from: data)
                    completion(songs, nil)
                }
                catch {
                    completion(nil, error)
                }
            }
        }
    }
    task.resume()
}

//Gets a specific song by its Id
func getSong(id: Int, completion: @escaping (Song?, Error?) -> Void)
{
    guard let url = URL(string: "https://zbiggs.com/api/3260/song.php?apiCode=abcd1234&id=\(id)") else {
        let error = NSError(domain: "Invalid URL", code: 0)
        completion(nil, error)
        return
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            let error = NSError(domain: "Invalid response", code: 0)
            completion(nil, error)
            return
        }
        
        if response.statusCode == 200 {
            // Request succeeded
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let song = try decoder.decode(Song.self, from: data)
                    completion(song, nil)
                }
                catch {
                    completion(nil, error)
                }
            }
        }
    }
    task.resume()
}

// Adds a new song to the DB via the API
func add(song: Song, completion: @escaping (Error?)-> Void) {
    guard let url = URL(string: "https://zbiggs.com/api/3260/song.php?apiCode=abcd1234") else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(error)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(song)
            print("\(jsonData)")
            request.httpBody = jsonData
        } catch {
            completion(error)
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                let error = NSError(domain: "Invalid response", code: 0, userInfo: nil)
                completion(error)
                return
            }
            
            completion(nil)
        }
    task.resume()
}

// Deletes a song via the api
func delete(song: Song, completion: @escaping (Error?)->Void) {
    guard let url = URL(string: "https://zbiggs.com/api/3260/song.php?apiCode=abcd1234") else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(error)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(song)
            request.httpBody = jsonData
        } catch {
            completion(error)
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                let error = NSError(domain: "Invalid response", code: 0, userInfo: nil)
                completion(error)
                return
            }
            
            completion(nil)
        }
    task.resume()
}

func update(song: Song, completion: @escaping (Error?)->Void) {
    guard let url = URL(string: "https://zbiggs.com/api/3260/song.php?apiCode=abcd1234") else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(error)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(song)
            print("\(jsonData)")
            request.httpBody = jsonData
        } catch {
            completion(error)
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                let error = NSError(domain: "Invalid response", code: 0, userInfo: nil)
                completion(error)
                return
            }
            
            completion(nil)
        }
    task.resume()
}
