//
//  ResultViewController.swift
//  Fake News Buster
//
//  Created by Hanjun on 6/24/17.
//  Copyright © 2017 dylanhelps.com. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var neutralityEditText: UITextField!
    var textToAnalyze = "";
    @IBOutlet weak var languageEditText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestUrlString = "http://Sample-env-3.pixfhe7yjs.us-east-1.elasticbeanstalk.com/langAnalyze";
        let requestUrl = URL(string: requestUrlString);
        
        var values = [String]();
        
        var responseString="";
        
        // Get data
        DispatchQueue.main.async(execute: { () -> Void in
            var request = URLRequest(url: requestUrl!);
            request.httpMethod = "POST";
            let postString = "text="+self.textToAnalyze;
            request.httpBody = postString.data(using: .utf8);
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {  // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                responseString = String(data: data, encoding: .utf8)!;
                
                
            }// end task
            task.resume();
        });
        
        
        // Parse the JSON
        var score = "";
        var language = "";
//        do {
//            let data = responseString;
//            let json = try JSONSerialization.jsonObject(with: data,options: JSONSerialization.ReadingOptions = []) as? [String: Any];
//            score = json["score"] as? [[String: Any]];
//            language = json["language"] as? [[String: Any]];
//        } catch {
//            print("Error deserializing JSON: \(error)")
//        }
    }
    
    func displayAlert (alertMsg : String){
        // TODO: display the Alert
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
