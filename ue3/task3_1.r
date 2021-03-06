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

# strptime not needed, because of std time format: junit$tstamp2 = as.POSIXct(strptime(junit$tstamp,"%Y-%m-%d %H:%M:S"))
junit$tstamp2 = as.POSIXct(junit$tstamp)

mode(junit$tstamp2[1])
class(junit$tstamp2[1])

#### task3-1 b) ####

junit$tstamp3 = as.numeric(junit$tstamp2)

# diff in days
diff(junit$tstamp2[1:2])
# diff in seconds
diff(junit$tstamp3[1:2])

# diff in seconds, another solution
difftime(junit$tstamp2[1],junit$tstamp2[2],units="secs")

#### task3-1 c) ####
#days and hours extracting
junit$wday <-weekdays(as.POSIXlt(junit$tstamp2,t="UTC"))
junit$hour <- strftime(as.POSIXlt(junit$tstamp2,t ="UTC"),format="%H")

#sum of activities at each weekday + minimum and maximum
table(junit$wday)
summary(as.vector(table(junit$wday)))
# -> in junit200: MIN=16 (Wednesday) MAX=69 (Sunday)
#sum of activities at each hour + minimum and maximum
table(junit$hour)
summary(as.vector(table(junit$hour)))
# -> in junit200: MIN=1  MAX=49 (14 h)

# --->  Most contributors commiting sundays from 14 to 14.59 o'clock (UTC)

#### task3-1 d) ####
#plots
plot(table(junit$wday))
plot(table(junit$hour))

#### task3-1 e) ####

#plot factor
plot(as.factor(table(junit$wday)))


#labels
plot(factor(junit$wday,labels=strtrim(levels(factor(junit$wday)),2)))
#### task3-1 f) ####
#boxplot

boxplot(log(lines_add+1,2)~developer,junit)
boxplot(log(lines_del+1,2)~developer,junit)

#### task3-1 g) ####
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

boxplot(log(lines_add+1,2)~substrRight(file,4),junit)
boxplot(log(lines_del+1,2)~substrRight(file,4),junit)

#### task3-1 h) ####
plot(density(junit$lines_add,width=1))

#width fasst werte zu einem tik zusammen

#### task3-1 i) ####
# x axis: cumulative proportion of code changes, y axis: the top N contributors to code base

# most active devs sorted
getMostActiveDevs = function (cvsFile) sort(table(myread.cvsdata(cvsFile)$developer),decreasing=T)
# amount of devs
getDevAmount = function (cvsFile) length(levels(myread.cvsdata(cvsFile) $developerf))

# amount of MRs
getMRAmount = function (cvsFile) length(myread.cvsdata(cvsFile))

# required table for MRs (TopDevs | comulative #MR in percent)
getMRPerDevAmount = function (cvs) {
			result = data.frame(TopDevs=1:getDevAmount(cvs))
			cumSumPercentage = cumsum((as.vector(getMostActiveDevs(cvs)) / getMRAmount(cvs)) / 100)
			result$cummulativePercentage= cumSumPercentage
			return(result)
}


plot(getMRPerDevAmount("data/junit200.tsv"))
lines(stats::lowess(getMRPerDevAmount("data/junit200.tsv")))

=======

byMRPlot <- cumsum(sort(table(junit$developer),decreasing=T))/(sum(table(junit$developer)))
mrplot <- data.frame(names(byMRPlot))
mrplot$x <- byMRPlot
names(mrplot) <- c("Developer", "MR")

lines_add<- data.frame(aggregate(junit$lines_add, by=list(Developer=junit$developer), FUN=sum))
lines_add$x <-lines_add$x/sum(junit$lines_add)
lines_del<- data.frame(aggregate(junit$lines_del, by=list(Developer=junit$developer), FUN=sum))
lines_del$x <-lines_del$x/sum(junit$lines_del)
names(lines_add)<-c("Developer","lines added")
names(lines_del)<-c("Developer","lines deleted")

mrplot <- merge(mrplot,lines_add,by="Developer")
mrplot <- merge(mrplot,lines_del,by="Developer")

#
plot(byMRPlot,type="l",xlab="Number of individuals",ylab="")

