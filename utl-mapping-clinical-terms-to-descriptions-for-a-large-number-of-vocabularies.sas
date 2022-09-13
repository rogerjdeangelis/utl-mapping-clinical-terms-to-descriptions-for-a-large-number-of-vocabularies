%let pgm=utl-mapping-clinical-terms-to-descriptions-for-a-large-number-of-vocabularies;

Adapting the OHSDI-OMOP Common Data Model for Clinical Mapping

Problem: Given a list of ICD10 codes lookup the descriptions

github
https://tinyurl.com/ys94cj2t
https://github.com/rogerjdeangelis/utl-mapping-clinical-terms-to-descriptions-for-a-large-number-of-vocabularies

  Two Solutions
       1. SQL query
       2. SAS format

Download the mapping database from here
https://1drv.ms/u/s!AovFHZtMPA-7gQdvGvmXalzN4r_H?e=rsnf0V

/*
 _                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

* list of ICD10 Codes;
%let lst =
        'H34.8320'
       ,'L97.301 '
       ,'M12.862 '
       ,'S52.352P'
       ,'S62.009 '
       ,'S62.291K'
       ,'S65.302D'
       ,'S83.004 '
       ,'T23.312D'
       ,'T25.032A'
       ,'V04.138A'
       ,'W30.2XXS'
      ;

Source: https://academy.ehden.eu/  Common Meta Model Schema

D:\cdm
|   concept.sas7bdat              ==> we only this for now
|   concept_ancestor.sas7bdat
|   concept_class.sas7bdat
|   concept_relationship.sas7bdat
|   concept_synonym.sas7bdat
|   domain.sas7bdat
|   drug_strength.sas7bdat
|   relationship.sas7bdat
\   vocabulary.sas7bdat


AVAILABLE MAPPINGS - WE WILL BE USING ICD10CM

VOCABULARY_ID           Frequency   VOCABULARY_ID           Frequency  VOCABULARY_ID           Frequency
----------------------------------  ---------------------------------- ----------------------------------
ABMS                          98    Korean Revenue Code            7   RxNorm                    294929
ATC                         6396    LOINC                     250287   RxNorm Extension         2042129
CDM                          950    Meas Type                     12   SNOMED                   1035027
CMS Place of Service          60    Medicare Specialty           120   SPL                       522448
Concept Class                414    Metadata                       2   Sponsor                        6
Condition Status              22    NDC                      1049730   Type Concept                  79
Condition Type               118    NUCC                         855   UB04 Point of Origin          22
Cost                          51    None                           1   UB04 Pri Typ of Adm            6
Cost Type                      8    Note Type                     10   UB04 Pt dis status            55
Currency                     180    OMOP Extension             76401   UB04 Typ bill                298
Death Type                    14    OSM                       203339   UCUM                        1006
Device Type                    4    Obs Period Type                6   US Census                     13
Domain                        64    Observation Type              29   Visit                         16
Drug Type                     16    PHDSC                        162   Visit Type                    18
Episode                       18    Plan                          11   Vocabulary                   138
Ethnicity                      2    Plan Stop Reason              13
Gender                         5    Procedure Type                97
HCPCS                      10793    Race                          53
ICD10CM                    96924    Relationship                 640
ICD9CM                     17564    Revenue Code                 538
ICD9Proc                    4657



/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

  VOCABULARY_ID   CONCEPT_CODE     CONCEPT_NAME

  ICD10CM         H34.8320         Tributary (branch) retinal vein occlusion, left eye, with
                                   macular edema

  ICD10CM         L97.301          Non-pressure chronic ulcer of unspecified ankle limited to
                                   breakdown of skin

  ICD10CM         M12.862          Other specific arthropathies, not elsewhere classified, left
                                   knee

  ICD10CM         S52.352P         Displaced comminuted fracture of shaft of radius, left arm,
                                   subsequent encounter for closed fracture with malunion

  ICD10CM         S62.009          Unspecified fracture of navicular [scaphoid] bone of
                                   unspecified wrist

  ICD10CM         S62.291K         Other fracture of first metacarpal bone, right hand, subsequent
                                   encounter for fracture with nonunion

  ICD10CM         S65.302D         Unspecified injury of deep palmar arch of left hand, subsequent
                                   encounter

  ICD10CM         S83.004          Unspecified dislocation of right patella

  ICD10CM         T23.312D         Burn of third degree of left thumb (nail), subsequent encounter

  ICD10CM         T25.032A         Burn of unspecified degree of left toe(s) (nail), initial
                                   encounter

  ICD10CM         V04.138A         Pedestrian on other standing micro-mobility pedestrian
                                   conveyance injured in collision with heavy transport vehicle or
                                   bus in traffic accident, initial encounter

  ICD10CM         W30.2XXS         Contact with hay derrick, sequela


 /*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
 _               _
/ |    ___  __ _| |
| |   / __|/ _` | |
| |_  \__ \ (_| | |
|_(_) |___/\__, |_|
              |_|
*/

libname cdm "D:\cdm";

proc sql;
  create
     table sqlQry as
  select
     vocabulary_id
    ,concept_code
    ,concept_name
  from
     cdm.concept
  where
          vocabulary_id    = "ICD10CM"
     and  concept_code in (
            'H34.8320'
           ,'L97.301 '
           ,'M12.862 '
           ,'S52.352P'
           ,'S62.009 '
           ,'S62.291K'
           ,'S65.302D'
           ,'S83.004 '
           ,'T23.312D'
           ,'T25.032A'
           ,'V04.138A'
           ,'W30.2XXS'
          )
;quit;

proc report data=sqlQry missing ;
define  concept_name / display flow width=64;
run;quit;

/*___       __                            _
|___ \     / _| ___  _ __ _ __ ___   __ _| |_
  __) |   | |_ / _ \| `__| `_ ` _ \ / _` | __|
 / __/ _  |  _| (_) | |  | | | | | | (_| | |_
|_____(_) |_|  \___/|_|  |_| |_| |_|\__,_|\__|

*/

data cdm.cdm_IcdTenCtl( where =( uniform(4321) < 9/96925 )
       keep=
             start
             label
             hlo
             fmtname
      );

   retain fmtname "$IcdTen2Des"  hlo "";

   set cdm.concept(
       keep  =
             concept_code
             concept_name
             vocabulary_id
       where = (
                 vocabulary_id    = "ICD10CM"
       ))
       end = dne;

   start = concept_code;;
   label = concept_name;;

   output;

   if dne then do ;
      hlo   = "O" ;
      start = "**OTHER**" ;
      label = "UNKNOWN"   ;
      output;
   end ;

run;quit;

proc format cntlin=cdm.cdm_IcdTenCtl;
run;quit;

data fmt ;

 array trm[12] $8 (
       'H34.8320'
      ,'L97.301 '
      ,'M12.862 '
      ,'S52.352P'
      ,'S62.009 '
      ,'S62.291K'
      ,'S65.302D'
      ,'S83.004 '
      ,'T23.312D'
      ,'T25.032A'
      ,'V04.138A'
      ,'W30.2XXS' );

do idx=1 to dim(trm);
  concept_code = trm[idx] ;
  concept_name = put(trm[idx],$IcdTen2Des.);
  output;
end;
keep
  concept_code
  concept_name
  ;
run;quit;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
