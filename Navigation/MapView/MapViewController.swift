import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    weak var coordinator: MapViewCoordinator?
    private let mapView = MKMapView()
    private let pinCoordinate = CLLocationCoordinate2D(latitude: 59.9341, longitude: 30.3062)
    private let userCoordinate = CLLocationCoordinate2D(latitude: 59.8341, longitude: 30.2062)
    
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
        view.backgroundColor = .systemBackground
        
        view.addSubview(mapView)
        view.addSubview(buildRouteButton)
        view.addSubview(deleteRouteButton)
        setupUI()
        setupMap()
    }
    
    private func setupUI() {
        let safeArea = view.safeAreaLayoutGuide
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
        let customPin = MKPointAnnotation()
        let region = MKCoordinateRegion(center: userCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        customPin.coordinate = pinCoordinate
        customPin.title = "Saint Petersburg"
        customPin.subtitle = "Saint Isaac's Cathedral"
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(customPin)

    }
    
    private func routeToPin(from currentLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        
        let locationPlacemark = MKPlacemark(coordinate: currentLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: locationPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate() { [weak self] response, error in
            
            guard let self = self else { return }
            
            if let error = error {
                print("Route calculation error: ", error.localizedDescription)
                return
            }
            
            guard let route = response?.routes.first else {
                print("Route not found")
                return
            }
            
            print("Route distance: ", route.distance)
            
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.addOverlay(route.polyline)
            
            self.mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50),
                animated: true
            )
        }
    }
    
    @objc private func didTapDeleteRoute() {
        self.mapView.removeOverlays(self.mapView.overlays)
    }
    
    @objc private func didTapBuildRoute() {
        routeToPin(from: userCoordinate, to: pinCoordinate)
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapVieww: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .systemCyan
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }
}
