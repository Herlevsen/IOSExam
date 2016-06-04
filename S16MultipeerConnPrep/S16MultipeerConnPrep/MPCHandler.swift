//
//  MPCHandler.swift
//  TicTacToe
//
//  Created by Training on 12/09/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import UIKit
import MultipeerConnectivity


class MPCHandler: NSObject, MCSessionDelegate {
   
    var peerID:MCPeerID!
    var session:MCSession!
    var browser:MCBrowserViewController!
    var advertiser:MCAdvertiserAssistant? = nil
    
    func setupPeerWithDisplayName (displayName:String){
        print("MPC L21 displayName: \(displayName)")
        
        peerID = MCPeerID(displayName: displayName)
    }
    
    func setupSession(){
       // print("MPC 27 setupSession called with peerID: \(peerID.description)")
        session = MCSession(peer: peerID)
        session.delegate = self
        print("MPC 30 peerID:  \(session.myPeerID)")
        
    }
    
    func setupBrowser(){
        browser = MCBrowserViewController(serviceType: "my-game", session: session)
    
    }
    
    func advertiseSelf(advertise:Bool){
        if advertise{
            advertiser = MCAdvertiserAssistant(serviceType: "my-game", discoveryInfo: nil, session: session)
            advertiser!.start()
        }else{
            advertiser!.stop()
            advertiser = nil
        }
    }
    
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        let userInfo = ["peerID":peerID,"state":state.rawValue]
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("MPC_DidChangeStateNotification", object: nil, userInfo: userInfo)
        })
        
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        let userInfo = ["data":data, "peerID":peerID]
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("MPC_DidReceiveDataNotification", object: nil, userInfo: userInfo)
        })
        
    }
    
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    
    
}
