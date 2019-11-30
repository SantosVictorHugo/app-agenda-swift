//
//  Pessoa.swift
//  agendaApp
//
//  Created by pos on 01/11/2019.
//  Copyright © 2019 Victor Hugo. All rights reserved.
//

import Foundation
import UIKit

class Pessoa {
    var nome : String
    var telefone : Int
    var categoria : String
    
    init(nome: String, telefone: Int, categoria: String) {
        self.nome = nome
        self.telefone = telefone
        self.categoria = categoria
    }
}
