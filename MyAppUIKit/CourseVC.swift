//
//  CourseVC.swift
//  MyAppUIKit
//
//  Created by paige on 2021/11/16.
//

import UIKit
import APIKi

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
