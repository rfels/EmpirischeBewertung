repNum=100000 # number of Repitions
diceRun = sample(1:6,repNum,replace=T) #create 100000 dice throws
cpDice = diceRun # copy of dice throws
wishedSeq = c(3,4,5) # wished sequence

matr1=matrix(cpDice,nrow=3)  
matr1=matr1[,-dim(matr1)[2]] # delete last column because it is invalid (recycled last column)
counter= sum(apply(matr1,2, function(x) all(x==wishedSeq))) # count all equal Sequences, in sum T equals 1 and F equals 0
cpDice <- cpDice[-1] # delete first element 
matr2=matrix(cpDice,nrow=3)
counter= counter + sum(apply(matr2,2, function(x) all(x==wishedSeq)))
cpDice <- cpDice[-1] # delete first element 
matr3=matrix(cpDice,nrow=3)
matr3=matr1[,-dim(matr3)[2]] # delete last column because it is invalid (recycled last column)
counter= counter + sum(apply(matr3,2, function(x) all(x==wishedSeq)))
counter




### first approach with call by reference function didn't work ####
## function which compares the first 3 elements of a list 
#checkFirst3 = function(x) {
#	result <- all(x[1:3]==wishedSeq)
#	eval.parent(substitute(x<-x[-1])) # delete first element (call by reference)
#	return(result)
#}

#replicate(repNum-2,cpDice=cpDice[-1],checkFirst3(cpDice))