//
//  CustomSegue.swift
//  PickUp
//
//  Created by Anushrut Shah on 26/04/2019.
//  Copyright © 2019 Anushrut Shah. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {

    override func perform() {
        let fromVC = self.source
        let toVC = self.destination
        let containView = fromVC.view.superview
        let originalCentre = fromVC.view.center
        
        toVC.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toVC.view.center = originalCentre
        containView?.addSubview(toVC.view)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {toVC.view.transform = CGAffineTransform.identity }, completion: { success in
            fromVC.present(toVC, animated: false, completion: nil)
        })
    }
    
}

class UnwindSegue: UIStoryboardSegue {
    
    override func perform() {
        let fromVC = self.source
        let toVC = self.destination
        
        fromVC.view.superview?.insertSubview(toVC.view, at: 0)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {fromVC.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05) }, completion: { success in
            fromVC.dismiss(animated: false, completion: nil)
        })
    }
    
}
