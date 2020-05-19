//
//  ViewController.swift
//  AasthaDemoApp
//
//  Created by Justin Furstoss on 3/18/20.
//  Copyright © 2020 Justin Furstoss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    var branchInitParameters: NSDictionary? = nil {
        didSet {
            // If $canonical_url is not available i just put the ~referring_link to show which Branch Link is driving you
            mainView.setLinkParameters(withText: branchInitParameters?.description ?? "" )
            if let canonicalURL = branchInitParameters?.value(forKey: "$canonical_url") as? String {
                mainView.setCanonicalUrlLabel(withText: canonicalURL)
            }  else if let referringLinkURL = branchInitParameters?.value(forKey: "~referring_link") as? String {
                mainView.setCanonicalUrlLabel(withText: referringLinkURL)
            }
        }
    }
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViewHierarchy()
        setUpViewConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    //MARK: View Hierarchy
    private func setUpViewHierarchy() {
        view.addSubview(mainView)
    }
    //MARK: View Constraints
    private func setUpViewConstraints() {
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    //MARK: Helpers

    //MARK: Lazy Init
    internal lazy var mainView: View = {
        //MARK: Initialize view with Branch Paramaters
        let view = View()
        view.delegate = self
        return view
    }()
}
//MARK: View Delegate
extension ViewController: ViewDelegate {
    func didTapShareButton(_ view: View, sender: UIButton) {


    }
    func didTapGenerateQuickLinkButton(_ view: View, sender: UIButton) {

        
    }
    func didTapViewLinkParametersButton(_ view: View, sender: UIButton) {

    }
    func didTapEvent(_ view: View, sender: UIButton) {
        
        switch sender.tag {
        case EventType.commerce.rawValue:
            print("mParticle Commerce Event")
        case EventType.content.rawValue:
            print("mParticle Content Event")
        case EventType.lifecycle.rawValue:
            print("mParticle Lifecycle Event")
        case EventType.custom.rawValue:
            print("mParticle Custom Event")
        default:
            break
        }
    }
    
}

