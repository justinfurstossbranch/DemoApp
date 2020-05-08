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
        //MARK: Call Branch Universal Object .showShareSheet along with Link Properties with the call back

    }
    func didTapGenerateQuickLinkButton(_ view: View, sender: UIButton) {
        //MARK: Call Branch Universal Object .getShortUrl with the call back to then call view.setQuickLinkLabel with the url.absoluteString()
        
    }
    func didTapViewLinkParametersButton(_ view: View, sender: UIButton) {
        //MARK: Pass the Params from the App Delegates Init session through the view.setLinkParameters
        view.setLinkParameters(withText: Branch.getInstance().getLatestReferringParams()?.description ?? "No Latest Referring Parameters")
    }
    func didTapEvent(_ view: View, sender: UIButton) {
        switch sender.tag {
        case EventType.commerce.rawValue:
            let branchUniversalObject = BranchUniversalObject.init()

            // ...add data to the branchUniversalObject as needed...
            branchUniversalObject.canonicalIdentifier = "item/12345"
            branchUniversalObject.canonicalUrl        = "https://branch.io/item/12345"
            branchUniversalObject.title               = "My Item Title"

            branchUniversalObject.contentMetadata.contentSchema     = .commerceProduct
            branchUniversalObject.contentMetadata.quantity          = 1
            branchUniversalObject.contentMetadata.price             = 23.20
            branchUniversalObject.contentMetadata.currency          = .USD
            branchUniversalObject.contentMetadata.sku               = "1994320302"
            branchUniversalObject.contentMetadata.productName       = "my_product_name1"
            branchUniversalObject.contentMetadata.productBrand      = "my_prod_Brand1"
            branchUniversalObject.contentMetadata.productCategory   = .apparel
            branchUniversalObject.contentMetadata.productVariant    = "XL"
            branchUniversalObject.contentMetadata.condition         = .new
            let event = BranchEvent.standardEvent(.purchase)

            // Add the BranchUniversalObject with the content (do not add an empty branchUniversalObject):
            event.contentItems     = [ branchUniversalObject ]

            // Add relevant event data:
            event.alias            = "my custom alias"
            event.transactionID    = "12344555"
            event.currency         = .USD
            event.revenue          = 1.5
            event.shipping         = 10.2
            event.tax              = 12.3
            event.coupon           = "test_coupon"
            event.affiliation      = "test_affiliation"
            event.eventDescription = "Event_description"
            event.searchQuery      = "item 123"
            event.customData       = [
                "revenue": "1.5",
                "Custom_Event_Property_Key2": "Custom_Event_Property_val2"
            ]
            event.logEvent() // Log the event.
            view.setLinkParameters(withText: "Branch Universal Object: \n" + branchUniversalObject.dictionary().description + "Event Data: \n" + event.dictionary().description)
            print("Commerce Event Logged")
        case EventType.content.rawValue:
            let event = BranchEvent.standardEvent(.viewItem)
            event.alias = "Pageview"
            event.eventDescription = "home_page"
            event.customData["Custom_Event_Property_Key1"] = "Custom_Event_Property_val1"
            event.logEvent()
            view.setLinkParameters(withText: "Event Data: \n" + event.dictionary().description)
            print("Content Event Logged")
        case EventType.lifecycle.rawValue:
            let event = BranchEvent.standardEvent(.login)
            event.alias = "login"
            event.customData["content_type"] = "email_login"
            event.logEvent()
            view.setLinkParameters(withText: "Event Data: \n" + event.dictionary().description)
            print("Life Cycle Event Logged")
        case EventType.custom.rawValue:
            let buo = BranchUniversalObject()
            buo.contentMetadata = BranchContentMetadata()
            buo.contentMetadata.productName = "product_xyz"
            buo.contentMetadata.quantity = 1
            let event = BranchEvent(name: "coupon_applied")
            event.contentItems = [buo]
            event.transactionID = UUID().uuidString
            event.logEvent()
            view.setLinkParameters(withText: "Branch Universal Object: \n" + buo.dictionary().description + "Event Data: \n" + event.dictionary().description)
            print("Custom Event Logged")
        default:
            break
        }
    }
    
}

