//
//  PokemonDetailViewController.swift
//  NotDigimonObjectiveC
//
//  Created by Lambda_School_Loaner_268 on 5/23/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var Identifier: UILabel!
    
    @IBOutlet var abilities: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var Sprite: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
