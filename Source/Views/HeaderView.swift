import UIKit

protocol HeaderViewDelegate: class {
  func headerView(_ headerView: HeaderView, didPressDeleteButton deleteButton: UIButton)
  func headerView(_ headerView: HeaderView, didPressCloseButton closeButton: UIButton)
  func headerView(_ headerView: HeaderView, didPressDoneButton doneButton: UIButton)
}

open class HeaderView: UIView {
  open fileprivate(set) lazy var closeButton: UIButton = { [unowned self] in
    let title = NSAttributedString(
      string: LightboxConfig.CloseButton.text,
      attributes: LightboxConfig.CloseButton.textAttributes)

    let button = UIButton(type: .custom)

    button.setAttributedTitle(title, for: UIControlState())
                                                          
    button.setAttributedTitle(title, for: UIControlState())
    button.imageView?.layer.shadowRadius = 3
    button.imageView?.layer.shadowColor = UIColor.black.cgColor
    button.imageView?.layer.shadowOffset = CGSize(width: 0, height: 1.0)
    button.imageView?.layer.shadowOpacity = 0.8
    button.imageView?.layer.masksToBounds = false
                                                      
    if let size = LightboxConfig.CloseButton.size {
      button.frame.size = size
    } else {
      button.sizeToFit()
    }

    button.addTarget(self, action: #selector(closeButtonDidPress(_:)),
      for: .touchUpInside)

    let bundle = Foundation.Bundle(for: HeaderView.self)
    let image = LightboxConfig.CloseButton.image ?? AssetManager.image("lightbox_close")
    button.setImage(image, for: UIControlState())

    button.isHidden = !LightboxConfig.CloseButton.enabled

    return button
  }()

  open fileprivate(set) lazy var deleteButton: UIButton = { [unowned self] in
    let title = NSAttributedString(
      string: LightboxConfig.DeleteButton.text,
      attributes: LightboxConfig.DeleteButton.textAttributes)

    let button = UIButton(type: .system)

    button.setAttributedTitle(title, for: .normal)

    if let size = LightboxConfig.DeleteButton.size {
      button.frame.size = size
    } else {
      button.sizeToFit()
    }

    button.addTarget(self, action: #selector(deleteButtonDidPress(_:)),
      for: .touchUpInside)

    if let image = LightboxConfig.DeleteButton.image {
      button.setBackgroundImage(image, for: UIControlState())
    }

    button.isHidden = !LightboxConfig.DeleteButton.enabled

    return button
  }()
  
  open fileprivate(set) lazy var doneButton: UIButton = { [unowned self] in
    let title = NSAttributedString(
        string: LightboxConfig.DoneButton.text,
        attributes: LightboxConfig.DoneButton.textAttributes)
    
    let button = UIButton(type: .custom)
    
    button.setAttributedTitle(title, for: UIControlState())
                                                         
    button.titleLabel?.layer.shadowRadius = 3
    button.titleLabel?.layer.shadowColor = UIColor.black.cgColor
    button.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 1.0)
    button.titleLabel?.layer.shadowOpacity = 0.8
    button.titleLabel?.layer.masksToBounds = false
    
    if let size = LightboxConfig.DoneButton.size {
        button.frame.size = size
    } else {
        button.sizeToFit()
    }
    
    button.addTarget(self, action: #selector(doneButtonDidPress(_:)),
                     for: .touchUpInside)
    
    let bundle = Foundation.Bundle(for: HeaderView.self)
    let image = LightboxConfig.DoneButton.image
    button.setImage(image, for: UIControlState())
    
    button.isHidden = !LightboxConfig.DoneButton.enabled
    
    return button
  }()


  weak var delegate: HeaderViewDelegate?

  // MARK: - Initializers

  public init() {
    super.init(frame: CGRect.zero)

    backgroundColor = UIColor.clear

    [closeButton, deleteButton, doneButton].forEach { addSubview($0) }
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Actions

  @objc func deleteButtonDidPress(_ button: UIButton) {
    delegate?.headerView(self, didPressDeleteButton: button)
  }

  @objc func closeButtonDidPress(_ button: UIButton) {
    delegate?.headerView(self, didPressCloseButton: button)
  }
  
  @objc func doneButtonDidPress(_ button: UIButton) {
    delegate?.headerView(self, didPressDoneButton: button)
  }
}

// MARK: - LayoutConfigurable

extension HeaderView: LayoutConfigurable {

  @objc public func configureLayout() {

    closeButton.frame.origin = CGPoint(
      x: 0,
      y: 0
    )
    
    doneButton.frame.origin = CGPoint(
      x: bounds.width - closeButton.frame.width - 20,
      y: 1
    )
    
    deleteButton.frame.origin = CGPoint(
      x: 17,
      y: 0
    )
  }
}
