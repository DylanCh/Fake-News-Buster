//
//  AnalyzeViewController.swift
//  Fake News Buster
//
//  Created by Hanjun Chen on 6/24/17.
//  Copyright © 2017 dylanhelps.com. All rights reserved.
//

import UIKit

class AnalyzeViewController: UIViewController {

    @IBOutlet weak var articleBodyWebView: UIWebView!
    @IBOutlet weak var sourceEditText: UITextField!
    @IBOutlet weak var articleBodyEditText: UITextView!
    @IBOutlet weak var titleEditText: UITextField!
    
    func extractSource()->String{
        return String(describing: NSURL(string:url)!.host);
    }
    
    @IBAction func fakeOrNotTapped(_ sender: Any) {
        // TODO: send text to the next page to make a request langAnalyze
        let resultPage = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController;
        resultPage.textToAnalyze = self.textToAnalyze;
        navigationController?.pushViewController(resultPage, animated: true);
    }
    
    var url = "";
    var textToAnalyze = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("URL is "+url);
        sourceEditText.text = extractSource();
        let requestUrlString = "http://Sample-env-3.pixfhe7yjs.us-east-1.elasticbeanstalk.com/getContent?url="+url;
        let requestUrl = URL(string: requestUrlString);

        DispatchQueue.main.async(execute: { () -> Void in
            let session = URLSession.shared;
            let request = URLRequest(url: requestUrl!);
            let task = session.dataTask(with: request) { (data, _, _) -> Void in
                if let data = data {
                    self.textToAnalyze = String(data: data, encoding: String.Encoding.utf8)!
                    print(self.textToAnalyze) //JSONSerialization
                    //self.articleBodyEditText.text=self.textToAnalyze;
                    self.articleBodyWebView.loadRequest(NSURLRequest(url: NSURL(string: requestUrlString)! as URL) as URLRequest)
                }
                
            } // end dataTask
            task.resume();
        }) // end async
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
