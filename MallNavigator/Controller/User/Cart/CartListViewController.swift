//
//  CartListViewController.swift
//  MallNavigator
//
//  Created by Jash Dhinoja on 19/04/2021.
//

import UIKit

class CartListViewController: UIViewController {
    
    //MARK:- Properties
    var cart = [Product]()
    
    //TableView
    @IBOutlet weak var cartTableView: UITableView!
    
    //MARK:- Handlers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let userCart = CurrentUser.shared?.cart else { return }
        cart = userCart
        cartTableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CurrentUser.shared?.cart = cart
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        configUI()
    }
    
    func configUI(){
        title = "Cart"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Checkout", style: .plain, target: self, action: #selector(checkoutButtonPressed))
        
        cartTableView.tableFooterView = UIView()
    }
    
    @objc func checkoutButtonPressed(){
        let alert = UIAlertController(title: "Oreder Placed!!!!", message: "Your order has been placed. Sit back and relax!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension CartListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.isEmpty ? 1 : cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cart.isEmpty{
            return tableView.dequeueReusableCell(withIdentifier: "cartEmpyCell") ?? UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartProductCell") as! CartProductTableViewCell
        cell.configUI(product: cart[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if cart.isEmpty{
            return
        }
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Delete \(cart[indexPath.row].name)", message: "Are you sure you want delete \" \(cart[indexPath.row].name)\" ?", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.cart.remove(at: indexPath.row)
                self.cartTableView.deleteRows(at: [indexPath], with: .automatic)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(alert, animated: true)
        }
    }
}
