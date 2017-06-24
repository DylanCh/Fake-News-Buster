//
//  ViewController.swift
//  Fake News Buster
//
//  Created by Hanjun Chen on 6/24/17.
//  Copyright © 2017 dylanhelps.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sourceUrlTextEdit: UITextField!
    
    
    @IBAction func analyzeBtnTapped(_ sender: Any) {
        if sourceUrlTextEdit.text == ""{
            let alertController = UIAlertController(title: "URL field is empty", message: "Please enter or paste news article in the text field", preferredStyle: .alert);
            alertController.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil));
            present(alertController, animated: true, completion: nil);
        }
        
        let url = sourceUrlTextEdit.text;
        let AnalyzeVC = storyboard?.instantiateViewController(withIdentifier: "AnalyzeViewController") as! AnalyzeViewController;
        AnalyzeVC.url = url!;
        navigationController?.pushViewController(AnalyzeVC, animated: true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

