//
//  ExportView.swift
//  HRVMonitor WatchKit Extension
//
//  Created by bchalpin on 6/2/22.
//


import SwiftUI


struct ExportView: View {
   @EnvironmentObject var storageService: StorageService
  
   // used for exporting files to iOS app
   @EnvironmentObject var watchExportSession: WatchExportSession
  
   @State var isExported = false
  
   var body: some View {
       VStack {
           Text("EXPORT")
               .fontWeight(.semibold)
               .font(.system(size: 20))
               .frame(maxWidth: .infinity,
                      alignment: .topLeading)
          
           Text("Your data will be exported to your iPhone Files app. Find the file named: export.json")
               .frame(maxWidth: .infinity,
                      maxHeight: .infinity,
                      alignment: .center)
               .multilineTextAlignment(.center)
               .font(.system(size: 14))
          
           Spacer()
          
           if (!self.isExported) {
               Button(action: {
                   self.exportData()
               }) {
                       Text("Export")
                       .foregroundColor(BUTTON_COLOR)
               }
           }
           else {
               Button(action: {
                   // dummy button
               }) {
                       Text("Exported")
                       .foregroundColor(Color.gray)
               }
               .disabled(true)
           }
       }
       .onDisappear {
           self.isExported = false
       }
   }
  
   private func exportData() {
       let csv = self.storageService.exportAllDataToCsv() // assuming this function exists to export data to CSV format
       sendDataToPhoneViaWC(dataToExport: csv)


       // disable the button
       self.isExported = true
   }


   // private func exportData() {
   //     let json = self.storageService.exportAllDataToJson()
   //     sendDataToPhoneViaWC(dataToExport: json)
      
   //     // disable the button
   //     self.isExported = true
   // }
  
   private func sendDataToPhoneViaWC(dataToExport: String) {
       let csv = self.storageService.exportAllDataToCsv() // assuming this function exists to export data to CSV format
       guard let baseDirUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
           return
       }
       let fileUrl = baseDirUrl.appendingPathComponent("export.csv") // change the file extension to .csv
       let string = dataToExport.data(using: .utf8)
       FileManager.default.createFile(atPath: fileUrl.path, contents: string)
       self.watchExportSession.transferFile(fileUrl, metadata: nil)
   }


   // private func sendDataToPhoneViaWC(dataToExport: String) {
   //     guard let baseDirUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
   //         return
   //     }
      
   //     let fileUrl = baseDirUrl.appendingPathComponent("export.json")
   //     let fileContent = dataToExport.data(using: .utf8)
   //     FileManager.default.createFile(atPath: fileUrl.path, contents: fileContent)


   //     self.watchExportSession.session?.transferFile(fileUrl, metadata: nil)
   // }
}


struct ExportView_Previews: PreviewProvider {
   static var previews: some View {
       ExportView()
   }
}



