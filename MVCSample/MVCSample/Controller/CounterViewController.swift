//
//  ViewController.swift
//  MVCSample
//
//  Created by 이종선 on 9/8/24.
//

import UIKit

// Controller
class CounterViewController: UIViewController {
    let counter = Counter()
    var counterView: CounterView!
    
    override func loadView() {
        counterView = CounterView()
        view = counterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        
        counterView.button.addTarget(self, action: #selector(incrementCounter), for: .touchUpInside)
    }
    
    @objc func incrementCounter() {
        counter.increment()
        updateView()
    }
    
    func updateView() {
        counterView.label.text = "Count: \(counter.count)"
    }
}

