
import Foundation
import CoreData

class Restaurant:NSManagedObject {
    @NSManaged var name:String
    @NSManaged var type:String
    @NSManaged var location:String
    @NSManaged var isVisited:NSNumber?
    @NSManaged var image:NSData?
    @NSManaged var phoneNumber:String?
    @NSManaged var rating:String?
    
}

