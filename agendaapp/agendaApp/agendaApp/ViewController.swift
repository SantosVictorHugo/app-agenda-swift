//
//  ViewController.swift
//  agendaApp
//
//  Created by pos on 13/09/2019.
//  Copyright © 2019 Victor Hugo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var listTable : [Pessoa] = [Pessoa]()
    var contacts: [Contato] = [Contato]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadCoreData(){
        let resultadoPesquisa = NSFetchRequest<NSFetchRequestResult>(entityName: "Contato")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let contatos = try context.fetch(resultadoPesquisa)
            
            if contatos.count > 0 {
                for contato in contatos as! [NSManagedObject] {
                    if let nomeContato = contato.value(forKey: "nome"){
                        if let telefoneContato = contato.value(forKey: "telefone"){
                            print("\(String(describing: nomeContato))(\(String(describing: telefoneContato)))")
                            let pessoa = Pessoa(nome: String(describing: nomeContato), telefone: Int(String(describing: telefoneContato))!, categoria: String("sem"))
                            listTable.append(pessoa)
                        }
                    }
                }
            } else {
                print("Sem dados")
            }
        } catch {
            print("Erro na consulta")
        }
    }
    
   override func numberOfSections(in: UITableView) -> Int {
            return 1
        }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //(reuseIdentifier)
            return listTable.count
    }
        
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            //Vamos usar a célula padrão mesmo
            let celulaIdentifier = "cell"
        
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: celulaIdentifier)
        
            let cell = tableView.dequeueReusableCell(withIdentifier: celulaIdentifier,for: indexPath)
        
            cell.textLabel?.text = listTable[indexPath.row].nome
            cell.detailTextLabel?.text = String(listTable[indexPath.row].telefone)
            return cell
        }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        contacts = getDataFromDataBase()
        
        let contact = contacts[indexPath.row]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do{
            managedContext.delete(contact)
            try managedContext.save()
            contacts = getDataFromDataBase();
            self.tableView.reloadData()
            
            let alert = UIAlertController(title: "Sucesso", message: "Contato removido", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            
            
        }catch{
            
            print("Failed")
            
        }
        
        viewWillAppear(true)
    }

    
    func getDataFromDataBase() -> [Contato]{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contato")
        
        
        
        var contactsFromCoreData = [Contato]()
        
        do{
            
            let result = try context.fetch(fetchRequest)
            
            for data in result as! [Contato]{
                
                contactsFromCoreData.append(data)
                
            }
            
        }catch{
            
            print("Não foi possível recuperar os contatos salvos na base de dados")
            
        }
        
        
        
        return contactsFromCoreData
        
    }
     
    override func viewWillAppear(_ animated: Bool) {
        listTable.removeAll()
        loadCoreData()
        self.tableView.reloadData()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

