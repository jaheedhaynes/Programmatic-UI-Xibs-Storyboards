//
//  ViewController.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Alex Paul on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {
    
    private let podcastView = PodcastView()
    
    private var podcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.podcastView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = podcastView
    }
    
    //---------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Podcasts"
        
        podcastView.collectionView.dataSource = self
        podcastView.collectionView.delegate = self
        
        // register collectionView Cell
        //    podcastView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "podcastCell")
        
        // or
        
        podcastView.collectionView.register(UINib(nibName: "PodcastCell", bundle: nil), forCellWithReuseIdentifier: "podcastCell")
        
        fetchPodcasts()
        
        
    }
    
    //---------------------------------------------------------------------
    
    
    
    
    private func fetchPodcasts(_ name: String = "swift") {
        PodcastAPIClient.fetchPodcast(with: name) { (result) in
            switch result {
            case .failure(let appError):
                print("error fetching podcasts: \(appError)")
            case .success(let podcasts):
                self.podcasts = podcasts
            }
        }
    }
}





extension PodcastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
            showAlert(title: "ok", message: "Could not load eollection cells. Go to cellForItem method under the datasource")
            fatalError()
        }
        
        cell.backgroundColor = .systemOrange
        
        return cell
    }
}

extension PodcastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.95
        return CGSize(width: itemWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let podcast = podcasts[indexPath.row]
       
        
        // segue to the POdcastDetailViewController
        // access the POdcastDetailController from the storyboard
        
        let podcastDetailStoryBoard = UIStoryboard(name: "PodcastDetail", bundle: nil)
        
        guard let podcastDetailController = podcastDetailStoryBoard.instantiateViewController(identifier: "PodcastDetailController") as? PodcastDetailController else {
            
            showAlert(title: "ok", message: "could not downcast to PodcastDetailController")
            fatalError("could not downcast to PodcastDetailController")
        }
        podcastDetailController.podcast = podcast
        
        navigationController?.pushViewController(podcastDetailController, animated: true)
    }
}




