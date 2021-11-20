//
//  ProductMainViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 19/04/2021.
//

import UIKit

class ProductMainViewController: UIViewController {

    //MARK:- Properties
    var currentProdut: Product?
    
    //ImageView
    @IBOutlet weak var productImage: UIImageView!
    
    //Label
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    //Button
    @IBOutlet weak var favouriteButton: UIButton!
    
    //MARK:- Handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart.badge.plus"), style: .plain, target: self, action: #selector(cartAddButtonPressed))
        
        guard let product = currentProdut else { return }
        
        title = product.name
        
        //Image
        productImage.image = UIImage(named: product.image)
        productImage.contentMode = .scaleToFill
        
        //Label
        nameLabel.text = product.name
        priceLabel.text = "$" + product.price
        priceLabel.textColor = .systemGray2
        descLabel.text = product.description
        descLabel.numberOfLines = 0
        
    }
    
    @objc func cartAddButtonPressed(){
        let alert = UIAlertController(title: "Item added to cart", message: currentProdut?.name, preferredStyle: .alert)
        present(alert, animated: true)
        
        guard let product = currentProdut else { return }
        CurrentUser.shared?.cart.append(product)
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
          alert.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton){
        guard var product = currentProdut else { return }
        product.isFav.toggle()
        sender.imageView?.image = product.isFav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        sender.imageView?.tintColor = product.isFav ? .red : .gray
    }
}
