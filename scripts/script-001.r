library(readr)
library(stringr)
library(base)
library(readxl)
#####
directories=Sys.glob('/path/to/multiple/numerical50/tab/delimited/data/[0-9]*/txt/tab.txt')
columns=c("data","variables","n","n1","n2","n3","n4","n5","n6","n7")

excel=read_excel('/path/to/data/excel.xlsx') 
# n where n is a numerical
remove=excel[n]
#####
numextract <- function(string){ 
str_extract(string, "\\-*\\d+\\.*\\d*")
} 
Numextract <- function(string){
  unlist(regmatches(string,gregexpr("[[:digit:]]+\\.*[[:digit:]]*",string)))
}
multmerge = function(mypath){
filenames= list.files(path=mypath, full.names=TRUE,pattern='*.csv')
datalist = lapply(filenames, function(x){read.csv(file=x,header=T)})
Reduce(function(x,y) {merge(x,y)}, datalist)}
#####

for (i in 1:length(directories)) {
	data=read.table(directories[i],sep='\t',header=TRUE)
	data=data[,columns]
	data=data[grep(paste(remove,collapse="|"),data$n),]
	colnames(data)[which(colnames(data) %in% c("data","variables","n"))] <- c(paste("data",Numextract(directories[i])[3],sep='.'),paste("variables",Numextract(directories[i])[3],sep='.'),paste("n",Numextract(directories[i])[3],sep='.'))
	for (ii in 4:10){
		colnames(data)[ii] <- paste(grep('n*',colnames(data)[ii],perl=TRUE,value=TRUE),Numextract(directories[i])[3],sep='.')
	}
	write.csv(data,paste(Numextract(directories[i])[3],'data','csv',sep='.'),row.names=FALSE)
}


write.csv(multmerge('/path/to/multiple/numerical50/tab/delimited/data/'),'data.csv')









