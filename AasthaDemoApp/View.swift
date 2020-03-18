//
//  View.swift
//  AasthaDemoApp
//
//  Created by Justin Furstoss on 3/18/20.
//  Copyright © 2020 Justin Furstoss. All rights reserved.
//

import UIKit

protocol ViewDelegate {
    func didTapShareButton(_ view: View, sender: UIButton)
    func didTapGenerateQuickLinkButton(_ view: View, sender: UIButton)
    func didTapViewLinkParametersButton(_ view: View, sender: UIButton)
}

class View: UIView {
    //MARK: Properties
    var delegate: ViewDelegate? {
        didSet {
            setUpDelegate(withDelegate: delegate)
        }
    }
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpViewHierarchy()
        setUpViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: View Hierarchy
    private func setUpViewHierarchy() {
        addSubview(titleLabel)
        addSubview(canonicalUrlLabel)
        addSubview(quickLinkLabel)
        addSubview(quickLinkButton)
        addSubview(shareButton)
        addSubview(viewLinkParametersButton)
        addSubview(linkParametersTextView)
    }
    //MARK: View Constraints
    private func setUpViewConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            make.height.equalTo(40)
        }
        canonicalUrlLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
        quickLinkLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.top.equalTo(canonicalUrlLabel.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
        quickLinkButton.snp.makeConstraints { (make) in
            make.height.equalTo(45)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.top.equalTo(quickLinkLabel.snp.bottom).offset(20)
        }
        shareButton.snp.makeConstraints { (make) in
            make.height.equalTo(45)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.top.equalTo(quickLinkButton.snp.bottom).offset(20)
        }
        viewLinkParametersButton.snp.makeConstraints { (make) in
            make.height.equalTo(45)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.top.equalTo(shareButton.snp.bottom).offset(20)
        }
        linkParametersTextView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.top.equalTo(viewLinkParametersButton.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    //MARK: Delegate
    internal func setUpDelegate(withDelegate delegate: ViewDelegate?) {
    }
    
    //MARK: Actions
    @objc func didTapShareButton(_ sender: UIButton) {
        self.delegate?.didTapShareButton(self, sender: sender)
    }
    @objc func didTapGenerateQuickLink(_ sender: UIButton) {
        self.delegate?.didTapGenerateQuickLinkButton(self, sender: sender)
    }
    @objc func didTapViewLinkParameters(_ sender: UIButton) {
        self.delegate?.didTapViewLinkParametersButton(self, sender: sender)
    }
    //MARK: Helpers
    internal func setCanonicalUrlLabel(withText text: String) {
        canonicalUrlLabel.text = text
    }
    internal func setQuickLinkLabel(withText text: String) {
        quickLinkLabel.text = text
    }
    internal func setLinkParameters(withText text: String) {
        linkParametersTextView.text = text
    }
    //MARK: Lazy Init
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .regular)
        label.text = "Aastha's Demo App"
        label.textColor = .black
        return label
    }()
    internal lazy var canonicalUrlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        label.text = "$canonical_url"
        label.textColor = .gray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.cornerRadius = 4.0
        label.layer.borderWidth = 1.0
        return label
    }()
    internal lazy var quickLinkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        label.text = "Quick Link"
        label.textColor = .gray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.cornerRadius = 4.0
        label.layer.borderWidth = 1.0
        return label
    }()
    internal lazy var quickLinkButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Generate Quick Link", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 153/255, blue: 211/255, alpha: 1)
        button.addTarget(self, action: #selector(didTapGenerateQuickLink), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        return button
    }()
    internal lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Share Link", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 153/255, blue: 211/255, alpha: 1)
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        return button
    }()
    internal lazy var viewLinkParametersButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "View Link Parameters", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 153/255, blue: 211/255, alpha: 1)
        button.addTarget(self, action: #selector(didTapViewLinkParameters), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        return button
    }()
    internal lazy var linkParametersTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Link Parameters:"
        textView.isSelectable = false
        textView.isEditable = false
        textView.layer.cornerRadius = 4.0
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        return textView
    }()
}
