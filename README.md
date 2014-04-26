Data Cleaning Assignment
========================

The original features selected for this database come from the accelerometer and 
gyroscope 3-axial raw signals denoted tAcc_XYZ and tGyro_XYZ. These time domain 
signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then 
they were filtered using a median filter and a 3rd order low pass Butterworth filter 
with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal
 was then separated into body and gravity acceleration signals 
 (tBodyAcc_XYZ and tGravityAcc_XYZ) using another low pass Butterworth filter with a 
 corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time 
to obtain Jerk signals (tBodyAccJerk_XYZ and tBodyGyroJerk_XYZ). Also the magnitude 
of these three_dimensional signals were calculated using the Euclidean norm 
(tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing 
fBodyAcc_XYZ, fBodyAccJerk_XYZ, fBodyGyro_XYZ, fBodyAccJerkMag, fBodyGyroMag, 
fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'_XYZ' is used to denote 3_axial signals in the X, Y and Z directions.

tBodyAcc_XYZ
tGravityAcc_XYZ
tBodyAccJerk_XYZ
tBodyGyro_XYZ
tBodyGyroJerk_XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc_XYZ
fBodyAccJerk_XYZ
fBodyGyro_XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean_: Mean value
std_: Standard deviation
mad_: Median absolute deviation 
max_: Largest value in array
min_: Smallest value in array
sma_: Signal magnitude area
energy_: Energy measure. Sum of the squares divided by the number of values. 
iqr_: Interquartile range 
entropy_: Signal entropy
arCoeff_: Autorregresion coefficients with Burg order equal to 4
correlation_: correlation coefficient between two signals
maxInds_: index of the frequency component with largest magnitude
meanFreq_: Weighted average of the frequency components to obtain a mean frequency
skewness_: skewness of the frequency domain signal 
kurtosis_: kurtosis of the frequency domain signal 
bandsEnergy_: Energy of a frequency interval within the 64 bins of the FFT of 
each window.
angle_: Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. 
These are used on the angle_ variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean


