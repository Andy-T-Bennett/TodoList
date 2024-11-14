//
//  ListViewModel.swift
//  TodoList
//
//  Created by Andy Bennett on 11/13/24.
//

import Foundation

/*
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 
 */

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        // called anytime this items array is changed
        didSet {
            saveItems()
        }
    }
    
    
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        // ability to guard and unwrap multiple things
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem: ItemModel = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        
        // this loops through the list of items and finds the Item that has an Id that matches the item passed into the function
        //if let index = items.firstIndex { (existingItem) -> Bool in
        //    return existingItem.id == item.id
        //} {
        //    // run this code
        //}
        
        // This is the same as the code above
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
        
    }
    
    func saveItems() {
        // converts items array into JSON and stores in UserDefaults
        if let encodedDate = try? JSONEncoder().encode(items) {
            UserDefaults.standard.setValue(encodedDate, forKey: itemsKey)
        }
    }
    
}
