import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    weak var coordinator: MapViewCoordinator?
    private let mapView = MKMapView()
    private let locationMananger = CLLocationManager()
    
    // CLLocationCoordinate2D(latitude: 59.9341, longitude: 30.3062)
    // CLLocationCoordinate2D(latitude: 59.8341, longitude: 30.2062)
    private var destinationCoordinate: CLLocationCoordinate2D?
    private var userCoordinate: CLLocationCoordinate2D?
    
    private lazy var buildRouteButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.setTitle("Build route", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapBuildRoute), for: .touchUpInside)
        return view
    }()
    
    private lazy var deleteRouteButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.setTitle("Delete route", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapDeleteRoute), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: "Short desc", message: "Long press to put a pin. Build and delete route buutons are at the bottom of the screen", preferredStyle: .alert)
        let shortIntro = UIAlertAction(title: "OK", style: .default)
        alert.addAction(shortIntro)
        self.present(alert, animated: true, completion: nil)
        
        setupUI()
        setupMap()
        setupLocation()
        setupLongPressGesture()
    }
    
    private func setupUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        view.addSubview(buildRouteButton)
        view.addSubview(deleteRouteButton)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            
            buildRouteButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            buildRouteButton.trailingAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: -50),
            
            deleteRouteButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            deleteRouteButton.leadingAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 50),
        ])
    }
    
    private func setupMap() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.userTrackingMode = .follow
    }
    
    private func setupLocation() {
        locationMananger.delegate = self
        locationMananger.requestWhenInUseAuthorization()
        locationMananger.startUpdatingLocation()
    }
    
    private func routeToDestination(from currentLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile
        
        MKDirections(request: request).calculate { [weak self] response, error in
            if let error = error {
                print("Route error:", error.localizedDescription)
                return
            }
            guard let route = response?.routes.first else {
                print("Rout not found")
                return
            }
            self?.mapView.removeOverlays(self?.mapView.overlays ?? [])
            self?.mapView.addOverlay(route.polyline)
            self?.mapView.setVisibleMapRect(route.polyline.boundingMapRect,
                                            edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50),
                                            animated: true)
            print("Route distance: \(route.distance) m")
        }
    }
    
    private func setupLongPressGesture() {
           let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
           longPress.minimumPressDuration = 0.5
           mapView.addGestureRecognizer(longPress)
       }
    
    @objc private func didTapDeleteRoute() {
        self.mapView.removeOverlays(self.mapView.overlays)
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let point = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            destinationCoordinate = coordinate
               
            // Delete old Pins and route
            mapView.annotations.forEach {
                if !($0 is MKUserLocation) {
                    mapView.removeAnnotation($0)
                }
            }
            self.mapView.removeOverlays(self.mapView.overlays)
               
            // Add new Pin
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Destination"
            mapView.addAnnotation(annotation)
        }
    }
    
    @objc private func didTapBuildRoute() {
        guard let userCoordinate = userCoordinate else {
            print("User location not found")
            return
        }
        guard let destinationCoordinate = destinationCoordinate else {
            print("Destination location not found")
            return
        }
        routeToDestination(from: userCoordinate, to: destinationCoordinate)
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        userCoordinate = location.coordinate
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapVieww: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .systemCyan
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
}
