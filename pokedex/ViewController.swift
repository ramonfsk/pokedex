//
//  ViewController.swift
//  pokedex
//
//  Created by student on 12/07/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    var database: Connection?
    var pokemons: Table?
    var userPokemons: Table?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseName = "database.sqlite3"
        checkIfDatabaseExists(databaseName: databaseName)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createDatabase(with path: String) -> Connection {
        
        do {
            // O diretório Documents
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
            // Dando append no diretório + o nome da base de dados
            let databasePath = documentsPath.appendingPathComponent(path)
            
            // Criando a conexão
            let db = try Connection(databasePath)
            return db
        } catch {
            fatalError("Não conseguiu criar database local")
        }
    }
    
    func checkIfDatabaseExists(databaseName: String) {
        let fileManager = FileManager.default
        let dirPaths = fileManager.urls(for: .documentDirectory,in: .userDomainMask)
        let databasePath = dirPaths[0].appendingPathComponent(databaseName).path
        print(databasePath)
        if !fileManager.fileExists(atPath: databasePath as String) {
            print("Base de dados ainda não existe.")
            self.database = createDatabase(with: databaseName)
            self.pokemons = createTablePokemons(with: "pokemons")
            self.userPokemons = createTableUserPokemons(with: "userPokemons")
        } else {
            print("Base de dados existente. Fazendo conexão...")
            self.database = createDatabase(with: databaseName)
            self.pokemons = Table("pokemons")
            self.userPokemons = Table("userPokemons")
        }
    }

}

