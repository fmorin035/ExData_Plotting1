c4w1<-read.delim("household_power_consumption.txt",header=TRUE,sep=";", nrows = 133000)
c4w1<-as_tibble(c4w1)
test<-mutate(c4w1,positdate=paste(Date,Time))
test2<-mutate(test,realtime=strptime(positdate,format= "%d/%m/%Y %H:%M:%S"))
test3<-test2%>% mutate_at(c("Date"), as.Date,format="%d/%m/%Y")
test4<-filter(test3, Date >="2007-02-01" & Date <= "2007-02-02")
test5<-mutate_at(test4,c("Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2"),as.numeric)

with(test5, plot(realtime, Sub_metering_1,type = "l",ylab = "Energy sub metering",xlab = "")) 
with(test5, lines(realtime,Sub_metering_2,col= "Red"))
with(test5, lines(realtime,Sub_metering_3,col="Blue"))

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),col=c("black", "red", "blue"), lty=1, cex=0.5,text.font=3)

dev.copy(png, file = "plot3.png")
dev.off()
