

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView:MKMapView!
    
    
    var restaurant:Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //define delegate of mapView
        
        mapView.delegate = self

        // Do any additional setup after loading the view.
        
        //display options
        
         mapView.showsCompass = true
         mapView.showsScale = true
         mapView.showsTraffic = true
        
 
        
        
        //converting rest. address to coordinates
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: {
            placemarks, error in
            
            if (error != nil) {
                print(error)
                return
            }
            
            //the address string returns an array of placemarks, the less placemarks the more accurate
            
            //display the first placemark
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                
                //create an annotation and set the labels accordingly
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    //displaying the annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
            
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        //we dont want to change the annotation of the user location -- the 'blue dot' on the map (not currently displayed)
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        //reuse annotation if possible
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        
        //create a new annotationView if needed
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        //create an imageView and size the frame, add the image, then add the icon to the annotation
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIconView.image = UIImage(data: restaurant.image!)
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        annotationView?.pinTintColor = UIColor(red: 242.0/255.0, green: 116.0/225.0, blue: 119.0/225.0, alpha: 1.0)
        
        //return the updated annotation
        return annotationView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
