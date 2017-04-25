//
//  GearViewController.swift
//  GearCollector
//
//  Created by Robin Tan on 12/4/17.
//  Copyright © 2017 Robin Tan. All rights reserved.
//

import UIKit

class GearViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var gearImageView: UIImageView!
    @IBOutlet weak var descriptorTextField: UITextField!
    @IBOutlet weak var flexiButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var gear : Gear? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if gear != nil {
            gearImageView.image = UIImage(data: gear!.image as! Data)
            descriptorTextField.text = gear!.descriptor
            flexiButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        gearImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        print("addTapped function...")
        
        if gear != nil {
            gear!.descriptor = descriptorTextField.text!
            gear!.image = UIImagePNGRepresentation(gearImageView.image!)! as NSData
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let gear = Gear(context: context)
            gear.descriptor = descriptorTextField.text!
            gear.image = UIImagePNGRepresentation(gearImageView.image!)! as NSData
        }

        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }

    
    @IBAction func deleteTapped(_ sender: Any) {
        
        print("deleteTapped function...")
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(gear!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
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
