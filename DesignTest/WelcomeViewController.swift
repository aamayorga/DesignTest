//
//  WelcomeViewController.swift
//  DesignTest
//
//  Created by Ansuke on 10/28/17.
//  Copyright © 2017 AM. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UITextFieldDelegate {
    
    // Welcome Screen variables
    @IBOutlet weak var partsLabel: UILabel!
    @IBOutlet weak var welcomeScreenTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var throughFacebookBottomContraint: NSLayoutConstraint!
    
    // Phone Number Screen variables
    @IBOutlet weak var enterPhoneNumberView: UIView!
    @IBOutlet weak var enterPhoneNumberLabel: UILabel!
    @IBOutlet weak var countryButtonView: UIView!
    @IBOutlet weak var countryPickerButton: UIButton!
    @IBOutlet weak var phoneNumberFieldViews: UIView!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var orLoginWithFacebookButton: UIButton!
    
    var animationPerformedOnce = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.phoneNumberField.delegate = self
        
        // Letter spacing code for "PARTS" label
        let attributedString = NSMutableAttributedString(string: "PARTS",
                                                         attributes: [
                                                            .font: UIFont(name: "HelveticaNeue-Bold",
                                                                          size: 20.0)!,
                                                            .foregroundColor: UIColor(white: 255.0 / 255.0, alpha: 1.0),
                                                            .kern: 2.2])
        attributedString.addAttribute(.kern, value: 0, range: NSRange(location: 4, length: 1))
        partsLabel.attributedText = attributedString
        
        // Round corners for "Sign in" and Country picker buttons
        signInButton.layer.cornerRadius = 5.0
        countryPickerButton.layer.cornerRadius = 5.0
        
        // Prevents user from interacting with hidden controls
        countryButtonView.isUserInteractionEnabled = false
        phoneNumberField.isEnabled = false
    }
    
    func enterPhoneNumberAnimation() {
        
        // Check if animation already played
        if !animationPerformedOnce{
            
            // Move welcome view and the sign in buttons up in half a second
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options:.curveEaseInOut,
                           animations: {
                            
                            // Move welcome screen and Facebook button out of view via their constraints
                            self.welcomeScreenTopConstraint.constant -= self.view.bounds.height
                            self.throughFacebookBottomContraint.constant += self.view.bounds.height
                            
                            // Have AutoLayout adjust constraints if needed
                            self.view.layoutIfNeeded()
                            
                            // Darken background and have "Enter Phone Number" label and "Login with Facebook" buttons appear
                            self.enterPhoneNumberView.backgroundColor = UIColor(white: 0, alpha: 0.5)
                            self.enterPhoneNumberLabel.alpha = 1
                            self.orLoginWithFacebookButton.alpha = 1
                            
                            // Move "Sign In" button up
                            self.signInButton.frame = CGRect(
                                x: self.signInButton.frame.minX,
                                y: self.view.bounds.height/3,
                                width: self.signInButton.frame.size.width,
                                height: self.signInButton.frame.size.height)
                            
                            // Move "Login with Facebook" button up
                            self.orLoginWithFacebookButton.frame = CGRect(
                                x: self.signInButton.frame.midX - self.orLoginWithFacebookButton.frame.size.width/2,
                                y: self.signInButton.frame.midY + 50,
                                width: self.orLoginWithFacebookButton.frame.size.width,
                                height: self.orLoginWithFacebookButton.frame.size.height)
                            
            }) { (success:Bool) in
                if success {
                    
                    // Once the above animations are done then do these animations.
                    UIView.animate(withDuration: 0.25, animations: {
                        
                        // Move phone number entry field picker button up
                        self.phoneNumberFieldViews.frame = CGRect(
                            x: self.signInButton.frame.minX,
                            y: self.signInButton.frame.minY - self.signInButton.bounds.height,
                            width: self.phoneNumberFieldViews.frame.width,
                            height: self.phoneNumberFieldViews.frame.height)
                        
                        // Move country picker button up
                        self.countryButtonView.frame = CGRect(
                            x: self.signInButton.frame.minX,
                            y: self.signInButton.frame.minY - (self.countryButtonView.bounds.height * 2) + 4,
                            width: self.countryButtonView.frame.width,
                            height: self.countryButtonView.frame.height)
                        
                        // Change "Sign in with phone" text to "Continue"
                        self.signInButton.setTitle("Continue", for: .normal)
                        
                        // Round only the bottom left and right corners of the "Continue" button
                        let path = UIBezierPath(roundedRect: self.signInButton.bounds, byRoundingCorners: [UIRectCorner.bottomLeft, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 5.0, height: 5.0))
                        let mask = CAShapeLayer()
                        mask.path = path.cgPath
                        self.signInButton.layer.cornerRadius = 0.0
                        self.signInButton.layer.mask = mask
                        
                        // Round corners of Country picker button
                        self.countryButtonView.layer.cornerRadius = 5.0
                        
                        // Make Country picker and the Phone Number field appear on screen and enable interaction
                        self.countryButtonView.alpha = 1.0
                        self.phoneNumberFieldViews.alpha = 1.0
                        self.countryButtonView.isUserInteractionEnabled = true
                        self.phoneNumberField.isEnabled = true
                        
                        // Show keyboard
                        self.phoneNumberField.becomeFirstResponder()
                    })
                }
            }
            
            // Makes sure animation is only played once
            animationPerformedOnce = true
        }
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        // Start animation
        enterPhoneNumberAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismisses keyboard if user touches outside of keyboard
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismisses keyboard if user presses "Enter"
        // Mainly used for debugging
        textField.resignFirstResponder()
        return true
    }
}
