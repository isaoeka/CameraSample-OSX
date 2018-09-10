//
//  ViewController.swift
//  CameraSample-OSX
//
//  Created by isaoeka on 2018/09/10.
//  Copyright © 2018年 isaoeka. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {
    
    @IBOutlet weak var cameraView: NSView!
    
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cameraView.layer = CALayer()
        self.captureSession.sessionPreset = AVCaptureSession.Preset.low
        
        let devices = AVCaptureDevice.devices(for: AVMediaType.video)
        dump(devices)
        self.captureDevice = devices.first
        
        if let captureDevice = self.captureDevice {
            do {
                try self.captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
                self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                self.previewLayer?.frame = self.cameraView.frame
                
                self.cameraView.layer?.addSublayer(self.previewLayer!)
                self.captureSession.startRunning()
            } catch {
                print(AVCaptureSessionErrorKey.description)
            }
        }
    }
    
}
