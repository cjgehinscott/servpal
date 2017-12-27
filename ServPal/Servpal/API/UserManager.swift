import UIKit
import Alamofire
import ObjectMapper

class UserManager {

    func login(email: String, password: String, completion: @escaping (Result<User>?,SPError?) -> Void) {

        ServPalApiManager.login(email, password) { response, error in
            if let user = response?.userBody?.user {
                user.phpSessionId = response?.phpSessionId
                if UserManager.getUser() != nil && UserManager.getUser()?.id != user.id{
                    RealmManager.shared.delete(objects: [(UserManager.getUser())!], completion: {
                        RealmManager.shared.save(objects: [user]) {
                            completion(.success(user),nil)
                        }
                    })
                }else{
                    RealmManager.shared.save(objects: [user]) {
                        completion(.success(user),nil)
                    }
                }
            } else if let serverError = error {
                completion(nil,serverError)
            }
        }
    }

    func register(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<User>) -> Void) {

        ServPalApiManager.signUp("member", email, password, firstName, lastName) { user, error in
            if let user = user {
                //save user
                RealmManager.shared.save(objects: [user]) {
                   completion(.success(user))
                }
            } else if let serverError = error {
                completion(.failure(serverError))
            }
        }
    }

    static func getUser() -> User? {
        return User.allObjects(in: RealmManager.shared.realm).firstObject() as? User
    }
    
}
