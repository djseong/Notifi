//
//  APIService.swift
//  Notifi
//
//  Created by David Xu on 8/6/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class APIService{
    
    static var sharedInstance = APIService()
    
    func createMutableAnonRequest(url:NSURL!,method:String!,parameters:Dictionary<String, AnyObject>?) -> Request  {
        // build request
        let request = Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON)
        
        return request
    }
    
    func executeRequest (urlRequest:Request, presentingViewController:UIViewController? = nil, requestCompletionFunction:(Int,JSON) -> ())  {
        
        //add a loading overlay over the presenting view controller, as we are about to wait for a web request
        //presentingViewController?.addLoadingOverlay()
        
        urlRequest.responseJSON { returnedData -> Void in  //execute the request and give us JSON response data
            print(returnedData)
            //the web service is now done. Remove the loading overlay
            //presentingViewController?.removeLoadingOverlay()
            
            //Handle the response from the web service
            let success = returnedData.result.isSuccess
            if (success)    {
                
                var json = JSON(returnedData.result.value!)
                let serverResponseCode = returnedData.response!.statusCode //since the web service was a success, we know there is a .response value, so we can request the value gets unwrapped with .response!
                
                //                let headerData = returnedData.response?.allHeaderFields
                //                print ("token data \(headerData)")
                
                
//                if let validToken = returnedData.response!.allHeaderFields["Access-Token"] {
//                    let tokenJson:JSON = JSON(validToken)
//                    json["data"]["token"] = tokenJson
//                }
//                if let validClient = returnedData.response!.allHeaderFields["Client"] as? String    {
//                    let clientJson:JSON = JSON(validClient)
//                    json["data"]["client"] = clientJson
//                }
                
                if (self.handleCommonResponses(serverResponseCode, presentingViewController: presentingViewController))    {
                    //print to the console that we experienced a common erroneos response
                    print("A common bad server response was found, error has been displayed")
                    
                }
                
                //execute the completion function specified by the class that called this executeRequest function
                //the
                requestCompletionFunction(serverResponseCode,json)
                
            }   else    { //response code is nil - The web service couldn't connect to the internet. Show a "Connection Error" alert, assuming the presentingViewController was given (a UIViewController provided as the presentingViewController parameter provides the ability to show an alert)
                let alert = self.connectionErrorAlert()
                presentingViewController?.presentViewController(alert, animated: true, completion: nil)
                //execute the completion function specified by the class that called this executeRequest function
                requestCompletionFunction(0,JSON(""))
            }
        }
    }
    func connectionErrorAlert() -> UIAlertController {
        let alert = UIAlertController(title:"Connection Error", message:"Not connected", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        return alert
    }
    func server500Alert() -> UIAlertController {
        let alert = UIAlertController(title:"Oh Dear", message:"There was an problem handling your request", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        return alert
    }
    
    func handleCommonResponses(responseCode:Int, presentingViewController:UIViewController?) -> Bool {
        //handle session expiry
        if (responseCode == 302)   {
            
            //we are not going to experience this response, yet. This code will never execute
            return true
            
            
        }   else if (responseCode == 500)  {
            
            if let vc = presentingViewController   {
                
                let alert = server500Alert()
                vc.presentViewController(alert, animated: true, completion: nil)
                return true
            }
            
            
        }
        
        return false //returning false indicates that no errors were detected
    }

    
 
}