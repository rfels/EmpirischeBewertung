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
#### task3-1 c) ####
#days and hours extracting
junit$wday <-weekdays(junit$tstamp2)
junit$hour <- strftime(as.POSIXlt(junit$tstamp2,t ="UTC"),format="%H")

#### task3-1 d) ####
#plots
plot(table(junit$wday))
plot(table(junit$hour))

#### task3-1 e) ####
#labels
plot(factor(junit$wday,labels=strtrim(levels(factor(junit$wday)),2)))
#### task3-1 f) ####
#boxplot

boxplot(log(lines_add+1,2)~developer,junit)
boxplot(log(lines_del+1,2)~developer,junit)

#### task3-1 g) ####

#### task3-1 h) ####
plot(density(junit$lines_add,width=1))

#width fasst werte zu einem tik zusammen

