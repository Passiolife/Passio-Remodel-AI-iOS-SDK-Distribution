//
//  ShowVotingViewController
//
//  Copyright © 2023 PassioLife Inc All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import Vision
import PassioRemodelAISDK

class VideoCameraPhotosViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackTreshold: UIStackView!
    @IBOutlet weak var segmentedTypes: UISegmentedControl!
    @IBOutlet weak var textTreshold: UITextField!

    var originalImageFromPicker: UIImage?
    var imageFromVideo: UIImage?
    var videoLayer: AVCaptureVideoPreviewLayer?

    var videoisOn = false {
        didSet {
            if videoisOn {
                imageView.image = nil
                startDetection()
            } else {
                stopDetection()
            }
        }
    }

    let passioSDK = PassioRemodelAI.shared
    let passioMetaData = PassioMetadataService()
    var activeModelType: ModelForDetection = .environment {
        didSet {
            if passioSDK.status.mode == .isReadyForDetection, videoisOn {
                startDetection()
            } else if let image = imageView.image {
                self.detectCandidatesInImagePassio(image: image)
            }
        }
    }

    var candidatesForTable = [CustomClassificationCandidate]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = tabBarItem?.title ?? "Video Camera Photos"
        allButtons.forEach {
            $0.roundMyCornerWith(radius: 12)
        }
        let passioConfig = PassioConfiguration(key: passioSDKKey)

        passioSDK.configure(passioConfiguration: passioConfig) { status in
            print( "SDK status = \(status)")
        }
        passioSDK.statusDelegate = self
        segmentedTypes.isHidden = true

        passioMetaData.getModelNames?.forEach {
            print( $0)
            print( passioMetaData.getPassioIDs(byModelName: $0) ?? "")
        }

        let cell = UINib(nibName: "VCPTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "VCPTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageView.image = nil
        stopDetection()
    }

    func startDetection() {
        setupVideoLayer()
        passioSDK.startCustomObjectDetection(modelName: activeModelType.mlModelName,
                                             customDetectionDelegate: self) { isReady in
            print("startCustomObjectDetection started \(isReady)" )
        }
    }

    func stopDetection() {
        passioSDK.stopCustomDetection()
        videoLayer?.removeFromSuperlayer()
        videoLayer = nil
        passioSDK.removeVidoeLayer()
    }

    func setupVideoLayer() {
        guard videoLayer == nil else { return }
        if let vLayer = passioSDK.getPreviewLayer() {
            self.videoLayer = vLayer
            videoLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoLayer?.frame = view.frame
            view.layer.insertSublayer(vLayer, at: 0)
        }
    }

    @IBAction func takeAPhoto(_ sender: UIButton) {
        videoisOn = false
        getImagePickerAndSetupUI(withSourceType: .camera)
    }

    @IBAction func searchAlbum(_ sender: UIButton) {
        videoisOn = false
        getImagePickerAndSetupUI(withSourceType: .photoLibrary)
    }

    @IBAction func toggleVideo(_ sender: UIButton? = nil) {
        if videoisOn {
            imageView.image = imageFromVideo ?? nil
        }
        videoisOn.toggle()
    }

    func getImagePickerAndSetupUI(withSourceType: UIImagePickerController.SourceType) {
        activityIndicator.startAnimating()
        candidatesForTable = []
        let picker = UIImagePickerController()
        picker.sourceType = withSourceType
        picker.mediaTypes = [kUTTypeImage as String]
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    func detectCandidatesInImagePassio(image: UIImage) {
        activityIndicator.startAnimating()
        let newHeight = imageView.frame.width * image.size.height / image.size.width
        imageViewHeight.constant = newHeight

        passioSDK.detectCustomPassioIDIn(image: image,
                                         modelName: activeModelType.mlModelName) { _, classCandidates in
            print("detectCustomPassioIDIn")
            if let candidates = classCandidates {
                self.candidatesForTable = candidates
            } else {
                self.candidatesForTable = []
            }

        }

    }

    @IBAction func detectionSwitched(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            activeModelType = .environment
        case 1:
            activeModelType = .surfaceMaterial
        case 2:
            activeModelType = .abnormality
        default:
            activeModelType = .environment
        }
    }

}

extension VideoCameraPhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.originalImageFromPicker = pickedImage
            self.imageView.image = pickedImage
            self.detectCandidatesInImagePassio(image: pickedImage)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        activityIndicator.stopAnimating()
        picker.dismiss(animated: true)
    }

}

extension VideoCameraPhotosViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        candidatesForTable.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VCPTableViewCell",
                                                       for: indexPath) as? VCPTableViewCell,
              candidatesForTable.count > indexPath.row else {
            return UITableViewCell()

        }

        let candidate = candidatesForTable[indexPath.row]
        let label = self.passioMetaData.getLabel(passioID: candidate.passioID) ?? "no label"
        cell.labelVoting.text = label + "  C = \(candidate.confidence.roundDigits(afterDecimal: 2))"// \(detected) \(candidate.confidence.roundDigits(afterDecimal: 2))"
        return cell
    }

}

extension VideoCameraPhotosViewController: UITableViewDelegate {

}

extension VideoCameraPhotosViewController: CustomDetectionDelegate {

    func customDetectionResult(customCandidates: [CustomCandidate]?,
                               hnnCandidates: [CustomClassificationCandidate]?,
                               classCandidates: [CustomClassificationCandidate]?,
                               image: UIImage?) {
        DispatchQueue.main.async {
            if let image = image {
                self.imageFromVideo = image
                let newHeight = self.imageView.frame.width * image.size.height / image.size.width
                self.imageViewHeight.constant = newHeight
            }
            if let candidates = classCandidates {
                self.candidatesForTable = candidates
            } else {
                self.candidatesForTable = []
            }

        }
    }

}

extension VideoCameraPhotosViewController: PassioStatusDelegate {

    func passioStatusChanged(status: PassioStatus) {
        if status.mode == .isReadyForDetection {
            DispatchQueue.main.async {
                self.segmentedTypes.isHidden = false
                self.videoisOn = true
            }
        }
    }

    func passioProcessing(filesLeft: Int) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.imageView.image = nil
        }
    }

    func completedDownloadingAllFiles(filesLocalURLs: [FileLocalURL]) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.imageView.image = nil
        }
    }

    func completedDownloadingFile(fileLocalURL: FileLocalURL, filesLeft: Int) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.imageView.image = nil
        }
    }

    func downloadingError(message: String) {
        print("downloadError   ---- =\(message)")
        DispatchQueue.main.async {
            self.imageView.image = nil
            self.activityIndicator.stopAnimating()
        }
    }

}

extension UIView {
    func roundMyCornerWith(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}

extension Double {
    func roundDigits(afterDecimal: Int) -> Double {
        let multiplier = pow(10, Double(afterDecimal))
        return (self * multiplier).rounded()/multiplier
    }
}
