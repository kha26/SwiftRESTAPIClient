//
//  ViewController.swift
//  SwiftRestAPIClient
//
//  Created by kha26 on 07/08/2018.
//  Copyright (c) 2018 kha26. All rights reserved.
//

import SwiftRestAPIClient

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _ = APIClient.shared.send(GetWorkouts(), reponseBlock: { (response) in
            switch response {
            case .success(let workouts):
                print("Got Workouts");
                for workout in workouts {
                    print(workout.name)
                }
            case .failure(let error):
                print(error);
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

