# Characterizing pre-clinical sub-phenotypic models of acute respiratory distress syndrome: An experimental ovine study

Jonathan E Millar, Karin Wildi, Nicole Bartnikowski, Mahe Bouquet, Kieran Hyslop, Margaret R Passmore, Katrina K Ki, Nchafatso G Obonyo, Mengyao Yang, Sanne Pedersen, Sacha Rozencwajg, J Kenneth Baillie, Gianluigi Li Blassi, Jacky Y Suen, Daniel F McAuley, John F Fraser.

Physiological Reports (2021);9:e15048. DOI: 10.14814/phy2.15048

## Data

19 sheep

base = pre-injury
0_hrs = at time of injury

| Variable    | Description.                                                                    | Units     | 
|:------------|:--------------------------------------------------------------------------------|:----------|
|`Group`      |Injury method. OA = oleic acid, IT = + intratracheal LPS, IV = + intravenous LPS |           | 
|`Weight`     |Animal weight                                                                    |kg         | 
|`Vt`         |Tidal volume                                                                     |mL         | 
|`Min_vol`    |Minute volume                                                                    |L/min      | 
|`FiO2`       |Inspired fraction of oxygen                                                      |           | 
|`PEEP`       |Positive end-expiratory pressure                                                 |cmH2O      |
|`Pplat`      |Plateau airway pressure                                                          |cmH2O      | 
|`Cstat`      |Static lung compliance                                                           |mL/cmH2O   | 
|`ETCO2`      |End-tidal carbon dioxide                                                         |mmHg       | 
|`SpO2`       |Peripheral oxygen saturation                                                     |%          | 
|`HR`         |Heart rate                                                                       |bpm        |
|`MAP`        |Mean arterial pressure                                                           |mmHg       |
|`MPAP`       |Mean pulmonary artery pressure                                                   |mmHg       |
|`CVP`        |Central venous pressure                                                          |mmHg       |
|`NAdose`     |Noradrenaline dose                                                               |mcg/kg/min |
|`pH`         |pH                                                                               |           |
|`PaO2`       |Arterial partial pressure of oxygen                                              |mmHg       |
|`PaCO2`      |Arterial partial pressure of carbon dioxide                                      |mmHg       |
|`Bic`        |Arterial bicarbonate                                                             |mmol/L     |
|`BE`         |Base excess                                                                      |mmol/L     |
|`EF`         |Estimated shunt                                                                  |%          |
|`PF`         |Partial pressure of oxygen to inspired fraction of oxygen ratio                  |mmHg       |
|`IL6`        |Interleukin-6 concentration, plasma or broncholaveolar lavage                    |ng/mL      |
|`IL8`        |Interleukin-8 concentration, plasma or broncholaveolar lavage                    |ng/mL      |
|`IL1B`       |Interleukin-1 beta concentration, plasma or broncholaveolar lavage               |ng/mL      |
|`IL10`       |Interleukin-10 concentration, plasma or broncholaveolar lavage                   |ng/mL      |
|`BALTP`      |Bronchoalveolar lavage total protein concentration                               |mcg/mL     |
|`Hb`         |Haemaglobin                                                                      |g/L        |
|`Hct`        |Haematocrit fraction                                                             |           |
|`WCC`        |White cell count                                                                 |x10^9/L    |
|`Neut`       |Neutrophil count                                                                 |x10^9/L    |
|`Mono`       |Monocyte count                                                                   |x10^9/L    |
|`Lymph`      |Lymphocyte count                                                                 |x10^9/L    |
|`PT`         |Prothrombin time                                                                 |s          |
|`APTT`       |Activated partial thromboplastin time                                            |s          |
|`Na`         |Sodium                                                                           |mmol/L     |
|`Cl`         |Chloride                                                                         |mmol/L     |
|`Ur`         |Urea                                                                             |mmol/L     |
|`Cr`         |Creatinine                                                                       |mmol/L     |
|`Glu`        |Glucose                                                                          |mmol/L     | 
|`Alb`        |Albumin                                                                          |g/L        |
|`Bili`       |Bilirubin                                                                        |umol/L     |
|`AST`        |Aspartate aminotransferase                                                       |IU/L       |
|`ALP`        |Alkaline phosphatase                                                             |IU/L       |
|`CK`         |Creatinine kinase                                                                |IU/L       |
|`Fluid input`|Total volume of crystalloid                                                      |L          |
|`Ur output`  |Urine output                                                                     |L          |

### Code

_For all timepoints_:

+  01_preprocessing 
+  02_mixedmodels
+  03_missingdata

_For data obtained at 6 hours_:

+  04_imputation
+  05_correlation
+  06_clustering
+  07_pca
