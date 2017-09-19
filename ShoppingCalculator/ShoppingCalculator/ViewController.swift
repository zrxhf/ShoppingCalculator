//
//  ViewController.swift
//  ShoppingCalculator
//
//  Created by Ruxin Zhang on 9/10/17.
//  Copyright © 2017 Ruxin Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	//IBOutlet
	@IBOutlet weak var itemName: UITextField!
	@IBOutlet weak var originalPrice: UITextField!
	@IBOutlet weak var discount: UITextField!
	@IBOutlet weak var saleTax: UITextField!
	
	@IBOutlet weak var finalPrice: UILabel!
	@IBOutlet weak var youSaved: UILabel!
	@IBOutlet weak var totalPrice: UILabel!
	@IBOutlet weak var totallySaved: UILabel!
	
	@IBOutlet weak var history: UITextView!
	@IBOutlet weak var warning: UITextView!
	
	//Properties
	var itemNumber = 0;
	var totalPriceValue = 0.0;
	var totalSavedValue = 0.0;
	
	@IBAction func inputChanged(_ sender: Any) {
		//Initialize each field
		var originalPriceValue = 0.0;
		var discountValue = 0.0;
		var saleTaxValue = 0.0;
		var finalPriceValue = 0.0;
		var youSavedValue = 0.0;
		var displayText = "";
		warning.text = " ";
		
		
		if let temp = originalPrice.text {
			if (temp.characters.count > 0){
				if let tempValue = Double(temp) {
					if (tempValue >= 0) {
						originalPriceValue = tempValue;
					} else {
						warning.text = "Price should be positive";
					}
				} else {
					warning.text = "Please enter number";
				}
			}
		}
		
		if let temp = discount.text {
			//warning.text = " ";
			if (temp.characters.count > 0) {
				if let tempValue = Double(temp) {
					if (tempValue >= 0 && tempValue <= 100) {
						discountValue = Double(tempValue);
					} else {
						warning.text = "Discount should be in range 0~100";
					}
				} else {
					warning.text = "Please enter number";
				}
			}
		}
		
		
		if let temp = saleTax.text {
			//warning.text = "";
			if (temp.characters.count > 0) {
				if let tempValue = Double(temp) {
					if (tempValue >= 0 && tempValue <= 100) {
						saleTaxValue = Double(tempValue);
					} else {
						warning.text = "Sale tax should be in range 0~100";
					}
				} else {
					warning.text = "Please enter number";
				}
			}
		}
		
		//money you saved for this item
		youSavedValue = originalPriceValue * (1+saleTaxValue/100.0)*(discountValue/100.0);
		//money you spend on this item
		finalPriceValue = originalPriceValue * (1 + saleTaxValue/100.0)*(1-discountValue/100.0);
		

		//update display
		displayText = "$\(String(format: "%.2f", youSavedValue))"
		youSaved.text = displayText;
		displayText = "$\(String(format: "%.2f", finalPriceValue))"
		finalPrice.text = displayText;
	}
	
	//submit item record to can see total price and total saved money
	@IBAction func submitItem(_ sender: Any) {
		//submit valid only if item name is not null
		if (itemName.text != ""){
			itemNumber += 1;
		
			//update total price
			if var temp = finalPrice.text {
				if let i = temp.characters.index(of: "$") {
					temp.remove(at: i);
					if let tempValue = Double(temp) {
						totalPriceValue += tempValue;
						let displayText = "$\(String(format: "%.2f", totalPriceValue))"
						totalPrice.text = displayText;
					}
				}
			}
			
			//update total money you saved
			if var temp = youSaved.text {
				if let i = temp.characters.index(of: "$") {
					temp.remove(at: i);
					if let tempValue = Double(temp) {
						totalSavedValue += tempValue;
						let displayText = "$\(String(format: "%.2f", totalSavedValue))"
						totallySaved.text = displayText;
					}
				
				}
			}
			
			//update shopping history
			if var temp = history.text {
				temp.append("\n" + String(itemNumber) + " " + itemName.text! + " Final " + finalPrice.text! + " Saved " + youSaved.text!);
				history.text = temp;
			}
		}
		
	}
	
	//clear current item
	@IBAction func clear(_ sender: Any) {
		itemName.text = "";
		originalPrice.text = "";
		discount.text="";
		saleTax.text = "";
		finalPrice.text = "";
		youSaved.text = "";
		
	}
	

	
}

