//
//  DemoCRUD.swift
//  DemoSwiftUI
//
//  Created by Apple on 11/11/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import SwiftUI
import Combine

let url = "https://jsonplaceholder.typicode.com/users"

class User: Decodable, Identifiable {
    var name: String
    var username: String
    init(name: String, username: String) {
        self.name = name
        self.username = username
    }
}


class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    
    var supcription: AnyCancellable?
    
    func getUser() {
        supcription = ApiService.share.getUser().sink(receiveCompletion: { _ in
            
        }, receiveValue: { (svUsers) in
            self.users = svUsers
        })
        
        
    }
    init() {
//        getListUser()
        getUser()
    }
    
//    func getListUser() {
//        guard let url = URL(string: url) else {
//            return
//        }
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            guard let data = data else {return}
//            do {
//                let svUsers = try JSONDecoder().decode([User].self, from: data)
//                DispatchQueue.main.async {
//                    self.users = svUsers
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
    
    func deleteUser(atIndex: Int) {
        users.remove(at: atIndex)
    }
}


struct DemoCRUDListUser: View {
    
    @ObservedObject var viewModel: UserViewModel = UserViewModel()

    var body: some View {
        NavigationView {

            List (self.viewModel.users.indices, id: \.self) { index in
                
                HStack {
                    Text(self.viewModel.users[index].name)
                  
                    NavigationLink(destination: UpdateName(completion: { newName, index  in
                        print(newName, index)
                        self.viewModel.users[index].name = newName
                        self.viewModel.objectWillChange.send()
                        
                    }, deleteUser: { index in
                        self.viewModel.deleteUser(atIndex: index)
                    }, index: index)) {
                        Text("")
                    }
                }
                
            }
            .navigationBarTitle("User")
            
            
            
        }
        
    }
}

struct DemoCRUD_Previews: PreviewProvider {
    static var previews: some View {
        DemoCRUDListUser()
    }
}
