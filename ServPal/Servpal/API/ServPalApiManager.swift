import UIKit
import Alamofire
import ObjectMapper

class ServPalApiManager:NSObject{

    #if DEBUG
        static let kBaseUrl = "https://dev.servpal.com/"
    #else
        static let kBaseUrl = "https://www.servpal.com/"
    #endif

    #if DEBUG
        static let cookieDomain = ".dev.servpal.com"
    #else
        static let cookieDomain = ".servpal.com"
    #endif
    
    static func login(_ email:String, _ password:String,_ completion: ((LoginResponse?,SPError?)->())?){
        let url = URL(string: kBaseUrl + "api/login?mobile=true")
        let params = ["email": email, "password": password]
        let headers = ["Content-Type":"application/x-www-form-urlencoded", "X-Requested-With": "XMLHttpRequest"]
        Alamofire.request(url!, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).debugLog().responseJSON { response in
            if response.response?.statusCode ?? 0 >= 200 && response.response?.statusCode ?? 0 < 300 {
                if let loginResponse = Mapper<LoginResponse>().map(JSONObject: response.value){
                    //add the php session id to the login response so that we can store it to the user model to be persisted for the session

                    if let cookies = HTTPCookieStorage.shared.cookies,
                       let sessionCookie = cookies.first(where: { $0.name == "PHPSESSID" && $0.domain == cookieDomain }) {
                        loginResponse.phpSessionId = sessionCookie.value
                    }
                    completion?(loginResponse, nil)
                }
            }else{
                completion?(nil,Mapper<SPError>().map(JSONObject: response.value))
                
            }
        }
    }
    
    static func signUp(_ role: String, _ email:String, _ password:String, _ firstName:String, _ lastName:String, _ completion: ((User?,Error?)->())?){
        let url  = URL(string: kBaseUrl + "api/user")
        let params = ["role": role, "email": email, "password": password, "firstName":firstName, "lastName":lastName, "mobile": "true"]
        let headers = ["Content-Type":"application/x-www-form-urlencoded", "X-Requested-With": "XMLHttpRequest"]
        Alamofire.request(url!, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let createUserResponse = response.value as? [String:Any]{
                    if let user = Mapper<User>().map(JSONObject: createUserResponse["user"]){
                        completion?(user,nil)
                    }
                }
            case .failure(let error):
                completion?(nil,error)
                print(error.localizedDescription)
            }
        }
    }
    
    static func getUserBy(_ id:String, _ completion:((User?,Error?)->())?){
        let url  = URL(string: kBaseUrl + "api/user?" + id)
        let headers = ["Content-Type":"application/x-www-form-urlencoded", "X-Requested-With": "XMLHttpRequest"]
        Alamofire.request(url!, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let createUserResponse = response.value as? [String:Any]{
                    if let user = Mapper<User>().map(JSONObject: createUserResponse["user"]){
                        completion?(user,nil)
                    }
                }
            case .failure(let error):
                completion?(nil,error)
                print(error.localizedDescription)
            }
        }
    }
    
    static func findProfessionalsBy(_ searchTerm: String?, _ completion: (([Professional]?,Error?)->())?){
        let url = URL(string: kBaseUrl + "professionals/find/" + (searchTerm ?? ""))
        let headers = ["Content-Type":"application/x-www-form-urlencoded", "X-Requested-With": "XMLHttpRequest"]
        Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            print("Find Professionals reponses: <---- \(response) ----->")
            switch response.result{
            case .success:
                if let responseJSON = response.value as? [String:Any]{
                    if let professionals = Mapper<Professional>().mapArray(JSONObject: responseJSON["professionals"]){
                        completion?(professionals,nil)
                    }
                }
            case .failure(let error):
                completion?(nil,error)
                print(error.localizedDescription)
            }
        }
    }
}


extension Request {
    public func debugLog() -> Self {
#if DEBUG
        debugPrint(self)
#endif
        return self
    }
}
