//
//  ViewController.swift
//  TestUIConstraint
//
//  Created by Gavin Ong on 18/7/18.
//  Copyright © 2018 Gavin Ong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!

    var message = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }

    
    func setupCollectionView(){
        
        self.collectionView.register(UINib(nibName:"MessageCollectionViewCell",bundle:nil), forCellWithReuseIdentifier: "cell")
        //self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let layout = self.collectionView.collectionViewLayout as! MessageCollectionViewLayout
        
        layout.delegate = self
        
        //layout.numberOfColumns = 1
        
        collectionView.clipsToBounds = false
    
        
        getChatLogs()
        

    }
    
    func getChatLogs(){
        
        //get chat log from API
        
        let message1 = Message(date: Date(), text: "Hello World ashashashshahsahashashashashashashashhashsahashasaasassaassaassaasassasasaasassaassasaasassasgavinsajjasjasjasjasjasongongongongongahhsahashashashasgavinsaddsadasadsadsadsasdasdadsasdsddasdadsdassdadadasfacebookadsdassdaasddasfb", isSender: false)
        let message2 = Message(date: Date(), text: "l", isSender: true)
        let message3 = Message(date: Date(), text:"ashashashshahsahashashashashashashashhashsahashasaasassaassaassaasassasasaasassaassasaasassasgavinsajjasjasjasjasjasongongongongongahhsahashashashasgavinsaddsadasadsadsadsasdasdadsasdsddasdadsdassdadadasfacebookadsdassdaasddasfb", isSender: true)
        
        
        self.message = [message1, message2, message3]
        
    
    }
    

}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.message.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MessageCollectionViewCell
    
        if let messageText = self.message[indexPath.row].text, let isSender = self.message[indexPath.row].isSender{
            
              cell.chatLogMessageTextView.text = messageText
            
            cell.profileImageView.image = UIImage(named:"icons8-sort-up-filled-50")
            
//            cell.translatesAutoresizingMaskIntoConstraints = false
//            cell.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
//            cell.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
//            cell.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
//            cell.heightAnchor.constraint(equalTo: collectionView.heightAnchor).isActive = true
            
            

     
        
            if  !isSender{
            
            }else{
                
               // let estimatedFrame = calculateMessageTextWidthAndHeight(messageText: messageText)
                
                //cell.frame.origin.x = collectionView.frame.maxX / 2
                
             //   cell.frame.origin.x = collectionView.frame.maxX / 2
                
                //cell.frame = CGRect(x: collectionView.frame.maxX / 2, y: collectionView.frame.origin.y, width: 150, height: 150)
            }
            

        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
        return UIEdgeInsetsMake(0 ,0, 0, 0)
    }
    

    
    func calculateMessageTextWidthAndHeight(messageText: String) -> CGRect{
        
        let size = CGSize(width: self.view.frame.width / 2, height: self.view.frame.height) // give the width for the cell
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        
        return estimatedFrame
    }

}

extension ViewController: MessageCollectionViewLayoutDelegate{
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        // calculate the height of the text
        //let heightArray: [CGFloat] = [100, 150, 50]
        
        var estimatedFrame = CGRect()
        
        if let messageText = self.message[indexPath.row].text{
            
            estimatedFrame = self.calculateMessageTextWidthAndHeight(messageText: messageText)
            
        }
        
   
        return estimatedFrame.height + 15
    }
    
    func collectionView(collectionView: UICollectionView, widthForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        //get the height of the text view string
        
//        return self.view.frame.width / 2
        var estimatedFrame = CGRect()
        
        if let messageText = self.message[indexPath.row].text{
            
            estimatedFrame = self.calculateMessageTextWidthAndHeight(messageText: messageText)
            
            if estimatedFrame.width <= 30{
                return 80
            }
    
        }
        
        return estimatedFrame.width + 15
        
    }
    
    
    func contentInsets() -> UIEdgeInsets{
        
        return UIEdgeInsetsMake(20, 20, 20, 20)
        
        
        
        
    }
    
    
    
    func isSender(indexPath: IndexPath) -> Bool{
 
        return self.message[indexPath.row].isSender!
    }
    


}

