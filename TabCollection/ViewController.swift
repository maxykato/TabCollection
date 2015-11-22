//
//  ViewController.swift
//  TabCollection
//
//  Created by Yuichi Max Kato on 2015/11/22.
//  Copyright © 2015年 Yuichi Kato. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var tabCollectionView: UICollectionView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    var activeTabNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == self.tabCollectionView{
        
            let cell : TabCollectionViewCell = tabCollectionView.dequeueReusableCellWithReuseIdentifier("TabCell", forIndexPath: indexPath) as! TabCollectionViewCell
            
            cell.tabTitle.text = indexPath.row.description
            
            if indexPath.item == activeTabNumber {
                cell.backgroundColor = UIColor.blueColor()
            } else {
                cell.backgroundColor = UIColor.grayColor()
            }
            return cell
            
        } else {
            
            let cell : MainCollectionViewCell = mainCollectionView.dequeueReusableCellWithReuseIdentifier("MainCell", forIndexPath: indexPath) as! MainCollectionViewCell
                cell.label.text = indexPath.row.description
            
            return cell
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        if collectionView == self.tabCollectionView{
             return CGSizeMake(80, 38)
        } else {
            return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 65)
        }
    }

    //When tab is selected
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        if collectionView == self.tabCollectionView{
            self.activeTabNumber = indexPath.item
            tabCollectionView.reloadData()
            self.mainCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left
                , animated: true)
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            
        }
    }
    //When screen is swiped
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        self.moveTabsBySwipe(scrollView)
    }

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        self.moveTabsBySwipe(scrollView)
    }
    
    func moveTabsBySwipe(scrollView:UIScrollView){
        
        let visibleTabs = self.tabCollectionView.indexPathsForVisibleItems()
        print("visibleTabs are \(visibleTabs)")
        
        if scrollView == self.mainCollectionView{
            
            let activeTabIndexPaths =  self.mainCollectionView.indexPathsForVisibleItems()
            //print("activeTabIndexPaths are \(activeTabIndexPaths)")
            self.activeTabNumber = activeTabIndexPaths[0].item
            self.tabCollectionView.reloadData()
            
            for visibleTabIndex in visibleTabs {
                if visibleTabIndex.item == activeTabNumber{
                    break;
                } else {
                    if activeTabNumber > visibleTabIndex.item {
                        self.tabCollectionView.scrollToItemAtIndexPath(activeTabIndexPaths[0], atScrollPosition: .Right, animated: true)
                    } else {
                        self.tabCollectionView.scrollToItemAtIndexPath(activeTabIndexPaths[0], atScrollPosition: .Left, animated: true)
                    }
                }
            }
        }
    }
}

