//
//  NotesBottomSheet.swift
//  DXE Price
//
//  Created by iOS Developer on 11/04/24.
//

import UIKit

class NotesBottomSheet: UIViewController, UITextViewDelegate {
    @IBOutlet var lblHeading :UILabel!
    @IBOutlet var txtNotes :UITextView!
    @IBOutlet weak var wordCountLabel: UILabel!
    let maxWordCount = 200
    let placeholderText = "Add your note"
    var notesDelegate : NotesAddDelegate? = nil
    var noteTag = Int()
    var heading = String()
    var note = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblHeading.text = heading
        self.txtNotes.text = placeholderText
        //self.txtNotes.textColor = UIColor.lightGray
        self.txtNotes.delegate = self
        self.txtNotes.text = note
        updateWordCount()
    }
    
    func textViewDidChange(_ textView: UITextView) {
          updateWordCount()
          limitTextViewWordCount()
      }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.text == placeholderText {
               textView.text = ""
               textView.textColor = UIColor.black
           }
       }
       
       func textViewDidEndEditing(_ textView: UITextView) {
           if textView.text.isEmpty {
               textView.text = placeholderText
               textView.textColor = UIColor.lightGray
           }
       }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Hide the keyboard when the "Done" button is tapped
            textField.resignFirstResponder()
            return true
        }
    
    func updateWordCount() {
            let words = txtNotes.text.split(separator: " ").filter { !$0.isEmpty }
            let wordCount = words.count
            let wordsLeft = maxWordCount - wordCount
            wordCountLabel.text = "\(wordsLeft) words left"
        }
        
        func limitTextViewWordCount() {
            let words = txtNotes.text.split(separator: " ").filter { !$0.isEmpty }
            if words.count > maxWordCount {
                let newText = words.prefix(maxWordCount).joined(separator: " ")
                txtNotes.text = newText
                updateWordCount()
            }
        }
    
    @IBAction func btanActionCancel(){
        self.dismiss(animated: true)
        notesDelegate?.notesAdd(notes: self.txtNotes.text ?? "", noteTag: self.noteTag)
    }
    
    @IBAction func btanActionSave(){
        self.dismiss(animated: true)
        notesDelegate?.notesAdd(notes: self.txtNotes.text ?? "", noteTag: self.noteTag)
    }

}
