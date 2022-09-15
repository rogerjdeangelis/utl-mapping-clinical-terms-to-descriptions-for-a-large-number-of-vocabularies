%let pgm=cdm_010mtaEx1;

OHSDI does not appear to have ICD11 codes yet.

The question is often more interesting than the answer, think about jeopardy.

The comman data model is a great way to explore questions you might want to pursue.

Suppose you want to know all the codes relating to answers that reference 'age-related cataracts' in the OHSDI Concept table;

proc sql;
  create
     table sqlQry as
  select
     vocabulary_id
    ,concept_code
    ,concept_name
  from
     cdx.concept
  where
          upcase(concept_name) contains 'AGE-RELATED CATARACT'
;quit;

All Obs(42) from dataset sqlQry

       VOCABULARY_
Obs        ID         CONCEPT_CODE         CONCEPT_NAME

  1      ICD10CM      H25                  Age-related cataract
  2      ICD10CM      H25.01               Cortical age-related cataract
  3      ICD10CM      H25.011              Cortical age-related cataract, right eye
  4      ICD10CM      H25.012              Cortical age-related cataract, left eye
  5      ICD10CM      H25.013              Cortical age-related cataract, bilateral
  6      ICD10CM      H25.019              Cortical age-related cataract, unspecified eye
  7      ICD10CM      H25.03               Anterior subcapsular polar age-related cataract
  8      ICD10CM      H25.031              Anterior subcapsular polar age-related cataract, right eye
  9      ICD10CM      H25.032              Anterior subcapsular polar age-related cataract, left eye
 10      ICD10CM      H25.033              Anterior subcapsular polar age-related cataract, bilateral
 11      ICD10CM      H25.039              Anterior subcapsular polar age-related cataract, unspecified eye
 12      ICD10CM      H25.04               Posterior subcapsular polar age-related cataract
 13      ICD10CM      H25.041              Posterior subcapsular polar age-related cataract, right eye
 14      ICD10CM      H25.042              Posterior subcapsular polar age-related cataract, left eye
 15      ICD10CM      H25.043              Posterior subcapsular polar age-related cataract, bilateral
 16      ICD10CM      H25.049              Posterior subcapsular polar age-related cataract, unspecified eye
 17      ICD10CM      H25.2                Age-related cataract, morgagnian type
 18      ICD10CM      H25.20               Age-related cataract, morgagnian type, unspecified eye
 19      ICD10CM      H25.21               Age-related cataract, morgagnian type, right eye
 20      ICD10CM      H25.22               Age-related cataract, morgagnian type, left eye
 21      ICD10CM      H25.23               Age-related cataract, morgagnian type, bilateral
 22      ICD10CM      H25.8                Other age-related cataract
 23      ICD10CM      H25.81               Combined forms of age-related cataract
 24      ICD10CM      H25.811              Combined forms of age-related cataract, right eye
 25      ICD10CM      H25.812              Combined forms of age-related cataract, left eye
 26      ICD10CM      H25.813              Combined forms of age-related cataract, bilateral
 27      ICD10CM      H25.819              Combined forms of age-related cataract, unspecified eye
 28      ICD10CM      H25.89               Other age-related cataract
 29      ICD10CM      H25.9                Unspecified age-related cataract
 30      SNOMED       347471000119101      Cortical age-related cataract of right eye
 31      SNOMED       347531000119100      Cortical age-related cataract of left eye
 32      SNOMED       347591000119101      Bilateral cortical age-related cataract eyes
 33      SNOMED       726404007            Coronary age-related cataract
 34      SNOMED       726405008            Punctate age-related cataract
 35      SNOMED       10999281000119103    Age-related cataract of right eye
 36      SNOMED       10999321000119108    Age-related cataract of left eye
 37      SNOMED       10999361000119103    Bilateral age-related cataract
 38      SNOMED       15738361000119101    Non age-related cataract of left eye
 39      SNOMED       15738401000119105    Non age-related cataract of bilateral eyes
 40      SNOMED       15738441000119107    Non age-related cataract of right eye
 41      SNOMED       155127007            Age-related cataract
 42      SNOMED       193582000            Age-related cataract
