import 'package:digitAT/models/model/User.dart';
import 'package:digitAT/models/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';

final doctorsId = 30;
final pharmahubId=32;
final scanItId=24;
final scanId=124;
final medId=126;
final labId=26;
final laId=58;
final coId=164;
final hospitalsId=28;
  PageNav pageNav= PageNav.min("PharmaHub", pharmahubId.toString(),"");
  PageNav pageNavScan= PageNav.min("Imaging Centers", scanItId.toString(),"");
  PageNav pageNavLab= PageNav.min("Laboritories", labId.toString(),"");
  PageNav pageNavCov= PageNav.min("Cov-ID", coId.toString(),"");
  PageNav pageNavDoc= PageNav.min("Doctors", doctorsId.toString(),"");
  
 User fireStoreUser;
 List<int> myDoctors=[];
 List<int> depts=[];
 FirebaseUser firebaseUser;

 final specialitiesList=[
   {"display":"24hour Clinic","value":"24hour Clinic",},
{"display":"Accident And Emergency Rooms","value":"Accident And Emergency Rooms",},
{"display":"Acupuncturist","value":"Acupuncturist",},
{"display":"Acupunture Centre","value":"Acupunture Centre",},
{"display":"Air Ambulance","value":"Air Ambulance",},
{"display":"Ambulance","value":"Ambulance",},
{"display":"Anaesthetist Rooms","value":"Anaesthetist Rooms",},
{"display":"Audiology Practice","value":"Audiology Practice",},
{"display":"Biokinetic Practice","value":"Biokinetic Practice",},
{"display":"Cardiovascular And Thoracic Centre","value":"Cardiovascular And Thoracic Centre",},
{"display":"Central Hospital","value":"Central Hospital",},
{"display":"Chiropody/Podiatry Rooms","value":"Chiropody/Podiatry Rooms",},
{"display":"Clinical Social Work","value":"Clinical Social Work",},
{"display":"Dental Laboratory","value":"Dental Laboratory",},
{"display":"Dental Unit","value":"Dental Unit",},
{"display":"Dermatology Practice","value":"Dermatology Practice",},
{"display":"Diabetes Centre","value":"Diabetes Centre",},
{"display":"Dieteic Practice","value":"Dieteic Practice",},
{"display":"District Hospital","value":"District Hospital",},
{"display":"Government Hospital","value":"Government Hospital",},
{"display":"Health Food Services Private Practice","value":"Health Food Services Private Practice",},
{"display":"Industrial Clinic","value":"Industrial Clinic",},
{"display":"Laboratory","value":"Laboratory",},
{"display":"Maternity Hospital","value":"Maternity Hospital",},
{"display":"Maxillo-Facial and Oral Practice","value":"Maxillo-Facial and Oral Practice",},
{"display":"Medical Rooms","value":"Medical Rooms",},
{"display":"Mission Clinic","value":"Mission Clinic",},
{"display":"Mission Hospital","value":"Mission Hospital",},
{"display":"Mobile Clinic","value":"Mobile Clinic",},
{"display":"Mobile Radiology Unit","value":"Mobile Radiology Unit",},
{"display":"Multidisciplinary Laboratory","value":"Multidisciplinary Laboratory",},
{"display":"Municipal Clinic","value":"Municipal Clinic",},
{"display":"Natural Therapy Unit","value":"Natural Therapy Unit",},
{"display":"Neurosurgery Practice","value":"Neurosurgery Practice",},
{"display":"Nurse Training","value":"Nurse Training",},
{"display":"Nursing Home","value":"Nursing Home",},
{"display":"Obstetrician And Gynaecology Rooms","value":"Obstetrician And Gynaecology Rooms",},
{"display":"Occupational Therapy Rooms","value":"Occupational Therapy Rooms",},
{"display":"Ophthalmology Clinic","value":"Ophthalmology Clinic",},
{"display":"Optical Rooms","value":"Optical Rooms",},
{"display":"Optometry Unit","value":"Optometry Unit",},
{"display":"Orthodontic Practice","value":"Orthodontic Practice",},
{"display":"Orthopaedic Practice","value":"Orthopaedic Practice",},
{"display":"Otolaryngology Practice","value":"Otolaryngology Practice",},
{"display":"Paediatric Clinic","value":"Paediatric Clinic",},
{"display":"Pharmaceutical Manufacturer","value":"Pharmaceutical Manufacturer",},
{"display":"Pharmaceutical Wholesale","value":"Pharmaceutical Wholesale",},
{"display":"Pharmacy","value":"Pharmacy",},
{"display":"Physiotherapy Rooms","value":"Physiotherapy Rooms",},
{"display":"Private Clinic","value":"Private Clinic",},
{"display":"Private Hospital","value":"Private Hospital",},
{"display":"Provincial Hospital","value":"Provincial Hospital",},
{"display":"Psychiatric Unit","value":"Psychiatric Unit",},
{"display":"Psychology Unit","value":"Psychology Unit",},
{"display":"Radiology Unit","value":"Radiology Unit",},
{"display":"Radiotherapy and Oncology Unit","value":"Radiotherapy and Oncology Unit",},
{"display":"Rehabilitation Unit","value":"Rehabilitation Unit",},
{"display":"Renal Unit","value":"Renal Unit",},
{"display":"Research Laboratory","value":"Research Laboratory",},
{"display":"Rural Clinic","value":"Rural Clinic",},
{"display":"Rural Health Centre","value":"Rural Health Centre",},
{"display":"Specialist Physician Practice","value":"Specialist Physician Practice",},
{"display":"Specialist Surgical Practice","value":"Specialist Surgical Practice",},
{"display":"Specilaist Ortorhinolaryngologist","value":"Specilaist Ortorhinolaryngologist",},
{"display":"Speech Therapy Unit","value":"Speech Therapy Unit",},
{"display":"Theatre","value":"Theatre",},
{"display":"Urology Surgery","value":"Urology Surgery",},
{"display":"Voluntary Counselling and Testing Site","value":"Voluntary Counselling and Testing Site",},
{"display":"Specialist Plastic And Reconstructive Surgeon","value":"Specialist Plastic And Reconstructive Surgeon",},
{"display":"Specialist Radiologist","value":"Specialist Radiologist",},
{"display":"Specialist Radiotherapist And Oncology","value":"Specialist Radiotherapist And Oncology",},
{"display":"Specialist Surgeon","value":"Specialist Surgeon",},
{"display":"Specialist Ultrasonographer","value":"Specialist Ultrasonographer",},
{"display":"Specialist Urologist","value":"Specialist Urologist",},
{"display":"Specialist Venereologist","value":"Specialist Venereologist",},
{"display":"Speech Therapist","value":"Speech Therapist",},
{"display":"Speicalist Pathologist","value":"Speicalist Pathologist",},
{"display":"State Certified Maternity Nurse","value":"State Certified Maternity Nurse",},
{"display":"State Certified Nurse","value":"State Certified Nurse",},
{"display":"Surgeon","value":"Surgeon",},
{"display":"Ultrasonographer","value":"Ultrasonographer",},
{"display":"Virologist","value":"Virologist",},
 ];

 final partnersList=[
                   {"display":"Ambulance",
                   "value":"Ambulance",
                   },
                  {"display":"Blood Bank",
                  "value":"Blood Bank",
                  },

                  {"display":"Clinic",
                  "value":"Clinic",
                  },
                  {"display":"Doctor",
                  "value":"Doctor",
                  },
                  {"display":"Fitness Center",
                  "value":"Fitness Center",
                  },
                  {"display":"Hospital ",
                  "value":"Hospital",
                  },
                  {"display":"Imaging Center ",
                  "value":"Imaging Center",
                  },
                  {"display":"Laboratory ",
                  "value":"Laboratory",
                  },
                  {"display":"Pharmacy ",
                  "value":"Pharmacy",
                  },
                  ];
final citiesList=[
                         {
                          "display": "Harare",
                      "value": "Harare",
                         },
                           {
                          "display": "Bulawayo",
                      "value": "Bulawayo",
                         },
                         {
                          "display": "Chitungwiza",
                      "value": "Chitungwiza",
                         },
                           {
                          "display": "Mutare",
                      "value": "Mutare",
                         },
                           {
                          "display": "Epworth",
                      "value": "Epworth",
                         },
                           {
                          "display": "Gweru",
                      "value": "Gweru",
                         },
                           {
                          "display": "Kwekwe",
                      "value": "Kwekwe",
                         },
                           {
                          "display": "Kadoma",
                      "value": "Kadoma",
                         },
                           {
                          "display": "Masvingo",
                      "value": "Masvingo",
                         },
                           {
                          "display": "  Chinhoyi",
                      "value": "  Chinhoyi",
                         },
                           {
                          "display": "Norton",
                      "value": "Norton",
                         },
                           {
                          "display": "Marondera",
                      "value": "Marondera",
                         },
                           {
                          "display": "Ruwa",
                      "value": "Ruwa",
                         },
                           {
                          "display": "Chegutu",
                      "value": "Chegutu",
                         },
                           {
                          "display": "Zvishavane",
                      "value": "Zvishavane",
                         },
                           {
                          "display": "Bindura",
                      "value": "Bindura",
                         },
                           {
                          "display": "Beitbridge",
                      "value": "Beitbridge",
                         },
                           {
                          "display": "Redcliff",
                      "value": "Redcliff",
                         },
                           {
                          "display": "Victoria Falls",
                      "value": "Victoria Falls",
                         },
                           {
                          "display": "Hwange",
                      "value": "Hwange",
                         },
                           {
                          "display": "Rusape",
                      "value": "Rusape",
                         },
                           {
                          "display": " Chiredzi",
                      "value": " Chiredzi",
                         },
                           {
                          "display": "Kariba",
                      "value": "Kariba",
                         },
                           {
                          "display": "Karoi",
                      "value": "Karoi",
                         },
                           {
                          "display": "Chipinge",
                      "value": "Chipinge",
                         },
                           {
                          "display": "Gokwe",
                      "value": "Gokwe",
                         },
                           {
                          "display": "Shurugwi",
                      "value": "Shurugwi",
                         }
                          

                  
                  ];
final professionsList=[{"display":"Acupuncturist","value":"Acupuncturist",},
{"display":"Ambulance Technician","value":"Ambulance Technician",},
{"display":"Anaesthetist","value":"Anaesthetist",},
{"display":"Audiologist","value":"Audiologist",},
{"display":"Biokinetist","value":"Biokinetist",},
{"display":"Biomedical Scientist","value":"Biomedical Scientist",},
{"display":"Cardiologist","value":"Cardiologist",},
{"display":"Chiropodist","value":"Chiropodist",},
{"display":"Chiropractor","value":"Chiropractor",},
{"display":"Clinical Biochemist","value":"Clinical Biochemist",},
{"display":"Clinical Psychologist","value":"Clinical Psychologist",},
{"display":"Clinical Scientists","value":"Clinical Scientists",},
{"display":"Clinical Social Worker","value":"Clinical Social Worker",},
{"display":"Consultant Physician","value":"Consultant Physician",},
{"display":"Dental Practitioner","value":"Dental Practitioner",},
{"display":"Dental Surgeon","value":"Dental Surgeon",},
{"display":"Dental Technicians","value":"Dental Technicians",},
{"display":"Dental Therapist","value":"Dental Therapist",},
{"display":"Dermatologist","value":"Dermatologist",},
{"display":"Dietician","value":"Dietician",},
{"display":"Dispensing Optician","value":"Dispensing Optician",},
{"display":"Emergency Medical Technician","value":"Emergency Medical Technician",},
{"display":"Family Practitioner","value":"Family Practitioner",},
{"display":"General Practitioner","value":"General Practitioner",},
{"display":"Gynaecologist","value":"Gynaecologist",},
{"display":"Hearing Aid Specialist","value":"Hearing Aid Specialist",},
{"display":"Hiv Testing Nurse","value":"Hiv Testing Nurse",},
{"display":"Homeopath","value":"Homeopath",},
{"display":"Immunologist","value":"Immunologist",},
{"display":"Medical Laboratory Scientist","value":"Medical Laboratory Scientist",},
{"display":"Medical Micro Biologist","value":"Medical Micro Biologist",},
{"display":"Midwife","value":"Midwife",},
{"display":"Neuro Surgeon","value":"Neuro Surgeon",},
{"display":"Nurse","value":"Nurse",},
{"display":"Nurse Aide","value":"Nurse Aide",},
{"display":"Obstetrician","value":"Obstetrician",},
{"display":"Obstetrician And Gynaecologist","value":"Obstetrician And Gynaecologist",},
{"display":"Occupational Therapist","value":"Occupational Therapist",},
{"display":"Opthalmologist","value":"Opthalmologist",},
{"display":"Optician","value":"Optician",},
{"display":"Optometrist","value":"Optometrist",},
{"display":"Orthopaedic Surgeon","value":"Orthopaedic Surgeon",},
{"display":"Orthopaedic Technologist","value":"Orthopaedic Technologist",},
{"display":"Paediatrician","value":"Paediatrician",},
{"display":"Paramedic","value":"Paramedic",},
{"display":"Pharmacist","value":"Pharmacist",},
{"display":"Pharmacy Technician","value":"Pharmacy Technician",},
{"display":"Physiotherapist","value":"Physiotherapist",},
{"display":"Primary Care Nurse","value":"Primary Care Nurse",},
{"display":"Prosthestist And Orthotist","value":"Prosthestist And Orthotist",},
{"display":"Psychiatric Nurse","value":"Psychiatric Nurse",},
{"display":"Psychiatrist","value":"Psychiatrist",},
{"display":"Psychologist","value":"Psychologist",},
{"display":"Radiographer","value":"Radiographer",},
{"display":"Rapid Human Immunodeficiency Virus Testing Nurse","value":"Rapid Human Immunodeficiency Virus Testing Nurse",},
{"display":"Registered General Nurse","value":"Registered General Nurse",},
{"display":"Rehabilitation Technician","value":"Rehabilitation Technician",},
{"display":"Sonographer","value":"Sonographer",},
{"display":"Specialist","value":"Specialist",},
{"display":"Specialist Bacteriologist","value":"Specialist Bacteriologist",},
{"display":"Specialist Cardiovascular And Thoracic Surgeon","value":"Specialist Cardiovascular And Thoracic Surgeon",},
{"display":"Specialist Chemical Pathologist","value":"Specialist Chemical Pathologist",},
{"display":"Specialist Community Physician","value":"Specialist Community Physician",},
{"display":"Specialist Haematologist","value":"Specialist Haematologist",},
{"display":"Specialist Human Genetics","value":"Specialist Human Genetics",},
{"display":"Specialist Maxillo Facial And Oral Surgeon","value":"Specialist Maxillo Facial And Oral Surgeon",},
{"display":"Specialist Oncologist","value":"Specialist Oncologist",},
{"display":"Specialist Orthodontist","value":"Specialist Orthodontist",},
{"display":"Specialist Otorhinolaryngologist","value":"Specialist Otorhinolaryngologist",},
{"display":"Specialist Pathologist","value":"Specialist Pathologist",},
{"display":"Specialist Physician","value":"Specialist Physician",},
{"display":"Specialist Plastic And Reconstructive Surgeon","value":"Specialist Plastic And Reconstructive Surgeon",},
{"display":"Specialist Radiologist","value":"Specialist Radiologist",},
{"display":"Specialist Radiotherapist And Oncology","value":"Specialist Radiotherapist And Oncology",},
{"display":"Specialist Surgeon","value":"Specialist Surgeon",},
{"display":"Specialist Ultrasonographer","value":"Specialist Ultrasonographer",},
{"display":"Specialist Urologist","value":"Specialist Urologist",},
{"display":"Specialist Venereologist","value":"Specialist Venereologist",},
{"display":"Speech Therapist","value":"Speech Therapist",},
{"display":"Speicalist Pathologist","value":"Speicalist Pathologist",},
{"display":"State Certified Maternity Nurse","value":"State Certified Maternity Nurse",},
{"display":"State Certified Nurse","value":"State Certified Nurse",},
{"display":"Surgeon","value":"Surgeon",},
{"display":"Ultrasonographer","value":"Ultrasonographer",},
{"display":"Virologist","value":"Virologist",},];