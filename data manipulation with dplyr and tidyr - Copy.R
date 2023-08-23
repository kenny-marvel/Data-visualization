install.packages("dplyr")
library(dplyr)

install.packages('nycflights13')
library('nycflights13')

View(flights)
head(flights)

#subset dataset using filter

f1<-filter(flights,month==07)
View(f1)

f2<-filter(flights,month==07,day==3)
f2
View(f2)

View(filter(flights,month==09,day==2,origin=='LGA'))

#OR
head(flights[flights$month==09 & flights$day==2 & flights$origin=='LGA',])

#Slice() allows us to select rows by position

slice(flights,1:5)
slice(flights,5:10)

#mutate() is used to add a new column
over_delay<-mutate(flights,overall_delay=arr_delay-dep_delay)
View(over_delay)
View(flights)
head(over_delay)

#transmute() function is used to show only new column
over_delay<-transmute(flights,overall_delay=arr_delay-dep_delay)
View(over_delay)

#summarise()used to find descriptive statistics
summarise(flights,avg_air_time=mean(air_time,na.rm=T))
summarise(flights,tot_air_time=sum(air_time,na.rm=T))
summarise(flights,stdev_air_time=sd(air_time,na.rm=T))
summarise(flights,avg_air_time=mean(air_time,na.rm=T),tot_air_time=sum(air_time,na.rm=T))
 
#group by calculation using group_by()

#Example1
head(mtcars)
View(mtcars)

by_gear<-mtcars%>% group_by(gear)

by_gear
View(by_gear)


a<-summarise(by_gear,gear1=sum(gear),gear2=mean(gear))
a

summarise(group_by(mtcars,cyl), mean(gear,na.rm=TRUE))

b<-by_gear %>% summarise(gear1=sum(gear),gear2=mean(gear))
b

#Example 2

by_cyl<-mtcars %>% group_by(cyl)
by_cyl %>% summarise(
  gear=mean(gear),
  hp=mean(hp)
)
head(by_cyl)

#sample_n()and  sample_frac for creating samples
sample_n(flights,15)#gives 15 random samples
sample_frac(flights,0.4) #return 40% of the total data

#arrange() used to sort dataset
View(arrange(flights,year,dep_time))
head(arrange(flights,desc(dep_time)))

#usage of pipe operator 
df<-mtcars
df
View(mtcars)

#Nesting
result<-arrange(sample_n(filter(df,mpg>20),size=5),desc(mpg))
View(result)

#multiple assignment
a<-filter(df,mpg>20)
b<-sample_n(a,size=5)
result<-arrange(b,desc(mpg))
result

#same using pipe operator

#syntax_data %>% op1 %>% op3
result<-df %>% filter(mpg>20) %>% sample_n(size=10) %>% arrange(desc(mpg))
result

df
df_mpg_hp_cyl=df %>% select(mpg,hp,cyl)
head(df_mpg_hp_cyl)

#.............Data Manipulation using Tidyr..........

install.packages('tidyr')
library('tidyr')

n=10
wide<-data.frame(
  ID =c(1:n),
  Face.1 =c(411,723,325,456,579,612,709,513,527,379),
  Face.2 =c(123,300,400,500,600,654,789,906,413,567),
  Face.3 =c(1457,1000,569,896,956,2345,780,599,1023,678)
)
View(wide)

#Gather()-Reshaping data frame from wide format to long format
long<-wide %>% gather(Face, ResponseTime, Face.1:Face.3)
View(long)

#separate()-splits a single column into mul;tiple column
long_separate<-long %>% separate(Face,c("target","Number"))
View(long_separate)

#Unite()-combines multiple column into a single column
long_unite<-long_separate %>% unite(Face, target, Number, sep=",")
View(long_unite)

#spread()-takes two column (key&value)and spreads into multiple column
#it makes"long"data wider

back_to_wide<-long_unite %>% spread(Face, ResponseTime)
View(back_to_wide)
     

















































































































