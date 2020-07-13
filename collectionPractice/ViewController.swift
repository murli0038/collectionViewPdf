//
//  ViewController.swift
//  collectionPractice
//
//  Created by Nikunj Prajapati on 13/07/20.
//  Copyright © 2020 Nikunj Prajapati. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    let pdfDocument = PDFDocument()

    var arr: [UIImage] = [UIImage(imageLiteralResourceName: "1"),
                          UIImage(imageLiteralResourceName: "2"),
                          UIImage(imageLiteralResourceName: "3"),
                          UIImage(imageLiteralResourceName: "4"),
                          UIImage(imageLiteralResourceName: "5"),
                          UIImage(imageLiteralResourceName: "6"),
                          UIImage(imageLiteralResourceName: "7"),
                          UIImage(imageLiteralResourceName: "8"),
                          UIImage(imageLiteralResourceName: "9"),
                          UIImage(imageLiteralResourceName: "10"),
                          UIImage(imageLiteralResourceName: "11"),
                          UIImage(imageLiteralResourceName: "12"),
                          UIImage(imageLiteralResourceName: "13"),
                          UIImage(imageLiteralResourceName: "14"),
                          UIImage(imageLiteralResourceName: "15"),
                          UIImage(imageLiteralResourceName: "16"),
                          UIImage(imageLiteralResourceName: "17"),
                          UIImage(imageLiteralResourceName: "18"),
                          UIImage(imageLiteralResourceName: "19"),
                          UIImage(imageLiteralResourceName: "20"),
                          UIImage(imageLiteralResourceName: "21"),
                          UIImage(imageLiteralResourceName: "22"),
                          UIImage(imageLiteralResourceName: "23"),
                          UIImage(imageLiteralResourceName: "24"),
                          UIImage(imageLiteralResourceName: "25"),
                          UIImage(imageLiteralResourceName: "25"),
                          UIImage(imageLiteralResourceName: "25"),
                          UIImage(imageLiteralResourceName: "8"),
                          UIImage(imageLiteralResourceName: "9"),
                          UIImage(imageLiteralResourceName: "10"),
                          UIImage(imageLiteralResourceName: "11"),
                          UIImage(imageLiteralResourceName: "12"),
                          UIImage(imageLiteralResourceName: "13"),
                          UIImage(imageLiteralResourceName: "14"),
                          UIImage(imageLiteralResourceName: "15"),
                          UIImage(imageLiteralResourceName: "16"),]
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Mycell
        cell.myImage.image = arr[indexPath.row] as UIImage
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func makePdfbtn(_ sender: Any)
    {
        let pdfTool = PdfTools()
            pdfTool.generatePdfFromCollectionView(self.collectionView, filename: "myFancy.pdf")
            { (filename) in
        // use your pdf here
                  // Pdfa()
              
                
        }
        
    }
    

    
    @IBOutlet weak var pdfView: PDFView!
    
    
    @IBAction func viewPdfBtn(_ sender: Any)
    {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let docURL = documentDirectory.appendingPathComponent("myFancy.pdf")
        
        print(docURL)
        if fileManager.fileExists(atPath: docURL.path)
        {
            pdfView.document = PDFDocument(url: docURL)
        }
        else{
            print("file does not exist..")
        }
    }

}

class Mycell: UICollectionViewCell
{
    
    @IBOutlet weak var myImage: UIImageView!
    
    
}

class PdfTools {

    func generatePdfFromCollectionView(_ collectionView: UICollectionView?, filename:String, success:(String) -> ()) {

        guard let collectionView = collectionView else {
            return
        }

        let pdfData = NSMutableData()

        let contentArea = CGRect(
            x: 0,
            y: 0,
            width: collectionView.contentSize.width,
            height: collectionView.contentSize.height

        )

        collectionView.frame = contentArea

        UIGraphicsBeginPDFContextToData(pdfData, contentArea, nil)

        UIGraphicsBeginPDFPage()
        collectionView.drawHierarchy(in: collectionView.bounds, afterScreenUpdates: true)
        UIGraphicsEndPDFContext()

        if let filepath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let fileFullPath = filepath + "/" + filename

            if pdfData.write(toFile: fileFullPath, atomically: true) {
                success(fileFullPath)
                print(fileFullPath)
            }
        }
    }
}

