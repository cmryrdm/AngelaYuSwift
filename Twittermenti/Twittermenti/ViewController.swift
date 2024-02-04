//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
  
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var sentimentLabel: UILabel!
  
  let sentimentClassifier = TweetSentimentClassifier()
  let swifter = Swifter(consumerKey: Const.TWITTER_CONSUMER_KEY, consumerSecret: Const.TWITTER_CONSUMER_SECRET)
  let tweetCount = 100
  let tweetLang = "en"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //    let prediction = try! sentimentClassifier.prediction(text: "nice to have @AAPL stocks.")
    //    print(prediction.label)
  }
  
  @IBAction func predictPressed(_ sender: Any) {
    fetchTweets()
  }
  
  func fetchTweets() {
    if let searchText = textField.text {
      swifter.searchTweet(using: searchText, lang: tweetLang, count: tweetCount, tweetMode: .extended) { [weak self] results, metaData in
        //      print(results)
        var tweets = [TweetSentimentClassifierInput]()
        for index in 0..<self!.tweetCount {
          if let tweet = results[index]["full_text"].string {
            let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
            tweets.append(tweetForClassification)
          }
        }
        
        self?.makePredictions(with: tweets)
        
      } failure: { error in
        print("Twitter API request error: \(error.localizedDescription)")
      }
    }
  }
  
  func makePredictions(with tweets: [TweetSentimentClassifierInput]) {
    do {
      let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
      var sentimentScore = 0
//        print(predictions[0].label)
      for pred in predictions {
        let sentiment = pred.label
        if sentiment == "Pos" {
          sentimentScore += 1
        } else if sentiment == "Neg" {
          sentimentScore -= 1
        }
      }
      updateUI(with: sentimentScore)
      
    } catch  {
      print("prediction error!")
    }
  }
  
  func updateUI(with sentimentScore: Int) {
    if sentimentScore > 0 {
      sentimentLabel.text = "🙂"
    } else if sentimentScore < 0 {
      sentimentLabel.text = "🙁"
    } else {
      sentimentLabel.text = "😐"
    }
  }
  
}

