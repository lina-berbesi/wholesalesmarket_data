
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(dplyr))

demand_mom_tmp<-read.csv("Documents/Github/wholesalesmarket_data/demand_MoM_2019to2023.csv",skip=11)
colnames(demand_mom_tmp)<-c("start","end","id","region","demand_gwh","demand_dollars")
demand_mom<-demand_mom_tmp %>% 
            mutate(month=as.Date(start,format="%d/%m/%Y")) %>%
            dplyr::select(month,id,demand_gwh,demand_dollars) 

View(demand_mom)

generation_mom_tmp<-read.csv("Documents/Github/wholesalesmarket_data/generation_MoM_2019to2023.csv",skip=11)
colnames(generation_mom_tmp)<-c("start","end","id","region","generation_gwh","generation_dollars")
generation_mom<-generation_mom_tmp %>% 
                mutate(month=as.Date(start,format="%d/%m/%Y")) %>%
                dplyr::select(month,id,generation_gwh,generation_dollars) 

View(generation_mom)

cols <- c("demand"="#69b3a2","generation"="#0000ff")
          
ggplot() +
  geom_line(data=demand_mom, mapping=aes(x=month,y=demand_gwh,color="demand")) +
  geom_line(data=generation_mom, mapping=aes(x=month,y=generation_gwh,color="generation")) +
  labs(title="Demand vs Generation in Aotearoa New Zealand", subtitle="electricity authority",caption="Note: Peaks occur during Q3 of each year Jul-Aug") + ylab("GWh") +
  scale_colour_manual(name="Series",values=cols) 


