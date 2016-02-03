//
//  ViewController.swift
//  Weather App
//
//  Created by su myat noe pwint on 31/01/2016.
//  Copyright © 2016 duplexIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var result: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        var wasSuccessful = false
        
        let attemptedURL = NSURL(string: "http://www.weather-forecast.com/locations/" +  city.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedURL {
        
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let urloutcome = data{
                    
                    let webContent = NSString(data: urloutcome, encoding: NSUTF8StringEncoding)
                    
                    let webSiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    if webSiteArray.count > 1 {
                        
                        let weatherArray = webSiteArray[1].componentsSeparatedByString("</span>")
                        
                        if weatherArray.count > 1 {
                            
                            wasSuccessful = true
                            
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                self.result.text = weatherSummary
                            
                            })
                            
                            
                            
                        }
                    }
                    
                    
                }
                if wasSuccessful == false{
                    
                    self.result.text = "Could not find information for " + self.city.text!  + " city. Please Try Again!"
                }

            }
            
            task.resume()
        
        }else {
        
            result.text = "Could not find information for the entered city. Please Try Again!"
        
        }
        
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

