//
//  ViewController.swift
//  QRScanner
//
//  Created by Anil Yadav on 15/02/25.
//  Email: anilyadavjnt@gmail.com
//  Contact No: +91-975211420
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        view.backgroundColor = .white
    }

    @IBAction func scanQRCode(_ sender: Any) {
        self.resultLabel.text = ""
        
        // Simple QR Code Scanner
        let scanner = QRCodeScannerController()
        scanner.delegate = self
        self.present(scanner, animated: true, completion: nil)
    }
    
    @IBAction func scanQRCodeWithExtraOptions(_ sender: Any) {
        self.resultLabel.text = ""
        
        // Configuration for QR Code Scanner
        var configuration = QRScannerConfiguration()
        configuration.cameraImage = UIImage(named: "camera")
        configuration.flashOnImage = UIImage(named: "flash-on")
        configuration.galleryImage = UIImage(named: "photos")
        
        let scanner = QRCodeScannerController(qrScannerConfiguration: configuration)
        scanner.delegate = self
        self.present(scanner, animated: true, completion: nil)
    }
}

extension ViewController: QRScannerCodeDelegate {
    func qrScanner(_ controller: UIViewController, didScanQRCodeWithResult result: String) {
        self.resultLabel.text = "Result: \n \(result)"
        self.resultLabel.numberOfLines = 0
        print("result:\(result)")
    }
    
    func qrScanner(_ controller: UIViewController, didFailWithError error: QRScanner.QRCodeError) {
        print("error:\(error.localizedDescription)")
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        print("QR Controller did cancel")
    }
}

// MARK: - QRScannerCodeDelegate Protocol
protocol QRScannerCodeDelegate: AnyObject {
    func qrScanner(_ controller: UIViewController, didScanQRCodeWithResult result: String)
    func qrScanner(_ controller: UIViewController, didFailWithError error: QRCodeError)
    func qrScannerDidCancel(_ controller: UIViewController)
}

// MARK: - QRCodeError Enum
enum QRCodeError: Error {
    case cameraNotAvailable
    case videoInputInitializationFailure
    case metadataOutputFailure
    var localizedDescription: String {
        switch self {
        case .cameraNotAvailable:
            return "Camera not available"
        case .videoInputInitializationFailure:
            return "Failed to initialize camera input"
        case .metadataOutputFailure:
            return "Failed to capture metadata output"
        }
    }
}

// MARK: - QRScannerConfiguration Struct
struct QRScannerConfiguration {
    var cameraImage: UIImage?
    var flashOnImage: UIImage?
    var galleryImage: UIImage?
}

// MARK: - QRCodeScannerController Class
class QRCodeScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    weak var delegate: QRScannerCodeDelegate?
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    init(qrScannerConfiguration: QRScannerConfiguration? = nil) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            delegate?.qrScanner(self, didFailWithError: .cameraNotAvailable)
            dismiss(animated: true)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            delegate?.qrScanner(self, didFailWithError: .videoInputInitializationFailure)
            dismiss(animated: true)
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            delegate?.qrScanner(self, didFailWithError: .videoInputInitializationFailure)
            dismiss(animated: true)
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            delegate?.qrScanner(self, didFailWithError: .metadataOutputFailure)
            dismiss(animated: true)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            delegate?.qrScanner(self, didScanQRCodeWithResult: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func dismissScanner() {
        delegate?.qrScannerDidCancel(self)
        dismiss(animated: true)
    }
}




