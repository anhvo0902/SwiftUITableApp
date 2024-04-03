//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Vo, Anh Vo on 4/1/24.
//

import SwiftUI
import MapKit



    let data = [
        Item(name: "Buenos Aires Cafe", desc: "Upscale bistro spotlighting Argentine cuisine ", lat: 30.271502855825293, long: -97.72886037647798, imageName: "rest1"),
        Item(name: "Sijie Special Noodles", desc: "Amazing grill beef tendon with Chinese BBQ seasoning ", lat: 30.480516782775005, long: -97.79287564552497, imageName: "rest2"),
        Item(name: "Tacos El Charly", desc: "The most affordable tacos and yet, with the best homemade sauces", lat:30.365719369278136, long: -97.69682804550698, imageName: "rest3"),
        Item(name: "Gyu Kaku Japanese BBQ", desc: "Japanese restaurant that has famous Lady M for dessert ", lat: 30.268745939401352, long: -97.72957674952563, imageName: "rest4"),
        Item(name: "Valentina's Tex Mex BBQ", desc: "Permanent trailer for mesquite-smoked BBQ with a Tex Mex Twist", lat: 30.08074227975026, long: -97.8461902601336, imageName: "rest5")
       
]

    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
    }





struct ContentView: View {
    
    // add this at the top of the ContentView struct. In this case, you can choose the coordinates for the center of the map and Zoom levels
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.726220), span: MKCoordinateSpan(latitudeDelta:0.9, longitudeDelta: 0.07))

    
    
    
    
    
    var body: some View {
        NavigationView {
           VStack {
               List(data, id: \.name) { item in
                   
                   NavigationLink(destination: DetailView(item: item)) {
                   
                   HStack {
                       Image(item.imageName)
                           .resizable()
                           .frame(width: 50, height: 50)
                           .cornerRadius(10)
                   VStack(alignment: .leading) {
                           Text(item.name)
                               .font(.headline)
                           
                       } // end internal VStack
                   } // end HStack
                       
                   } //end NavigationView
                       
               } // end List
               
               
               //add this code in the ContentView within the main VStack.
                          Map(coordinateRegion: $region, annotationItems: data) { item in
                              MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                  Image(systemName: "mappin.circle.fill")
                                      .foregroundColor(.red)
                                      .font(.title)
                                      .overlay(
                                          Text(item.name)
                                              .font(.subheadline)
                                              .foregroundColor(.black)
                                              .fixedSize(horizontal: true, vertical: false)
                                              .offset(y: 25)
                                      )
                              }
                          } // end map
                          .frame(height: 300)
                          .padding(.bottom, -30)
                          
                              
               
               
               
           } // end VStack
            
           .listStyle(PlainListStyle())
                   .navigationTitle("Austin Restaurants")
               } // end NavigationView
            
       } // end body


           
}


struct DetailView: View {
    
    // put this at the top of the DetailView struct to control the center and zoom of the map. It will use the item's coordinates as the center. You can adjust the Zoom level with the latitudeDelta and longitudeDelta properties
    @State private var region: MKCoordinateRegion
    
    init(item: Item) {
        self.item = item
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
    }
    
    
    
        let item: Item
                
        var body: some View {
            VStack {
                Image(item.imageName)
                    .resizable()
                    //.aspectRatio(contentMode: .fit)
                    
                
                    .frame(width:
                            UIScreen.main.bounds.size.width)
                
                //.frame(maxWidth: 200)
            
                Text("Description: \(item.desc)")
                    .font(.subheadline)
                    .padding(10)
                
                
                // include this within the VStack of the DetailView struct, below the content. Reads items from data into the map. Be careful to close curly braces properly.

                    Map(coordinateRegion: $region, annotationItems: [item]) { item in
                      MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                          Image(systemName: "mappin.circle.fill")
                              .foregroundColor(.red)
                              .font(.title)
                              .overlay(
                                  Text(item.name)
                                      .font(.subheadline)
                                      .foregroundColor(.black)
                                      .fixedSize(horizontal: true, vertical: false)
                                      .offset(y: 25)
                              )
                      }
                  } // end Map
                      .frame(height: 300)
                      .padding(.bottom, -30)
                    
                        
                
                
                
                
                    } // end VStack
                     .navigationTitle(item.name)
                     Spacer()
            
            
            

         } // end body
      } // end DetailView
    



#Preview {
    ContentView()
}
