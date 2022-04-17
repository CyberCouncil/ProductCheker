// for My portfolio - project "Product Checker"
// Created by Evgenii Nikolaev © on 22.02.2022
// Евгений Николаев © 22.02.2022
import SwiftUI
import Foundation
import CodeScanner
import AudioToolbox



struct ContentView: View {
    @State var isPresentingScanner = false
    @State private var alertIsPresented = false
    @State var scannedCode: String = "site"
    @State var getData = API(name: "name note found", barcode: 000, description: "discription not found", img: "#")
    @State var imgU: String = "https://myporfolio.cybercouncil.repl.co/media/images/7B0FA6B3-3DF8-439C-842D-362A08BBC5BA.jpeg"
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.ean13],
            completion: {result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.getProductAPI(barcode: scannedCode)
                    AudioServicesPlaySystemSound(SystemSoundID(1003))
                    self.isPresentingScanner = false
                    print("Штрих-код получен")
                    print(scannedCode)
                }
            }
        )
    }
    
        func getProductAPI(barcode: String) {
            let headers = [
                "Key": "6e37227592mshb200bd545848fc6p1d633bjsnb3587e8215a1"
            ]
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://myporfolio.cybercouncil.repl.co/API/v0/product/barcode/\(barcode)/")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            print("https://myporfolio.cybercouncil.repl.co/API/v0/product/barcode/\(barcode)/")
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                DispatchQueue.main.async {
                    if (error != nil) {
                        print(error)
                    } else {
                        let httpResponse = response as? HTTPURLResponse
                        if httpResponse?.statusCode == 404 {
                            self.alertIsPresented = true
                            return
                        }
                    }
                    if let data = data {
                    do {
                        let decorder = JSONDecoder()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MMMM dd, yyyy"
                        decorder.dateDecodingStrategy = .formatted(dateFormatter)
                        let decodedData = try decorder.decode(API.self, from: data)
                        
                        self.getData = decodedData
                        let str = getData.img
                        var arr = str.components(separatedBy: ":")
                        arr.removeFirst()
                        self.imgU = "https:" + arr.joined(separator: ":")
                        print(getData.img)
                        
                    } catch {
                        print(error)
                    }
                    }
                }
            })
            dataTask.resume()
            
        }
    
    var body: some View {
        VStack {
            if scannedCode != "site"{
                HStack{
                AsyncImage(url: URL(string: imgU)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400)
                } placeholder: {
                    ProgressView()
                }
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("EAN13:")
                                .bold()
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .fontWeight(.light)
                                
                            Text(String(getData.barcode))
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        Text(getData.name)
                            .bold()
                            .font(.title)
                        
                        Spacer()
                            .frame(maxHeight:50)
                        
                        
                        Text(getData.description)
                            .font(.system(size: 16))
                        
                        Spacer()
                            .frame(maxHeight:100)
                        
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                    }
                    .frame(maxWidth: 400, alignment: .leading)
                    
                }
                    Spacer()
                
                Link(destination: URL(string: "https://myporfolio.cybercouncil.repl.co/product/" + scannedCode)!, label:{
                    Text("Посмотреть на сайте")
                        .bold()
                        .frame(width: 280, height: 50)
                        .foregroundColor(.white)
                        .background(Color.indigo)
                        .cornerRadius(12)
                        .padding()
                    
                })
                
            } else {
                Image(systemName: "barcode.viewfinder")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.red)
                    .imageScale(.large)
                    .foregroundColor(Color.red)
                    
                
                Text("Проверь продукт по штрих-коду")
                    .font(.title)
                    .bold()
                    .padding(20)
            }
            
            
            Button("Сканировать штрих код") {
                AudioServicesPlaySystemSound(SystemSoundID(1003))
                self.isPresentingScanner = true
            }
            .frame(width: 280, height: 50)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(12)
            .sheet(isPresented: $isPresentingScanner){
                self.scannerSheet
            }
                   
            Text("только штрих коды EAN13")
                .font(.subheadline)
                .foregroundColor(.gray)
            
        }
        .padding(20)
        .alert(isPresented: $alertIsPresented, content:{ Alert(title: Text("Error"), message: Text("Product is not found or barcode is incoreccted"), dismissButton: .default(Text("Ok")))
        })
    }
}

    

