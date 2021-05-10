//
//  AboutUsViewController.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 09/05/21.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    private let Spotifind: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 45, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let subTitle: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let theTeam: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 27, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let member1: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let member2: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let member3: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let member4: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let ourMentor: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 27, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let profesor: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let madeFor: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 27, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let subject: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let campus: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 1)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.5216, green: 0.949, blue: 0.502, alpha: 1.0)
        view.addSubview(Spotifind)
        view.addSubview(subTitle)
        view.addSubview(theTeam)
        view.addSubview(member1)
        view.addSubview(member2)
        view.addSubview(member3)
        view.addSubview(member4)
        view.addSubview(ourMentor)
        view.addSubview(profesor)
        view.addSubview(madeFor)
        view.addSubview(subject)
        view.addSubview(campus)
        
        Spotifind.text = "Spotifind"
        subTitle.text = "About us:"
        theTeam.text = "The Team"
        member4.text = "Manuel Alejandro Hernandez Lopez A01650390"
        member2.text = "Jose Antonio Berrón Gutiérrez A01377269"
        member1.text = "Aldo Ponce de la Cruz A01651119"
        member3.text = "Ignacio Alvarado Reyes A01656149"
        ourMentor.text = "Our Mentor"
        profesor.text = "Dr. José Martín Molina Espinosa"
        madeFor.text = "Made for"
        subject.text = "Mobile Devices Development"
        campus.text = "Project @ ITESM CCM"

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Spotifind.frame = CGRect(x: 0, y: 90, width: view.width, height: 50)
        subTitle.frame = CGRect(x: 0, y: Spotifind.bottom-10, width: view.width, height: 50)
        theTeam.frame = CGRect(x: 0, y: subTitle.bottom+10, width: view.width, height: 50)
        member1.frame = CGRect(x: 0, y: theTeam.bottom-15, width: view.width, height: 50)
        member2.frame = CGRect(x: 0, y: member1.bottom-25, width: view.width, height: 50)
        member3.frame = CGRect(x: 0, y: member2.bottom-25, width: view.width, height: 50)
        member4.frame = CGRect(x: 0, y: member3.bottom-15, width: view.width, height: 50)
        ourMentor.frame = CGRect(x: 0, y: member4.bottom+30, width: view.width, height: 50)
        profesor.frame = CGRect(x: 0, y: ourMentor.bottom-15, width: view.width, height: 50)
        madeFor.frame = CGRect(x: 0, y: profesor.bottom+5, width: view.width, height: 50)
        subject.frame = CGRect(x: 0, y: madeFor.bottom-15, width: view.width, height: 50)
        campus.frame = CGRect(x: 0, y: subject.bottom-25, width: view.width, height: 50)
    }
    
    
    
}
