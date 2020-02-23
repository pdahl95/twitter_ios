//
//  TweetCell.swift
//  Twitter
//
//  Created by Pernille Dahl on 2/13/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var favortieButton: UIButton!
    @IBOutlet weak var reTweetButton: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    
    
    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        if favorited {
            favortieButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else{
            favortieButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)

        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error retweeting")
        })
    }
    
    func setRetweeted(_  isRetweeted:Bool){
        if isRetweeted {
            reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            reTweetButton.isEnabled = false
        }else {
            reTweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            reTweetButton.isEnabled = true
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavored = !favorited
        if toBeFavored {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favor did not succeed")
            })
        }else{
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("unFavor did not succeed")
            })
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
