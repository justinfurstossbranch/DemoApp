//
//  ViewController.swift
//  AasthaDemoApp
//
//  Created by Justin Furstoss on 3/18/20.
//  Copyright © 2020 Justin Furstoss. All rights reserved.
//

//MARK: Import Branch
import Branch
import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    var branchInitParameters: NSDictionary? = nil {
        didSet {
            // If $canonical_url is not available i just put the ~referring_link to show which Branch Link is driving you
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
        let view = View()
        view.delegate = self
        return view
    }()
}
//MARK: View Delegate
extension ViewController: ViewDelegate {
    func didTapShareButton(_ view: View, sender: UIButton) {
        //MARK: Call Branch Universal Object .showShareSheet along with Link Properties with the call back
        print("Share Sheet")
    }
    func didTapGenerateQuickLinkButton(_ view: View, sender: UIButton) {
        //MARK: Call Branch Universal Object .getShortUrl with the call back to then call view.setQuickLinkLabel with the url.absoluteString()
        print("Generate Quick Link")
    }
    func didTapViewLinkParametersButton(_ view: View, sender: UIButton) {
        //MARK: Pass the Params from the App Delegates Init session (branchInitParameters) through the view.setLinkParameters
        // I did this already to help with debugging
        view.setLinkParameters(withText: branchInitParameters?.description ?? "No Branch Init Parameters")
        print("View Link Parameters")
    }
    func didTapEvent(_ view: View, sender: UIButton) {
        //MARK: Switch based off of Event Type (Content, LifeCycle, Commerce, Custom)
        switch sender.tag {
        case EventType.commerce.rawValue:
            //MARK: Create BUO and Branch Commerce Event
            print("Commerce Event Logged")
        case EventType.content.rawValue:
            //MARK: Create Branch Content Event
            print("Content Event Logged")
        case EventType.lifecycle.rawValue:
            //MARK: Create Branch Life Cycle Event
            print("Life Cycle Event Logged")
        case EventType.custom.rawValue:
            //MARK: Create BUO and Branch Custom Event
            print("Custom Event Logged")
        default:
            break
        }
    }
    
}

