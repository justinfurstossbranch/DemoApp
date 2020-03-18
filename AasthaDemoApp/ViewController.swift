//
//  ViewController.swift
//  AasthaDemoApp
//
//  Created by Justin Furstoss on 3/18/20.
//  Copyright © 2020 Justin Furstoss. All rights reserved.
//

//MARK: Import Branch
import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    var branchInitParameters: NSDictionary? = nil
    //MARK: Create Link Properties
    //MARK: Create Branch Universal Object
    
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
        //MARK: Call Branch Universal Object .showShareSheet with the call back

    }
    func didTapGenerateQuickLinkButton(_ view: View, sender: UIButton) {
        //MARK: Call Branch Universal Object .getShortUrl with the call back to then call view.setQuickLinkLabel with the url.absoluteString()
        
    }
    func didTapViewLinkParametersButton(_ view: View, sender: UIButton) {
        //MARK: Pass the Params from the App Delegates Init session through the view.setLinkParameters
    }
    
}

