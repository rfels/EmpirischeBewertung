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
# weekday column
junit$wday = weekdays(junit$tstamp2)
# hour column
junit$hour = format(junit$tstamp2,format="%H")

#sum of activities at each weekday + minimum and maximum
table(junit$wday)
summary(as.vector(table(junit$wday)))
# -> in junit200: MIN=16 (Friday) MAX=73 (Sunday)
#sum of activities at each hour + minimum and maximum
table(junit$hour)
summary(as.vector(table(junit$hour)))
# -> in junit200: MIN=1  MAX=51 (15 h)

# --->  Most contributors commiting sundays from 15 to 15.59 o'clock

