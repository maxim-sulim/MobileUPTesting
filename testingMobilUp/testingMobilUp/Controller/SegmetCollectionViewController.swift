//
//  SegmetCollectionViewController.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 23.04.2023.
//

import UIKit

class SegmetCollectionViewController: UIViewController {

    @IBOutlet weak var segmentCollection: UICollectionView!
    
    @IBAction func shareActon(_ sender: Any) {
        
        let avc = UIActivityViewController(activityItems: selectedImage, applicationActivities: nil)
        avc.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                
            }
        }
        present(avc, animated: true)
    }
    private var selectedImage = [UIImage]()
    var imageCollectionArray = [AlbumModel]()// хранение даты и дейты
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentCollection.delegate = self
        self.segmentCollection.dataSource = self
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .black
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentCollection.reloadData()
    }
    
}

// MARK: DATASOURSE DELEGATE
extension SegmetCollectionViewController: UICollectionViewDelegate,
                                          UICollectionViewDataSource,
                                          UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageCollectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "almubCell", for: indexPath) as? SegmentCollectionViewCell {
            itemCell.album = imageCollectionArray[indexPath.row]
            
            let title = imageCollectionArray[indexPath.row].imageDateUnix!
            let calendar = Calendar.current
            let componentsTitle = calendar.dateComponents([.day, .month,.year,], from: title)
            let date = calendar.date(from: componentsTitle)!
            let dateFormater = DateFormatter()
            dateFormater.dateStyle = .medium
            dateFormater.dateFormat = "dd MMMM yyyy"
            self.navigationItem.title = dateFormater.string(from: date)
            return itemCell
        }
        return UICollectionViewCell()
    }
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! SegmentCollectionViewCell
        guard let image = cell.segmentImage.image else { return }
            selectedImage.append(image)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! SegmentCollectionViewCell
        guard let image = cell.segmentImage.image else { return }
        if let index = selectedImage.firstIndex(of: image) {
            selectedImage.remove(at: index)
        }
    }
    */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameVC = collectionView.frame
        let widthCell = frameVC.width
        let heghtCell = widthCell
        let sizeResult = CGSize(width: widthCell, height: heghtCell)
        return sizeResult
    }
    
}
