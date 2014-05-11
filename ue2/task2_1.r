#### Übung 2: Empirische Bewertung - Abgabe: Christoph Krüger, Robert Fels ####

####### task 2_1 a) + b) #######
#read data into data.frame
origFile = read.delim("data/junit200.tsv",as.is=T)
is.data.frame(origFile)

#add developer and file as factor
origFile$developerf <- as.factor(origFile$developer)
origFile$filef <- as.factor(origFile$file)
colnames(origFile)
origFile$developerf;origFile$filef

#delete description column
origFile = subset(origFile,select=-description)
colnames(origFile)

#get an overview over data
names(origFile)
nrow(origFile)
str(origFile)
summary(origFile)

# function to get that type of data set
myread.cvsdata = function(csvFile) {
	result= read.delim(csvFile,as.is=T)
	result$developerf <-as.factor(result$developer)
	result$filef <-as.factor(result$file)
	result = subset(result, select=-description)
	return(result)
}

summary(myread.cvsdata("data/junit.tsv"))
summary(myread.cvsdata("data/jikes.tsv"))
summary(myread.cvsdata("data/zile.tsv"))
	
####### task 2_1 c) #######

getDevAmount = function (csvFile) length(levels(myread.cvsdata(csvFile) $developerf))
getDevAmount("data/junit.tsv")

get5MostActiveDevs = function (cvsFile) sort(table(myread.cvsdata(cvsFile)$developer),decreasing=T)[1:5]
get5MostActiveDevs("data/jikes.tsv")

nrow(unique(origFile["developer"]))
sort(table(origFile["developer"]))

##I think this is wrong, at least the results are not that good or I'm doing it wrong^^
table(unique(origFile[c("developer","file")])["developer"])
table(unique(origFile[c("developer","file")])["developer"])/nrow(unique(origFile["file"]))

##my approach
# number of files existing
fileNum = nlevels(origFile$filef)
# colums to observe and to transform
devsAndFiles = origFile[c("developer","file")]

# transform that to this form (as table, list, matrix, data.frame or whatever- I HAVE NO IDEA HOW TO DO THIS) :
#    dev1   dev2   dev3   ...   devn
#    filey  filex  ...    ...   ...
#    filex  filey  ...    ...   ...
#    filey  filez  ...    ...   ...
#    ...    ...    ...    ...   ...

####### task 2_1 d) #######
myanalyze.cvsdata<-function(x){
list(
     "#developers"=nrow(unique(x["developer"])),
     "#commits"=sort(table(x["developer"])),
     "#of files with commits"=table(unique(x[c("developer","file")])["developer"]),
     "%of files with commits"=table(unique(x[c("developer","file")])["developer"])/nrow(unique(x["file"]))
     )
}

