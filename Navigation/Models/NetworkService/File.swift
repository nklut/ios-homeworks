//
//  File.swift
//  Navigation
//
//  Created by Nikita on 21.08.2025.
//


do {
            let message = try JSONSerialization.jsonObject(with: data) as! [String: Any]
            
            let userID = message["userId"] as! Int8
            let id = message["id"] as! Int8
            let title = message["title"] as! String
            let completed = message["completed"] as! Bool
            
            let toDoList = ToDoList(userId: userID, id: id, title: title, completed: completed)
            
            print(message)
            
        } catch {
            print(error.localizedDescription)
        }