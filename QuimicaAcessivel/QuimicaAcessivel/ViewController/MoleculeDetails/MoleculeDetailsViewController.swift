//
//  MoleculeDetailsViewController.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 27/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import SceneKit
import Speech

class MoleculeDetailsViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    var molecule: Molecule?
    let audioEngine = AVAudioEngine()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: .init(identifier: "pt"))
    var recognitionTask: SFSpeechRecognitionTask?
    @IBOutlet weak var moleculeName: UILabel?
    @IBOutlet weak var moleculeDescription: UILabel?
    @IBOutlet weak var moleculeImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        view.addGestureRecognizer(tapGesture)
        speechRecognizer?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let m = molecule else { return }
        
        moleculeName?.text = m.name
        moleculeDescription?.text = m.description
        moleculeImage?.image = m.image
        startAudioEngine()
        tapAudioEngineToSpeechRecognition()
        setupSpeechRecognition()
    }
    
    @objc func didTapScreen() {
        dismiss(animated: true)
    }
    
    private func startAudioEngine() {
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("error")
        }
    }
    
    private func tapAudioEngineToSpeechRecognition() {
        let node = audioEngine.inputNode
        let format = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 124, format: format) { buffer, _ in
            self.request.append(buffer)
        }
    }
    
    private func setupSpeechRecognition() {
        guard let myRecognizer = SFSpeechRecognizer(), !myRecognizer.isAvailable else { return }
        recognitionTask = speechRecognizer?.recognitionTask(with: request) { result, error in
            if let result = result {
                self.didRecognize(result.bestTranscription.formattedString)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func didRecognize(_ string: String) {
        switch string {
        case "continuar", "parar", "voltar", "retroceder", "retornar":
            dismiss(animated: true)
        default:
            break
        }
    }
    

}
