//
//  SplitViewController.swift
//  Kontakty
//
//  Created by Michał Massloch on 12/03/2022.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        preferredDisplayMode = .oneBesideSecondary
        self.delegate = self
        print("inSplitVC")
        // Do any additional setup after loading the view.
    }
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        print("primary")
            return .primary
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
