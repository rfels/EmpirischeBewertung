#### Übung 3: Empirische Bewertung - Abgabe: Christoph Krüger, Robert Fels ####

# function to get that type of data set
myread.cvsdata = function(csvFile) {
	result= read.delim(csvFile,as.is=T)
	result$developerf <-as.factor(result$developer)
	result$filef <-as.factor(result$file)
	result = subset(result, select=-description)
	return(result)
}

junit = myread.cvsdata("data/junit200.tsv")



#### task3-1 a) ####

junit$tstamp2 = as.POSIXct(junit$tstamp)

mode(junit$tstamp2[1])
class(junit$tstamp2[1])

#### task3-1 b) ####

junit$tstamp3 = as.numeric(junit$tstamp2)

# diff in days
diff(junit$tstamp2[1:2])
# diff in seconds
diff(junit$tstamp3[1:2])

