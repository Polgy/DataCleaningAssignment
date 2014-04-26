Data Set Description
====================

The original features selected for this database come from the accelerometer and 
gyroscope 3-axial raw signals.
Accelerometer signal names are denoted as Acc and Gyroscope signals are denoted 
as Gyro. 
These time domain have prefix "t". 

Tri-dimensional signals are coded with either
X,Y or Z.

Subsequently, the body linear acceleration and angular velocity were derived in 
time to obtain Jerk signals (tBodyAccJerk and tBodyGyroJerk). Also the magnitude 
of these three_dimensional signals were calculated using the Euclidean norm 
(tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals.
Fast Fourier Transform signal names are prefixed by "f" to indicate frequency domain 
signals.

The list of calculate signals is :

* tBodyAcc_XYZ
* tGravityAcc_XYZ
* tBodyAccJerk_XYZ
* tBodyGyro_XYZ
* tBodyGyroJerk_XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc_XYZ
* fBodyAccJerk_XYZ
* fBodyGyro_XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean_: Mean value
* std_: Standard deviation
* mad_: Median absolute deviation
* max_: Largest value in array
* min_: Smallest value in array
* sma_: Signal magnitude area
* energy_: Energy measure. Sum of the squares divided by the number of values.
* iqr_: Interquartile range
* entropy_: Signal entropy
* arCoeff_: Autorregresion coefficients with Burg order equal to 4
* correlation_: correlation coefficient between two signals
* maxInds_: index of the frequency component with largest magnitude
* meanFreq_: Weighted average of the frequency components to obtain a mean frequency
* skewness_: skewness of the frequency domain signal
* kurtosis_: kurtosis of the frequency domain signal
* bandsEnergy_: Energy of a frequency interval within the 64 bins of the FFT of
* each window.
* angle_: Angle between to vectors.


Additional vectors obtained by averaging the signals in a signal window sample. 
These are used on the angle_ variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean


