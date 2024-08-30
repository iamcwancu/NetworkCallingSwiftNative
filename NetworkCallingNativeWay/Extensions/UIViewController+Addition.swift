//
//  UIViewController+Addition.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//


import UIKit

extension UIViewController {
    public func tappedAroundToHideKeyboard() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        gesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(gesture)
    }
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
extension UIViewController {
    /// Displays a toast message with customisable properties.
    /// - Parameters:
    ///   - message: The message to be displayed in the toast.
    ///   - fontSize: The font size of the message. Default is 11.0.
    ///   - textColor: The text colour of the message. Default is white.
    ///   - cornerRadius: The corner radius of the toast container. Default is 16.0.
    func showToast(message: String, fontSize: CGFloat = 11.0, textColor: UIColor = UIColor.white, cornerRadius: CGFloat = 16.0) {
        /// Create the toast container view.
        let containerView = UIView()
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        containerView.alpha = 0.0
        containerView.layer.cornerRadius = cornerRadius
        containerView.clipsToBounds = true
        /// Create the label to display the message.
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = textColor
        toastLabel.textAlignment = .center
        toastLabel.font.withSize(fontSize)
        toastLabel.text = message
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0

        /// Add the label to the container view.
        containerView.addSubview(toastLabel)
        /// Add the container view to the current view controller's view.
        self.view.addSubview(containerView)

        /// Enable AutoLayout for the label and container view.
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false

        /// Set up AutoLayout constraints for the label and container view.
        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            toastLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            toastLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            toastLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),

            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45),
            containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80)
        ])
        /// Animate the toast appearance and disappearance.
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            containerView.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                containerView.alpha = 0.0
            }, completion: { _ in
                containerView.removeFromSuperview()
            })
        })
    }
}
