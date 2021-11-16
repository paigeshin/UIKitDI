//
//  APICoaller.swift
//  APIKi
//
//  Created by paige on 2021/11/16.
//

import Foundation

// call data 
public class APICaller {
    public static let shared = APICaller()
    
    private init() {}
    
    public func fetchCourseNames(completion: @escaping([String]) -> Void) {
        guard let url = URL(string: "") else {
            completion([])
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: String]] else { return }
                let names = json.compactMap({$0["name"]})
                print(names)
                completion(names)
            } catch {
                completion([])
            }
        }
        task.resume()
    }
}
