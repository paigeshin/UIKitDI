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

