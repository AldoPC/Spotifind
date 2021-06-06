//
//  InterfaceController.swift
//  Spotifind WatchKit Extension
//
//  Created by Aldo Ponce de la Cruz on 01/06/21.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController{
    
    let session = WCSession.default
    
    @IBOutlet weak var songName: WKInterfaceLabel!
    @IBOutlet weak var artistName: WKInterfaceLabel!
    
    @IBOutlet weak var datosRecibidos: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        session.delegate = self
        session.activate()
    }
    
    
   
    
    override func willActivate() {
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}

extension InterfaceController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session:WCSession, didReceiveMessage message: [String : Any]){
        songName.setText(message["songName"] as! String)
        artistName.setText(message["artistName"] as! String)
    }
    
    
}
