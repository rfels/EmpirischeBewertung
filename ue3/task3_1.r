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

#### task3-1 h) ####
plot(density(junit$lines_add,width=1))

#width fasst werte zu einem tik zusammen

#### task3-1 i) ####
# x axis: cumulative proportion of code changes, y axis: the top N contributors to code base
byMRPlot <- cumsum(sort(table(junit$developer),decreasing=T))/(sum(table(junit$developer)))
plot(byMRPlot,type="l")

