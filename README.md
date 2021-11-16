# APICaller

```swift
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
```

# Dependency Injected

```swift
//
//  CourseVC.swift
//  MyAppUIKit
//
//  Created by paige on 2021/11/16.
//

import UIKit
import APIKit

public protocol DataFetchable {
    func fetchCourseNames(completion: @escaping ([String]) -> Void)
}

struct Course {
    let name: String
}

public class CourseVC: UIViewController {

    let dataFetchable: DataFetchable
    
    public init(dataFetchable: DataFetchable) {
        self.dataFetchable = dataFetchable
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        dataFetchable.fetchCourseNames { courses in
            print(courses)
        }
    }
    

}
```

# Inject

```swift
//
//  ViewController.swift
//  Dependency Injection
//
//  Created by paige on 2021/11/16.
//

import UIKit
import MyAppUIKit
import APIKi

extension APICaller: DataFetchable {}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        view.addSubview(button)
        button.setTitle("Tap Me", for: .normal)
        button.center = view.center
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .brown
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
    }

    @objc private func didTapButton() {
        let vc = CourseVC(dataFetchable: APICaller.shared)
        present(vc, animated: true)
    }

}
```
