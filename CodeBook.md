Code Book
==========

This code book describes meta data and data manipulations performed on the 
original data set to make the data set suitable for further processing in R 
programming environment.

Additional data set manipulations were performed that create additional data sets
to meet specific requirements of the data cleaning course by Jeff Leek, Ph.D, 
CoursEra, April 2014.

The code in this repository consists of:
chk_packages.R -- to check and install required packages to perform transformations 
described in this Code Book.
run_analys.R -- to perform actual transformations.

Note: All transformations are performed by using data.table package version 1.9.2.
"data.table" is rapidly evolving package; using an older or significantly newer 
version may yield incorrect results. Validity of current results were confirmed
using "sqldf" package; cross-checkes are commented in the run_analysis script. 

Transformations Performed:
--------------------------

* Test and Train datasets were merged together.

* Activity IDs (y feature vector) was merged for training and testing data sets.

* Subject identification were merged for training and testing data sets.

### Feature Name Cleaning
 * I have identified that some feature names were repetitive. Further examination 
  confirmed that features are likely missing tri-axial identifications. 
  Making this assumption I have restored (_X_, _Y_, _Z_ labels) for the features 
  that contain bandsEnergy measurements. These affected features 303-344, 382-423 and
  461-502
 * Feature labels that contained "()" were replaced with "_" to make feature names
   suitable for use in R programming environment.
 * Feature labels that contained "," were further replaced with "_" for the same 
   reasons.

Data Manipulations
------------------
* A single table data frame was formed by joining feature data set, subject labels and
activity identifiers.
* Data set than was further joined to activity labels using activity identifiers.
* Activity identifiers were removed from the data set. This data set is names sData.
  Note: it is a bit unlcear to me if this data set is to be included or not. I
  have seen interpretations that only Means and Standard Deviations data set
  is included in the final submision. I am including it for completness.
* A separate data set was created that contains subject identifier, Activity Label and
  features that correspond to means and standard deviations for each measurement. These
  features contain _mean_ and _std_ identifiers in the feature names. This data set is 
  named sMeanStd.
  I have made following interpretation of the requirements:
  features that include mean() and std() need to be included in this data set.
  Features that include meanFreq() also need to be included. Example: 
  fBodyBodyGyroJerkMag-meanFreq() as it indicates a feature that is a mean of a 
  measurement. On the other hand angle(tBodyAccJerkMean),gravityMean) would not
  be included as it does not represent the mean.
* A separate data set was created that contain mean variable measurement for each subject
  and activity. This data set is named sAvg. 
  
Note: I find that instructions are a bit unclear as to what data set is averaged. 
I have averaged 561-feature vector by subject and activity. Some interpretations 
only average out mean and standard deviation feature vector which is simple 
subset of my result.
It can be computed as sAvg[,idxMeanStd,with=F] ;
it is the only reason I left idxMeanStd with this data set.

Resulting Data Sets
-------------------
After sourcing run_analysis.R you will get sMeanStd, sAvg and sData data sets in your 
environment described above. These data sets are in the format of table data frame that
enables fast in-memory operations. You may want to convert data sets using 
as.data.frame() function if you prefer a more traditional data frame objects. 
Some operations are defined differently for "data.table" objects from 
"data.frame" objects please reference 
http://datatable.r-forge.r-project.org/datatable-faq.pdf
for more information.