//
//  View.swift
//  AasthaDemoApp
//
//  Created by Justin Furstoss on 3/18/20.
//  Copyright © 2020 Justin Furstoss. All rights reserved.
//

import UIKit

enum EventType: Int, CaseIterable {
    case commerce = 0, content, lifecycle, custom
    
    var displayText: String {
        switch self {
        case EventType.commerce: return "Commerce Event"
        case EventType.content: return "Content Event"
        case EventType.lifecycle: return "Life Cycle Event"
        case EventType.custom: return "Custom Event"
        }
    }
}


protocol ViewDelegate {
    func didTapShareButton(_ view: View, sender: UIButton)
    func didTapGenerateQuickLinkButton(_ view: View, sender: UIButton)
    func didTapViewLinkParametersButton(_ view: View, sender: UIButton)
    func didTapEvent(_ view: View, sender: UIButton)
}

class View: UIView {
    //MARK: Properties
    var delegate: ViewDelegate? {
        didSet {
            setUpDelegate(withDelegate: delegate)
        }
    }
    //MARK: Init
    override init(frame: CGRect){
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
        addSubview(canonicalUrlTextView)
        addSubview(quickLinktextView)
        addSubview(quickLinkButton)
        addSubview(shareButton)
        addSubview(commerceEvent)
        addSubview(contentEvent)
        addSubview(lifecycleEvent)
        addSubview(customEvent)
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
        canonicalUrlTextView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
        quickLinktextView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.top.equalTo(canonicalUrlTextView.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
        quickLinkButton.snp.makeConstraints { (make) in
            make.height.equalTo(75)
            make.width.equalTo(100)
            make.centerX.equalToSuperview().multipliedBy(0.33)
            make.top.equalTo(quickLinktextView.snp.bottom).offset(20)
        }
        shareButton.snp.makeConstraints { (make) in
            make.height.equalTo(75)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(quickLinktextView.snp.bottom).offset(20)
        }
        commerceEvent.snp.makeConstraints { (make) in
            make.height.equalTo(75)
            make.width.equalTo(100)
            make.centerX.equalToSuperview().multipliedBy(1.66)
            make.top.equalTo(quickLinktextView.snp.bottom).offset(20)
        }
        contentEvent.snp.makeConstraints { (make) in
            make.height.equalTo(75)
            make.width.equalTo(100)
            make.centerX.equalToSuperview().multipliedBy(0.33)
            make.top.equalTo(quickLinkButton.snp.bottom).offset(20)
        }
        lifecycleEvent.snp.makeConstraints { (make) in
            make.height.equalTo(75)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(quickLinkButton.snp.bottom).offset(20)
        }
        customEvent.snp.makeConstraints { (make) in
            make.height.equalTo(75)
            make.width.equalTo(100)
            make.centerX.equalToSuperview().multipliedBy(1.66)
            make.top.equalTo(quickLinkButton.snp.bottom).offset(20)
        }
        viewLinkParametersButton.snp.makeConstraints { (make) in
            make.height.equalTo(45)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.top.equalTo(customEvent.snp.bottom).offset(20)
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
    @objc func didTapEvent(_ sender: UIButton) {
        self.delegate?.didTapEvent(self, sender: sender)
    }
    //MARK: Helpers
    internal func setCanonicalUrlLabel(withText text: String) {
        canonicalUrlTextView.text = text
    }
    internal func setQuickLinkLabel(withText text: String) {
        quickLinktextView.text = text
    }
    internal func setLinkParameters(withText text: String) {
        linkParametersTextView.text = text
    }
    //MARK: Lazy Init
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .regular)
        label.text = "Demo App"
        label.textColor = .black
        return label
    }()
    internal lazy var canonicalUrlTextView: UITextView = {
        let textView = UITextView()
        textView.isSelectable = true
        textView.isEditable = false
        textView.adjustsFontForContentSizeCategory = true
        textView.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        textView.text = "Relevant URL"
        textView.textColor = .gray
        textView.textAlignment = .center
        textView.backgroundColor = .white
        return textView
    }()
    internal lazy var quickLinktextView: UITextView = {
        let textView = UITextView()
        textView.isSelectable = true
        textView.isEditable = false
        textView.adjustsFontForContentSizeCategory = true
        textView.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        textView.text = "Quick Link"
        textView.textColor = .gray
        textView.textAlignment = .center
        textView.backgroundColor = .white
        return textView
    }()
    internal lazy var quickLinkButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Generate Quick Link", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 153/255, blue: 211/255, alpha: 1)
        button.addTarget(self, action: #selector(didTapGenerateQuickLink), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }()
    internal lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Share Link", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 153/255, blue: 211/255, alpha: 1)
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }()
    internal lazy var commerceEvent: UIButton = {
        let button = UIButton()
        button.tag = EventType.commerce.rawValue
        button.setAttributedTitle(NSAttributedString(string: EventType.commerce.displayText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 153/255, blue: 211/255, alpha: 1)
        button.addTarget(self, action: #selector(didTapEvent), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }()
    internal lazy var contentEvent: UIButton = {
        let button = UIButton()
        button.tag = EventType.content.rawValue
        button.setAttributedTitle(NSAttributedString(string: EventType.content.displayText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 153/255, blue: 211/255, alpha: 1)
        button.addTarget(self, action: #selector(didTapEvent), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }()
    internal lazy var lifecycleEvent: UIButton = {
        let button = UIButton()
        button.tag = EventType.lifecycle.rawValue
        button.setAttributedTitle(NSAttributedString(string: EventType.lifecycle.displayText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 153/255, blue: 211/255, alpha: 1)
        button.addTarget(self, action: #selector(didTapEvent), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }()
    internal lazy var customEvent: UIButton = {
        let button = UIButton()
        button.tag = EventType.custom.rawValue
        button.setAttributedTitle(NSAttributedString(string: EventType.custom.displayText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 153/255, blue: 211/255, alpha: 1)
        button.addTarget(self, action: #selector(didTapEvent), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.showsTouchWhenHighlighted = true
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }()
    internal lazy var viewLinkParametersButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Get Latest Parameters", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.backgroundColor = UIColor(red: 55/255, green: 153/255, blue: 211/255, alpha: 1)
        button.addTarget(self, action: #selector(didTapViewLinkParameters), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.showsTouchWhenHighlighted = true 
        return button
    }()
    internal lazy var linkParametersTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Link Parameters:"
        textView.textColor = .gray
        textView.isSelectable = true
        textView.isEditable = false
        textView.layer.cornerRadius = 4.0
        textView.backgroundColor = .white
        return textView
    }()
}
