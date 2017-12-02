//
//  RealmManager.swift
//  ServPal
//
//  Created by CJ Gehin-Scott on 11/8/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import Realm

protocol RealmManagerProtocol {
    func willDelete()
}

class SPRLMObject: RLMObject, RealmManagerProtocol {
    func willDelete() {}
}


class RealmManager: NSObject {
    
    static let shared = RealmManager()
    let realmSerialQueue = DispatchQueue(label: "RealmQueue")
    var realm: RLMRealm {
        #if DEBUG
            return RLMRealm.default()
        #else
            let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                                 appropriateFor: nil, create: false)
            let url = documentDirectory.appendingPathComponent("encrypted.realm")
            do{
                try RLMRealm.default().writeCopy(to: url, encryptionKey: getKey() as Data)
            }catch{
                if error.localizedDescription.contains("already exists"){
                    return RLMRealm.default()
                }else{
                    print(error.localizedDescription)
                }
            }
            return RLMRealm.default()
        #endif
    }
    private var isRunningTests: Bool {
        let environment = ProcessInfo.processInfo.environment
        return (environment["XCInjectBundleInto"] != nil);
    }
    
    func save(objects: [RLMObject]?, completion: (() -> Void)?) {
        
        realmSerialQueue.async { [unowned self] in
            do {
                if let realmObjects = objects {
                    self.realm.beginWriteTransaction()
                    for realmObject in realmObjects {
                        if realmObject.classForCoder.primaryKey() != nil {
                            self.realm.addOrUpdate(realmObject)
                        } else {
                            self.realm.add(realmObject)
                        }
                    }
                    try self.realm.commitWriteTransaction()
                    DispatchQueue.global(qos: .default).async {
                        completion?()
                    }
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func delete(objects: [SPRLMObject]?, completion: (() -> Void)?) {
        
        guard let objectsToDelete = objects else { return }
        var threadSafeReferences = [RLMThreadSafeReference<RLMThreadConfined>]()
        for object in objectsToDelete {
            object.willDelete()
            let personRef = RLMThreadSafeReference(threadConfined: object)
            threadSafeReferences.append(personRef as! RLMThreadSafeReference<RLMThreadConfined>)
        }
        
        realmSerialQueue.async { [unowned self] in
            do {
                var realmObjectsOnSameThread = [RLMObject]()
                for aReference in threadSafeReferences {
                    if let realmObjectOnSameThread = self.realm.__resolve(aReference) as? RLMObject {
                        realmObjectsOnSameThread.append(realmObjectOnSameThread)
                    }
                }
                self.realm.beginWriteTransaction()
                self.realm.deleteObjects(realmObjectsOnSameThread as NSFastEnumeration)
                try self.realm.commitWriteTransaction()
                DispatchQueue.global(qos: .default).async {
                    completion?()
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func deleteAllObjects() {
        realmSerialQueue.async { [unowned self] in
            do {
                self.realm.beginWriteTransaction()
                self.realm.deleteAllObjects()
                try self.realm.commitWriteTransaction()
            } catch {
                print("Error: \(error)")
                
            }
        }
    }
    
    private func getKey() -> NSData {
        // Identifier for our keychain entry
        let keychainIdentifier = kRealmSecKey
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        
        // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! NSData
        }
        
        // No pre-existing key from this application, so generate a new one
        let keyData = NSMutableData(length: 64)!
        let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
        assert(result == 0, "Failed to get random bytes")
        
        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: keyData
        ]
        
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        
        return keyData
    }
}
