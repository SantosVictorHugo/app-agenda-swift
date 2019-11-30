//
//  AddViewController.swift
//  agendaApp
//
//  Created by pos on 20/09/2019.
//  Copyright © 2019 Victor Hugo. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var telefone: UITextField!
    @IBOutlet weak var selectOpcao: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    @IBAction func salvarBotao(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let contato = NSEntityDescription.insertNewObject(forEntityName: "Contato", into: context)
        
        let telefoneAsNumber = Int(telefone.text!)
        let optionSelectedAstext = pickerData[selectOpcao.selectedRow(inComponent: 0)]
        
        print(optionSelectedAstext)
        
        contato.setValue(nome.text, forKey: "nome")
        contato.setValue(telefoneAsNumber, forKey: "telefone")
        contato.setValue(optionSelectedAstext, forKey: "categoria")

        do {
            try context.save()
            print("Salvo")
        } catch {
            print("Não Salvou")
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        pickerData = ["Amigo", "Colega", "Trabalho", "Esposa", "Marido"]

        self.selectOpcao.delegate = self
        self.selectOpcao.dataSource = self
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
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
