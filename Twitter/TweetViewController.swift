//
//  TweetViewController.swift
//  Twitter
//
//  Created by Pernille Dahl on 2/21/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var charLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var tweetArray = [NSDictionary]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.text = "What's happening?"
        tweetTextView.textColor = UIColor.lightGray
        tweetTextView.delegate = self

        tweetTextView.layer.borderWidth = 2
        tweetTextView.layer.borderColor = UIColor.lightGray.cgColor
        tweetTextView.layer.cornerRadius = 25
        tweetTextView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
        
        profileImage.layer.cornerRadius = self.profileImage.frame.width/2.0
        profileImage.clipsToBounds = true
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
//        cell.usernameLabel.text = user["name"] as? String
//        cell.tweetLabel.text = tweetArray[indexPath.row]["text"] as? String
        
        
        let imageUrl = URL(string: ((user["profile_image_url_https"] as? String)!))
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        
//        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
//        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
//        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        
        return cell
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
          let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let change = 140 - newText.count
        self.charLabel.text = String(format: "%d / 140", change)
         return newText.count < 140
     }
  
    
    func tapTextView(sender: UITapGestureRecognizer){
        tweetTextView.becomeFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if tweetTextView.textColor == UIColor.lightGray {
            tweetTextView.text = nil
            tweetTextView.textColor = UIColor.black
        }
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error in posting")
                self.dismiss(animated: true, completion: nil)
            })
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
