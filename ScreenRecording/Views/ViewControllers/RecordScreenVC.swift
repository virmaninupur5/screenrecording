//
//  RecordVC.swift
//  ScreenRecording
//
//  Created by Noopur Virmani on 14/03/19.
//  Copyright © 2019 Noopur Virmani. All rights reserved.
//


import UIKit
import ReplayKit

class RecordVC: UIViewController, RPPreviewViewControllerDelegate  {
    
   @IBOutlet var statusLabel: UILabel!
   @IBOutlet var recordButton: UIButton!
   @IBOutlet var colorPicker: UISegmentedControl!
   @IBOutlet var colorDisplay: UIView!
   
   let recorder = RPScreenRecorder.shared()
  
    
   override func viewDidLoad() {
        super.viewDidLoad()
        recordButton.layer.cornerRadius = 32.5
        self.title = "Screen Record"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View Album", style: .plain, target: self, action: #selector(showSavedRecordings))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func viewReset() {
        statusLabel.text = "Ready to Record"
        statusLabel.textColor = UIColor.black
        recordButton.backgroundColor = UIColor.green
    }
    
    @objc func showSavedRecordings(){
        let controllerObject = self.storyboard?.instantiateViewController(withIdentifier: "GalleryVC") as? GalleryVC
        let navigationController: UINavigationController = UINavigationController(rootViewController: controllerObject!)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    @IBAction func colors(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            colorDisplay.backgroundColor = UIColor.red
        case 1:
            colorDisplay.backgroundColor = UIColor.blue
        case 2:
            colorDisplay.backgroundColor = UIColor.orange
        case 3:
            colorDisplay.backgroundColor = UIColor.green
        default:
            colorDisplay.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func recordButtonTapped() {
        guard recorder.isAvailable else {
            print("Recording is not available at this time.")
            return
        }
        
        if recorder.isRecording {
            stopRecording()
        }
        else {
            startRecording()
        }
    }
    
    
    
    func startRecording() {
        recorder.startRecording{ (error) in
            guard error == nil else {
                print("There was an error starting the recording.")
                return
            }
            
            print("Started Recording Successfully")
            DispatchQueue.main.async {
                self.recordButton?.backgroundColor = UIColor.red
                self.statusLabel?.text = "Recording..."
                self.statusLabel?.textColor = UIColor.red
             }
            
        }
        
    }
    
    func stopRecording() {
        
        recorder.stopRecording { [unowned self] (preview, error) in
            print("Stopped recording")
            
            guard preview != nil else {
                print("Preview controller is not available.")
                return
            }
            
            let alert = UIAlertController(title: "Recording Finished", message: "Would you like to save your recording?", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction) in
                preview?.previewControllerDelegate = self
                preview?.userActivity?.activityType =
                self.present(preview!, animated: true, completion: nil)
            })
            
            let cancelAction = UIAlertAction(title: "No", style: .destructive, handler: { (action: UIAlertAction) -> Void in
               
            })
            
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
           
            
            self.viewReset()
            
        }
        
    }
    
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true)
    }
    
    func previewController(_ previewController: RPPreviewViewController, didFinishWithActivityTypes activityTypes: Set<String>) {
        
       print(activityTypes.description)
        
        
        
    }
}

