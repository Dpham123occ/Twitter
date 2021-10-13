//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Pham Duy on 10/7/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    
    @IBOutlet weak var reTweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func favoriteTweet(_ sender: Any) {
        
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweedId: tweetId, success: { self.setFavorite(isFavorited: true)
                
            }, failure: { (error) in
                print("favorite didnt succeed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweedId: tweetId, success: { self.setFavorite(isFavorited: false)
            }, failure: { (error) in
                print("unfavorite didnt succeed: \(error)")
            })
        }
        
    }
    
    var favorited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    func setFavorite(   isFavorited:Bool) {
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(  isRetweeted:Bool){
        if (isRetweeted) {
            reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for:UIControl.State.normal )
            reTweetButton.isEnabled = false
        } else {
            reTweetButton.setImage(UIImage(named: "retweet-icon"), for:UIControl.State.normal )
            reTweetButton.isEnabled = true
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        
        TwitterAPICaller.client?.retweet(tweedId: tweetId, success: { self.setRetweeted(isRetweeted: true)
            
        }, failure: { (error) in
            print("error in retweet: \(error)")
        })
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
