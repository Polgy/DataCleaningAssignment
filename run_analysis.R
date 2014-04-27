#run_analysis.R


#### input verification:
if (file.exists("UCI HAR Dataset"))
  samsungDir <- "UCI HAR Dataset"
if (file.exists('C:/Temp/UCI HAR Dataset'))
  samsungDir <- 'C:/Temp/UCI HAR Dataset'
if (is.na(samsungDir))
  stop ('did not find "UCI HAR Dataset" in local directory or C:/Temp. Stopped.')

#### load required packages:
source("chk_packages.R")
checkPkgs(c("data.table"))
library(data.table)
#### cross testing only: library(sqldf)


message("reading data set and performing transformations")
#### read metadata - activity labels:
fFeatures <-fread( sprintf("%s/%s", samsungDir, "features.txt"),header=FALSE)
####head(fFeatures)
####tail(fFeatures)
fLabels   <-fread( sprintf("%s/%s", samsungDir, "activity_labels.txt"),
                   header=FALSE)
setnames(fLabels, c("V1","V2"), c("ActID","Activity"))

#### reading feature files smaller test set first and large train set second.
##### timing to confirm that defining colClasses cuts execution time in 3
system.time(sTst <- data.table(read.table(sprintf("%s/test/%s", samsungDir, "X_test.txt"),
                               header=FALSE,sep="")))

yTst <-fread(sprintf("%s/test/%s", samsungDir, "y_test.txt"),header=F)
subjTst <-fread(sprintf("%s/test/%s", samsungDir, "subject_test.txt"),header=F)

fClasses <- sapply(sTst, class)

system.time(sTrn <- data.table(read.table(sprintf("%s/train/%s", samsungDir, "X_train.txt"),
                               header=FALSE,sep="",colClasses=fClasses)))

yTrn   <-fread(sprintf("%s/train/%s", samsungDir, "y_train.txt"),header=F)
subjTrn<-fread(sprintf("%s/train/%s", samsungDir, "subject_train.txt"),header=F)

#Requirement 1: Merge the training and the test sets to create one data set
#### merging data sets

sData <-rbind(sTrn, sTst)

y<-rbind(yTrn,yTst)

subj <- rbind(subjTrn, subjTst)

setnames(y,"V1", "ActID")
setnames(subj,"V1", "Subject")

sData<-cbind(sData, subj, y)

#### remove intermediate data
rm(sTrn, sTst, y, subj, yTrn, yTst, subjTst, subjTrn, samsungDir, fClasses )

#### some verification
#### table(sapply(sData, class))

#Requirement 3: Uses descriptive activity names to name the activities in the data set
##Step 6: setting up feature names 
fNames <- gsub('-','_', fFeatures[[2]], perl=T)

#### original feature names contain duplicates as could be confirmed by code below
#### originalDups<-duplicated(fFeatures[[2]])
#### original names are duplicated lets find them
#### and see if the values for the fields are duplicated too
#### columns are in ether once or 3 times table(table(fNames))


#### replacing duplicate names. Assigning missing component vectors
####  X, Y and Z 14 in a row for each one:
renameDupRange <- function  (cVect, f, repl=NULL ) {
  #####debug print (sprintf("index  at %s repl is %s", f, repl) )
  repl= { if(is.null(repl)) '_X' else repl}

  idx=seq(from=f, length.out=14)
  cVect[idx] <- gsub('\\(\\)', repl, cVect[idx], perl=T)
  
  if (repl=="_X") { 
    cVect<- renameDupRange(cVect,f+13, repl='_Y')
  }
  if (repl=="_X") {
    cVect<- renameDupRange(cVect,f+26, repl='_Z')
  }
  
  return(cVect)
}

fNames<-renameDupRange(fNames, 303)
fNames<-renameDupRange(fNames, 382)
fNames<-renameDupRange(fNames, 461)

#### replacing special characters in names with _ :
fNames <- gsub('\\(\\)','', fNames, perl=T)
fNames <- gsub('-','_', fNames, perl=T)
fNames <- gsub('\\(','_', fNames, perl=T)
fNames <- gsub('\\)','_', fNames, perl=T)
fNames <- gsub(',','_', fNames, perl=T)
fNames <- gsub('_$','', fNames, perl=T)
#fNames <- c(fNames,"subject", "label")

#### setting names for the features, last two are alredy set by us
oNames <-names(sData)
setnames(sData, oNames, c(fNames, oNames[562:563]))

#Requirement 3: Uses descriptive activity names 
setkey(fLabels, ActID)
setkey(sData, ActID)
sData <- sData[fLabels]
#### Remove ActID column
invisible(sData[,ActID := NULL])

# Requirement 2: Extracts only the measurements on the mean and 
# standard deviation for each measurement.
idxMeanStd <- grep("mean|std",ignore.case=F, fNames)
#### this will capture values like fBodyBodyGyroJerkMag-meanFreq()
#### and will ignore angle values: angle(tBodyGyroJerkMean,gravityMean)
#### since angle values are not means itself

#### lets create table data frame with features that represent means 
#### in my interpretation
sMeanStd<-sData[,c(idxMeanStd,562,563),with=F]



#REQ5: Creates a second, independent tidy data set with the average of each 
#variable for each ActID and each subject. 
#### Calculating mean or average values
##### cross check:
#####sv1<-sqldf("select Subject, ActID, avg(V1) from SF group by Subject, ActID")
#####tv1<-S1[,sum(V1), by = "Subject,ActID"]
##### test: identical(tv1[[1]], sv1[[1]])
##### can be repeated for any column/feature
sAvg<-sData[,lapply(.SD,mean),by="Subject,Activity"] 

## clean up intermediate name objects
rm(fNames, oNames, renameDupRange, fFeatures, fLabels, checkPkgs)
