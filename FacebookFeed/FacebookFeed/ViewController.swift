//
//  ViewController.swift
//  FacebookFeed
//
//  Created by Ajit Kumar Baral on 4/9/17.
//  Copyright © 2017 Ajit Kumar Baral. All rights reserved.
//

import UIKit


class Post {
    
    var name: String?
    var statusText: String?
    var profileImageString: String?
    var statusImageString: String?
    
}

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var posts = [Post]()
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let postAjit = Post()
        postAjit.name = "Ajit Kumar Baral"
        postAjit.statusText = "What an awesome day spent on the park. Hope to be there soon"
        postAjit.profileImageString = "ajit"
        postAjit.statusImageString = "ajit_status_image"
        
        
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.statusText = "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me. Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations.\n A photo of me with the iPad"
        postSteve.profileImageString = "steve_jobs"
        postSteve.statusImageString = "steve_jobs_status_image"
        
        
        posts.append(postAjit)
        posts.append(postSteve)
        
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        navigationItem.title = "Facebook Feed"
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        cell.post = posts[indexPath.row]
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let knownHeight: CGFloat = 380
        var estimatedHeightOfText: CGFloat = 0
        
        let post = posts[indexPath.item]
        //Getting the estimate height
        
        if let statusText = post.statusText {
            estimatedHeightOfText = estimateFrameForText(statusText).height
            
        }
        
        return CGSize(width: view.frame.width, height: knownHeight + estimatedHeightOfText)
    }
    
    
    //Change the layout orientation is changed
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
        
    }
    
    private func estimateFrameForText(_ text: String) -> CGRect {
        
        let size = CGSize(width: view.frame.width, height: 1000)
        
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: option, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    

}


class FeedCell: UICollectionViewCell {
    
    
    var post: Post? {
        
        didSet {
            
            if let name = post?.name {
                
                let attributeText = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
                
                
                
                attributeText.append(NSAttributedString(string: "\nDecember 18 • Sanfransisco • Public", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.rgb(red: 155, green: 161, blue: 171)]))
                
                
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                attributeText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributeText.string.characters.count))
                
                nameLabel.attributedText = attributeText
            }
            
            if let statusText = post?.statusText {
                statusTextView.text = statusText
            }
            
            if let profileImageString = post?.profileImageString {
                profileImageView.image = UIImage(named: profileImageString)
            }
            
            if let statusImageString = post?.statusImageString {
                statusImageView.image = UIImage(named: statusImageString)
            }
            
        }
    }
    
    
    let nameLabel: UILabel = {
       
        let label = UILabel()
        label.numberOfLines = 2
                label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let profileImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit //1:1 aspect ratio
        imageView.backgroundColor = UIColor.red
        imageView.image = UIImage(named: "ajit_profile.jpg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Having a nice view in the garden of dreams"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "status_image.jpg")
        imageView.backgroundColor = UIColor.red
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let likesCommentLabel: UILabel = {
       
        let label = UILabel()
        label.text = "488 Likes     10.7K Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerViewLine: UIView = {
       
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let buttonContainerView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let likeButton = FeedCell.buttonForTitle(title: "Like", imageName: "like")
    
    let commentButton = FeedCell.buttonForTitle(title: "Comment", imageName: "comment")
    
    let shareButton = FeedCell.buttonForTitle(title: "Share", imageName: "share")
    
    static func buttonForTitle(title: String, imageName: String) -> UIButton {
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.tintColor = UIColor.rgb(red: 143, green: 150, blue: 163)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    func setupViews() {
        backgroundColor = UIColor.white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentLabel)
        addSubview(dividerViewLine)
        addSubview(buttonContainerView)
        
        
        buttonContainerView.addSubview(likeButton)
        buttonContainerView.addSubview(commentButton)
        buttonContainerView.addSubview(shareButton)
        
        
        //x,y,width,height for profileImageView
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        //x,y,width,height for nameLabel
        
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        
        //x,y,width,height for statusTextView
        statusTextView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        statusTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        statusTextView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        statusTextView.bottomAnchor.constraint(equalTo: statusImageView.topAnchor).isActive = true
        
        
        //x,y,width,height for statusImageView
        statusImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        statusImageView.bottomAnchor.constraint(equalTo: likesCommentLabel.topAnchor, constant: -8).isActive = true
        statusImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        statusImageView.heightAnchor.constraint(equalToConstant: 215).isActive = true
        
        //x,y,width,height for likesCommentLabel
        
        likesCommentLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        likesCommentLabel.bottomAnchor.constraint(equalTo: dividerViewLine.topAnchor, constant: -8).isActive = true
        likesCommentLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        likesCommentLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        //x,y,width,height for dividerViewLine
        
        dividerViewLine.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dividerViewLine.bottomAnchor.constraint(equalTo: buttonContainerView.topAnchor, constant: -8).isActive = true
        
        dividerViewLine.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -16).isActive = true
        dividerViewLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
        //x,y,width,height for the buttonContainerView
        buttonContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        buttonContainerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        buttonContainerView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        //x,y,width,height for the likeButton
        likeButton.leftAnchor.constraint(equalTo: buttonContainerView.leftAnchor).isActive = true
        likeButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor).isActive = true
        likeButton.widthAnchor.constraint(equalTo: buttonContainerView.widthAnchor, multiplier: 1/3).isActive = true
        likeButton.heightAnchor.constraint(equalTo: buttonContainerView.heightAnchor).isActive = true
        
        //x,y,width,height for the commentButton
        commentButton.leftAnchor.constraint(equalTo: likeButton.rightAnchor).isActive = true
        commentButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor).isActive = true
        commentButton.widthAnchor.constraint(equalTo: buttonContainerView.widthAnchor, multiplier: 1/3).isActive = true
        commentButton.heightAnchor.constraint(equalTo: buttonContainerView.heightAnchor).isActive = true
        
        //x,y,width,height for the commentButton
        shareButton.leftAnchor.constraint(equalTo: commentButton.rightAnchor).isActive = true
        shareButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor).isActive = true
        shareButton.widthAnchor.constraint(equalTo: buttonContainerView.widthAnchor, multiplier: 1/3).isActive = true
        shareButton.heightAnchor.constraint(equalTo: buttonContainerView.heightAnchor).isActive = true
        
        
        

        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}














