 

# Download monthly demand for total New Zealand

start<-"20190101"
end<-"20231031"

url_generic_dem<-paste0("https://www.emi.ea.govt.nz/Wholesale/Download/DataReport/CSV/W_GD_C?DateFrom=",start,"&DateTo=",end,"&RegionType=NZ&TimeScale=MONTH")
download.file(url_generic_dem,"Documents/Github/wholesalesmarket_data/demand_MoM_2019to2023.csv",quiet=FALSE)

# Download monthly generation for total New Zealand

url_generic_gen<-paste0("https://www.emi.ea.govt.nz/Wholesale/Download/DataReport/CSV/W_GG_C?DateFrom=",start,"&DateTo=",end,"&RegionType=NZ&TimeScale=MONTH")
download.file(url_generic_gen,"Documents/Github/wholesalesmarket_data/generation_MoM_2019to2023.csv",quiet=FALSE)

# Creating sequence of dates to extract quarterly data

start_month_beg<-as.Date("2019-01-01")   
start_month_lst<-as.Date("2019-03-31")  
end_month_lst<-as.Date("2023-09-30") 
dates_list_start<-seq(start_month_beg,end_month_lst,by="quarter") 
dates_list_end<-seq(start_month_lst + 1,end_month_lst + 1,by="3 months") -1   

dates_df<-data.frame(start=dates_list_start,
                     end=dates_list_end)

# Remove dash from dates

dates_df<-apply(dates_df, 2, function(x) as.numeric(gsub("-", "", x)))


# Function to download the data from the ea webpage by Point Of Connection POC

download_url<-function(i) {
  month<-substr(dates_df[i,c("start")],start=5,stop=6)
  year<-substr(dates_df[i,c("start")],start=1,stop=4)
  start<-as.character(dates_df[i,c("start")])
  end<-dates_df[i,c("end")]
  url_generic<-paste0("https://www.emi.ea.govt.nz/Wholesale/Download/DataReport/CSV/W_GD_C?DateFrom=",start,"&DateTo=",end,"&RegionType=POC&TimeScale=DAY")
  file<-paste0("Documents/Github/demand_data_electricityauthority/files/demand_",month,year,".csv")
  download.file(url_generic,file,quiet=FALSE)
}

lapply(1:nrow(dates_df),download_url)








