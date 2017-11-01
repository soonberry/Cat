//
//  HomeViewController.swift
//  Cat
//
//  Created by Shuwen Li on 25/10/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel = HomeViewModel()

    @IBOutlet weak var slideShowScrollView: UIScrollView!
    
    var slideShowImageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        slideShowImageArray = [#imageLiteral(resourceName: "catwhite"), #imageLiteral(resourceName: "catc"), #imageLiteral(resourceName: "catd"), #imageLiteral(resourceName: "cata"), #imageLiteral(resourceName: "catas")]
        
        for index in 0..<slideShowImageArray.count {
            let slideShowImageView = UIImageView()
            slideShowImageView.image = slideShowImageArray[index]
            slideShowImageView.contentMode = .scaleToFill
            let xPosition = self.view.frame.width * CGFloat(index)
            
            slideShowImageView.frame = CGRect(x: xPosition, y: 0, width: self.slideShowScrollView.frame.width, height: self.slideShowScrollView.frame.height)
            
            slideShowScrollView.contentSize.width = slideShowScrollView.frame.width * CGFloat(index + 1)
            slideShowScrollView.addSubview(slideShowImageView)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.homeTableViewCell, for: indexPath) else {
            fatalError("Could not dequeue HomeTableViewCell")
        }

        let cellViewModel = viewModel.getCellViewModel(index: indexPath.row)
        
        cell.updateUI(cellViewModel: cellViewModel)
    

        return cell
    }
    
}
