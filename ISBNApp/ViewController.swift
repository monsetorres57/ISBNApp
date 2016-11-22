//
//  ViewController.swift
//  ISBNApp
//
//  Created by Monse on 19/11/16.
//  Copyright © 2016 Monse. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var result: UITextView!
    @IBOutlet weak var isbnText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        isbnText.delegate=self
        self.result.text! = " "
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        isbnText.resignFirstResponder()
        print(isbnText.text!)
        self.result.text! = " "
        asyncISBN()
        return true
    }

    func asyncISBN(){
     var valor = ""
     let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbnText.text!)"//978-84-376-0494-7
     let url = NSURL(string: urls)
     let session = NSURLSession.sharedSession()
        let bloque = {(datos:NSData?,resp:NSURLResponse?,error:NSError?)->Void in
        if(error != nil){
            print (error!)
            dispatch_async(dispatch_get_main_queue()) {
                self.result.text = "Error de conexión"
            }
            
         }
        if(datos != nil){
         let textoResp=NSString(data:datos!,encoding: NSUTF8StringEncoding)
         print(textoResp!)
         valor = textoResp! as String
            dispatch_async(dispatch_get_main_queue()) {
                self.result.text = valor
            }
 
         ///self.resultado.text = textoResp! as String
            }
        }
        
        let dt = session.dataTaskWithURL(url!,completionHandler: bloque)
        dt.resume()
        
    }

}

