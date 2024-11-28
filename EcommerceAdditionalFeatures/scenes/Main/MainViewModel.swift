//
//  MainViewModel.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

class MainViewModel: ViewModel {
    
    
    func fetchUser(completion: Callback<User>?) {
        guard let user = UserDefaultsService.instance.currentUser else {
            return
        }
        completion?(user)
    }
    
    
    func loveEmailAdd(email: String, completion: Handler?) {
        fetchUser { user in
            DatabaseService.instance.addLoveUser(currentUser: user, email: email, completion: completion)
        }
    }
    
    
   /* func checkSomeOneAddedEmail(completion: Handler?) {
        DatabaseService.instance.checkEmailConfirmation(completion: completion)
    } */
    
    
  /*  func checkSomeOneAddedEmail(completion: Handler?) {
        DatabaseService.instance.checkEmailConfirmation { isEmailConfirmed in
            if isEmailConfirmed {
                self.show(message: "E-mail confirmed", type: .success)
                completion?()
            }
            else {
                let noAction = AlertModel(title: "No")
                
                let yesAction = AlertModel(title: "Yes") {
                    DatabaseService.instance.myConfirmEmail(completion: completion)
                   // completion?()
                    
                    
                }
                
                DatabaseService.instance.addedTheMailInformation { partnerEmail in
                    self.showAlert(type: .warning, message: "\(partnerEmail) mailine sahip kişi sana davet gönderdi.Partnerinle ortak ürün zevklerini bulmaya var mısın? ", actions: [noAction, yesAction])
                }
                completion?()
                
            }
            
            
        }
    } */
    
   func checkSomeOneAddedEmail(completion: Callback<Bool>?) {
          DatabaseService.instance.checkEmailConfirmation { isEmailConfirmed in
             completion?(isEmailConfirmed)
              
              
          }
      }
    
    func confirmControl(completion: Handler?) {
        DatabaseService.instance.myConfirmEmail {
            completion?()
        }
    }
    
    func getAddedTheMailInformation(completion: Callback<String>?) {
        DatabaseService.instance.addedTheMailInformation { partnerEmail in
            completion?(partnerEmail)
        }
    }
    
    func partnerFor(completion: Callback<Bool>?) {
        DatabaseService.instance.otherPersonForCheckEmailConfirmation(completion: completion)
    }
   
}



