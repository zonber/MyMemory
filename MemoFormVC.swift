//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by 조영빈 on 2018. 10. 17..
//  Copyright © 2018년 ChoYoungBeen. All rights reserved.
//
import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var subject: String!  // 메모 제목
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    
    override func viewDidLoad() {
        self.contents.delegate = self
        //super.viewDidLoad()
    }
    
    // 저장 버튼
    @IBAction func save(_ sender: Any) {
        // 내용을 입력하지 않은경우 경고
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        
        
        // MemoData 객체를 생성하고 데이터를 담음
        let data = MemoData()
        
        data.title = self.subject                       // 제목
        data.contents = self.contents.text    // 내용
        data.image = self.preview.image      // 이미지
        data.regdate = Date()                        // 작성 시각
        
        // 앱 델리개이트 객체를 읽어온 다음 memolist 배열에 MemoData 객체를 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        // 작성폼 화면을 종료하고 이전 화면으로 돌아감
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // 카메라 버튼
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 인스턴스 생성
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // 알림창 객체 생성
        let alert = UIAlertController(title: nil, message: "이미지를 가져올 곳을 선택해주세요.", preferredStyle: .actionSheet)
        
        // 카메라
        let camera = UIAlertAction(title: "카메라", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                // 이미지 피커 화면 표시
                self.present(picker, animated: false)
            }
        }
        
        // 저장앨범
        let savedAlbum = UIAlertAction(title: "저장앨범", style: .default) { (_) in
            picker.sourceType = .savedPhotosAlbum
            // 이미지 피커 화면 표시
            self.present(picker, animated: false)
        }
        // 사진 라이브러리
        let photoLibrary = UIAlertAction(title: "사진 라이브러리", style: .default) {(_) in
            picker.sourceType = .photoLibrary
            // 이미지 피커 화면 표시
            self.present(picker, animated: false)
        }
        
        // 취소
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        // 버튼을 컨트롤러에 등록
        alert.addAction(camera)
        alert.addAction(savedAlbum)
        alert.addAction(photoLibrary)
        alert.addAction(cancel)
        
        // 알림창 실행
        self.present(alert, animated: false)
    }
    // MARK:- UIImagePickerControllerDelegate
    // 이미지 선택을 완료했을 때 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택된 이미지를 미리보기에 표시
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        // 이미지 피커 컨트롤러를 닫음
        picker.dismiss(animated: false)
    }
    
    // MARK:- UITextViewDelegate
    // 텍스트 뷰의 내용이 변경될 때마다 호출됨
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 15자리까지 읽어 subject 변수에 저장
        let contents = textView.text as NSString
        let length = (contents.length > 15) ? 15 : contents.length
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        // 내비게이션 타이틀에 표시
        self.navigationItem.title = subject
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
