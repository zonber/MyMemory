//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by 조영빈 on 2018. 10. 17..
//  Copyright © 2018년 ChoYoungBeen. All rights reserved.
//

import UIKit

class MemoReadVC: UIViewController {
    //콘텐츠 데이터를 저장하는 변수
    var param: MemoData?
    
    @IBOutlet var subject: UILabel!
    @IBOutlet var contents: UILabel!
    @IBOutlet var img: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //제목, 내용, 이미지출력
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        //날짜 포맷 변환
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        
        self.navigationItem.title = dateString
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
