//
//  HomeViewController.swift
//  Cat
//
//  Created by Shuwen Li on 25/10/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import UIKit
import ImageSlideshow

class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()
    
    @IBOutlet weak var momentTableView: UITableView!
    @IBOutlet weak var slideShowScrollView: UIScrollView!
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    
    let imageURLPrefix = "http://localhost:8080/catnip"
    
    let momentListService = MomentListService()
    let bannerService = BannerService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerService.getBanner(success: loadingBanner, failure: loadingFailure)
        momentListService.getMomentList(success: loadingMoments, failure: loadingFailure)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadingBanner(bannerImages: [CatImage]) {
        var imageSource: [AFURLSource] = []
        for imageAddress in bannerImages {
            imageSource.append(AFURLSource(urlString: imageURLPrefix + imageAddress.image)!)
        }
        imageSlideShow.setImageInputs(imageSource)
        print(imageSource)
    }
    
    private func loadingFailure(error: APIError) {
        print(error.message)
    }
    
    private func loadingMoments(moments: [Moment]) {
        viewModel.setMoments(momentList: moments)
        momentTableView.reloadData()
    }
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
